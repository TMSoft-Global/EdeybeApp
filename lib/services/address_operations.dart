import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edeybe/controllers/address_controller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/models/deliveryModel.dart';
import 'package:edeybe/screens/address_screen/address_screen.dart';
import 'package:edeybe/services/server_operation.dart';
import 'package:flutter/material.dart';

class AddressOperations extends ServerOperations {
  // final _addressController = Get.put(AddressController());
  String path = "/account/deliveryaddresses";
  addAddressRequest(Map data, Function(dynamic address) onResponse) {
    print(data);
    dynamicRequest(
      showDialog: true,
      method: "POST",
      path: path,
      schema: jsonEncode(data),
      onResponse: (val) {
        if (val.containsKey("success")) {
          // _addressController.getAllDeliveryAddresses();
          print(val);
          Get.back();
          onResponse(val);
        } else {
          Get.defaultDialog(
            title: 'Failed',
            content: Text("Failed to add delivery address"),
            radius: 10.0,
          );
        }
        // if (val != null) {
        //   Get.back();
        // }
      },
    );
  }

  getAllAddresses(void onResponse(List<DeliveryAddress> response),
      void onShip(dynamic), void onError(DioError error)) {
    dynamicRequest(
      path: path,
      schema: "",
      method: "GET",
      onError: onError,
      onResponse: (res) {
        // onResponse(res);
        var data = (res['success']['shippingAddress']['deliveryAddresses']
                as List<dynamic>)
            .map((dynamic i) =>
                DeliveryAddress.fromJson(i as Map<String, dynamic>))
            .toList();
        var ship = ShippingAddress(
          lastName: res['success']['shippingAddress']['lastName'],
          firstName: res['success']['shippingAddress']['firstName'],
          email: res['success']['shippingAddress']['email'],
          phone: res['success']['shippingAddress']['phone'],
        );
        onResponse(data);
        onShip(ship);
        print(ship.firstName);

        // var data = (res['success']['shippingAddress']);
      },
    );
  }

  deleteAddress(String id, void onResponse(Map<String, dynamic> response),
      void onError(DioError error)) {
    print(id);
    dynamicRequest(
        path: "$path?id=$id",
        schema: "",
        onError: onError,
        method: "DELETE",
        onResponse: (val) {
          // _addressController.getAllDeliveryAddresses();

          print(val);
          onResponse(val);
        });
  }
}
