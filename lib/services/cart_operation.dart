import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edeybe/models/deliveryCost.dart';
import 'package:edeybe/models/product.dart';
import 'package:edeybe/services/server_operation.dart';

class CartOperation extends ServerOperations {
  getAllCartItems(
      void onResponse(List<Product> response), void onError(DioError error)) {
    dynamicRequest(
      path: "/getcart",
      schema: "",
      onError: onError,
      onResponse: (res) {
        if (res.containsKey("items")) {
          var data = (res["items"] as List<dynamic>)
              .map((dynamic i) => Product.fromJson(i as Map<String, dynamic>))
              // .sortedByNum((element) => element.id)
              .toList();
          onResponse(data);
        }
      },
    );
  }

  updateCart(Map<String, dynamic> data, void onResponse(List<Product> response),
      void onError(DioError error)) {
    dynamicRequest(
      path: "/updatecart",
      schema: jsonEncode(data),
      method: "PUT",
      onError: onError,
      onResponse: (res) {
        var data = (res["items"] as List<dynamic>)
            .map((dynamic i) => Product.fromJson(i as Map<String, dynamic>))
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
      onError: onError,
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
        onResponse(location["Table"][0]);
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
        onResponse(location["Table"][0]);
      },
    );
  }
}
