import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/models/deliveryCost.dart';
import 'package:edeybe/models/productModel.dart';
import 'package:edeybe/services/server_operation.dart';
import 'package:edeybe/widgets/custom_dialog.dart';

class CartOperation extends ServerOperations {
  getAllCartItems(void onResponse(List<ProductModel> response),
      void onError(DioError error),cartCost(ProductCost productCost)) {
    dynamicRequest(
      path: "/getcart",
      schema: "",
      onError: onError,
      onResponse: (res) {
        if (res.containsKey("items")) {
          var data = (res["items"] as List<dynamic>)
              .map((dynamic i) =>
                  ProductModel.fromJson(i as Map<String, dynamic>))
              // .sortedByNum((element) => element.id)
              .toList();
          ProductCost productCost = ProductCost(
              numberOfItems: res['numberOfItems'], total: res['total']);
          onResponse(data);
          cartCost(productCost);
        }
      },
    );
  }

  updateCart(
      Map<String, dynamic> data,
      void onResponse(List<ProductModel> response),
      void onError(DioError error)) {
        print(data);
    dynamicRequest(
      path: "/updatecart",
      schema: jsonEncode(data),
      method: "PUT",
      onError: onError,
      showDialog: true,
      onResponse: (res) {
        print(res);
        var data = (res["items"] as List<dynamic>)
            .map(
                (dynamic i) => ProductModel.fromJson(i as Map<String, dynamic>))
            .toList();
        onResponse(data);
      },
    );
  }

  placeOrder(
      Map<String, dynamic> data,
      void onResponse(Map<String, dynamic> response),
      void onError(DioError error)) {
    dynamicRequest(
      path: "/payment/direct",
      schema: jsonEncode(data),
      onError: (onError) {
        print(onError.error);
      },
      showDialog: false,
      onResponse: (res) {
        onResponse(res);
      },
    );
  }

  checkOrderStatus(
      Map<String, dynamic> data,
      void onResponse(Map<String, dynamic> response),
      void onError(DioError error)) {
    dynamicRequest(
      path: "/checkout/checksuccess",
      schema: jsonEncode(data),
      onError: onError,
      showDialog: false,
      onResponse: (res) {
        print(res);
        onResponse(res);
      },
    );
  }

  getDeliveryCost(Map<String, dynamic> data,
      void onResponse(DeliveryCost response), void onError(DioError error)) {
    dynamicRequest(
      path: "/deliveryCost",
      schema: jsonEncode({"location": data}),
      onError: onError,
      showDialog: true,
      onResponse: (res) {
        onResponse(DeliveryCost.fromJson(res));
      },
    );
  }

  getDigitalAddress(String data, void onResponse(Map<String, dynamic> response),
      void onError(DioError error)) {
    dynamicRequest(
      path: "/digitalAddressData",
      schema: jsonEncode({"digitalAddress": data}),
      onError: onError,
      showDialog: true,
      onResponse: (res) {
        Map<String, dynamic> location = jsonDecode(res);
        print(location);
        // onResponse(location["Table"][0]);
        if (location["Table"] == null) {
          Get.dialog(CustomDialog(
            title: 'Timeout error',
            content: "Cannot get your loction, please try again",
          ));
        } else {
          onResponse(location["Table"][0]);
        }
      },
    );
  }

  getClossestAddress(
      Map<String, double> data,
      void onResponse(Map<String, dynamic> response),
      void onError(DioError error)) {
    dynamicRequest(
      path: "/closestLocation",
      schema: jsonEncode({"location": data}),
      onError: onError,
      showDialog: true,
      onResponse: (res) {
        Map<String, dynamic> location = jsonDecode(res);
        print(location);
        if (location["Table"] == null) {
          Get.dialog(CustomDialog(
            title: 'Timeout error',
            content: "Cannot get your loction, please try again",
          ));
        } else {
          onResponse(location["Table"][0]);
        }
      },
    );
  }
}
