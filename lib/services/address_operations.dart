import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edeybe/models/deliveryModel.dart';
import 'package:edeybe/models/shippingAddress.dart';
import 'package:edeybe/screens/checkout_screen/index.dart';
import 'package:edeybe/services/server_operation.dart';

class AddressOperations extends ServerOperations {
  String path = "/account/deliveryaddresses";
  addAddressRequest(Map data, Function(ShippingAddress address) onResponse) {
    dynamicRequest(
      showDialog: true,
      method: "POST",
      path: path,
      schema: jsonEncode(data),
      onResponse: (val) {
        print(val);
        if (val != null) {}
        onResponse(val);
      },
    );
  }


      getAllAddresses(void onResponse(List<DeliveryAddress> response),
      void onError(DioError error)) {
    dynamicRequest(
      path: path,
      schema: "",
      method: "GET",
      onError: onError,
      onResponse: (res) {
        // onResponse(res);
          var data = (res['success']['shippingAddress']['deliveryAddresses'] as List<dynamic>)
            .map((dynamic i) => DeliveryAddress.fromJson(i as Map<String, dynamic>))
            .toList();
        onResponse(data);
        // var data = (res['success']['shippingAddress']);
      },
    );
  }
}
