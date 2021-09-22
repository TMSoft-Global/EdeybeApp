import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edeybe/models/deliveryModel.dart';
import 'package:edeybe/services/server_operation.dart';

class AddressOperations extends ServerOperations {
  String path = "/account/deliveryaddresses";
  addAddressRequest(Map data, Function(dynamic address) onResponse) {
        print(data);
    dynamicRequest(
      showDialog: true,
      method: "POST",
      path: path,
      schema: jsonEncode(data),
      onResponse: (val) {
        // print(val);
        if (val != null) {

        onResponse(val);
        }
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

  deleteAddress(String id,void onResponse(Map<String, dynamic> response),
  void onError(DioError error)){
  print(id);
    dynamicRequest(path: "$path?id=$id", schema: "", 
    onError: onError,
    method: "DELETE",
    onResponse: (val){
      print(val);
      onResponse(val);
    });

  }
}
