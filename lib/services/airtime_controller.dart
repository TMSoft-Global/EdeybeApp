import 'dart:convert';

import 'package:edeybe/index.dart';
import 'package:edeybe/services/server_operation.dart';
import 'package:edeybe/widgets/custom_dialog.dart';
import 'package:edeybe/widgets/custom_web_view.dart';
import 'package:flutter/material.dart';

class AirtimeController extends ServerOperations {
  buyAirtime(Map<String, String> schema) {
    dynamicRequest(
        showDialog: true,
        path: '/airtime/buy/ot',
        schema: jsonEncode(schema),
        onResponse: onResponse);
  }

  showPaymentResult(String success,
      {Function(dynamic action) onDismiss}) async {
    if (Navigator.canPop(Get.context)) Navigator.pop(Get.context);

    return await Get.dialog(CustomDialog(
      title: "Payment",
      content: success,
    )).then(onDismiss);
  }

  onResponse(dynamic data) async {
    if (data.containsKey("success")) {
      if (data.containsKey("data") && data['data']['checkout_url'] != null) {
        var container = CustomWebView(
            title: "Payment",
            url: data["data"]["checkout_url"],
            onLoadFinish: (res) => showPaymentResult(res["code"] == 100
                ? "Congratulations, your Airtime purchase was successful"
                : "Failed to process payment, please try again"),
            watch: Uri.parse("KPaymentComplete"));
        if (data['data'] != null) {
          return await Get.dialog(container).then((value) {
            if (Navigator.canPop(Get.context)) Navigator.pop(Get.context);
          });
        }
      } else {
        showPaymentResult(data['success'], onDismiss: (value) {
          if (value == false) {
            if (Navigator.canPop(Get.context)) Navigator.pop(Get.context, true);
          }
        });
      }
    } else {
      return await Get.dialog(
              CustomDialog(title: "Payment", content: data["error"][0]))
          .then((value) {
        if (value == false) {
          if (Navigator.canPop(Get.context)) Navigator.pop(Get.context, true);
        }
      });
    }
  }
}
