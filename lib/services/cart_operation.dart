import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/models/deliveryCost.dart';
import 'package:edeybe/models/productModel.dart';
import 'package:edeybe/services/server_operation.dart';
import 'package:edeybe/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';

class CartOperation extends ServerOperations {
  getAllCartItems(void onResponse(List<ProductModel> response),
      void onError(DioError error), cartCost(ProductCost productCost)) {
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

  void productBreakdown(
      {List<Map<String, dynamic>> data,
      void onResponse(List<dynamic> response),
      void onError(DioError error)}) {
        print({"products": data});
    dynamicRequest(
        path: "/break-down-hire-purchase",
        schema: jsonEncode({"products": data}),
        onError: onError,
        onResponse: (res) {
          onResponse(res['breakDowns']);
        });
  }

  void uploadImages(File pickedFile) async {
    try {
      if (pickedFile != null) {
        var response = await uploadFile(pickedFile.path);

        // if (response != null) {
        print(response);
        // }

        // if (response.statusCode == 200) {
        //   //get image url from api response
        //   print(response.data['lg']);

        //   Get.snackbar('Success', 'Image uploaded successfully',
        //       margin: EdgeInsets.only(top: 5, left: 10, right: 10));
        // } else {
        //   Get.snackbar('Failed', 'Error Code: ${response.statusCode}',
        //       margin: EdgeInsets.only(top: 5, left: 10, right: 10));
        // }
      } else {
        Get.snackbar('Failed', 'Image not selected',
            margin: EdgeInsets.only(top: 5, left: 10, right: 10));
      }
    } finally {
      print("Error");
    }
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
      onError: (onError) {
        print(onError.message);
      },
      showDialog: true,
      onResponse: (res) {
        // print(res);
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

  checkHirePurchase(List<String> data, void onResponse(String response),
      void onError(DioError error)) {
    dynamicRequest(
      path: "/validate-items/hire-purchase",
      schema: jsonEncode({"products_id": data}),
      onError: onError,
      showDialog: true,
      onResponse: (res) {
        print(res);
        if (res.isEmpty) {
          onResponse("success");
        } else {
          onResponse("failed");
        }
      },
    );
  }

  submitHirePurchase(
      Map<String, dynamic> data, void onResponses(String response)) {
        print(data);
    dynamicRequest(
      showDialog: true,
        path: "/submit-kyc",
        schema: jsonEncode(data),
        onResponse: (onResponse){
          if(onResponse['data']['message']=="Successfull"){
            onResponses("success");
          }else{
            onResponses("failed");

          }
        });
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
        print(res);
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
