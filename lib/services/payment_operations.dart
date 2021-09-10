import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edeybe/models/card.dart';
import 'package:edeybe/screens/checkout_screen/index.dart';
import 'package:edeybe/services/server_operation.dart';
import 'package:edeybe/widgets/cart_dialog.dart';

import '../index.dart';

class PayementOperation extends ServerOperations {
  final String paymentPath = '/payment-methods';
  final String paymentOTP = '/payment-methods/otp/send';
  getAllSavedMethods(void onResponse(List<PaymentCard> response),
      void onError(DioError error)) {
    dynamicRequest(
      path: paymentPath,
      schema: "",
      method: "GET",
      onError: onError,
      onResponse: (res) {
        var data = (res['success'] as List<dynamic>)
            .map((dynamic i) => PaymentCard.fromJson(i as Map<String, dynamic>))
            .toList();
        onResponse(data);
      },
    );
  }

  deleteMethod(
      String id, void onResponse(int response), void onError(DioError error)) {
    dynamicRequest(
      path: "$paymentPath?id=$id",
      schema: "",
      method: "DELETE",
      onError: onError,
      onResponse: (res) {
        print(res);
        onResponse(res['totalPossible'] as int);
      },
    );
  }

  saveMethod(Map<String, dynamic> data, void onResponse(PaymentCard response),
      void onError(DioError error)) {
    dynamicRequest(
      path: paymentPath,
      schema: jsonEncode(data),
      showDialog: true,
      onError: onError,
      onResponse: (res) {
        // print(res);
        Get.back();
        if (res.containsKey('error')) {
          var message = res['error'] is String ? res['error'] : res['error'][0];
          Get.dialog(CartDialog(
            productTitle: message,
            type: CartItemType.Message,
            title: S.of(Get.context).paymentMethod,
          ));
        }
      },
    );
  }

  sendVerification(
      String number, void onResponse(), void onError(DioError error)) {
        print(number);

    dynamicRequest(
      path: paymentOTP,
      schema: jsonEncode({"mobileNumber": number}),
      showDialog: true,
      onError: onError,
      onResponse: (res) {
          print(res['success']);
        if (res.containsKey('error')) {
          var message = res['error'] is String ? res['error'] : res['error'][0];
          
        } else if (res.containsKey("success")){
          Get.to(PaymentMethodScreen(
                              hasContinueButton: false,
                              onContinuePressed: (pan) {
                             
        print("========================$pan");
                              },
                            ));

        //   Get.dialog(CartDialog(
        //     productTitle: "Success",
        //     type: CartItemType.Message,
        //     title: S.of(Get.context).paymentMethod,
        //   ));
        } onResponse();
      },
    );
  }
}
