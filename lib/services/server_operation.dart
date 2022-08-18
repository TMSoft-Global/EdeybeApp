import 'dart:io';

import 'package:edeybe/index.dart';
import 'package:edeybe/utils/helper.dart';
import 'package:edeybe/widgets/custom_dialog.dart';
import 'package:edeybe/widgets/loading_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Response;
import 'package:http_parser/http_parser.dart';

// final String domain = "https://6632-197-251-220-74.eu.ngrok.io";
// final String domain = "http://172.18.72.60:5002";
// http://172.18.72.108:5002/api

final String domain = "https://api.edeybe.com";
//
abstract class ServerOperations {
  // final String _domain = "http://172.18.72.60:5002";
  // final String _domain = "https://6632-197-251-220-74.eu.ngrok.io";

  final String _domain = "https://api.edeybe.com";
  final String accessToken =
      r"3KJALFDKLAkjksoem$jis0*j3ji49509u5tojifk95%#lk33#4kjjksfkjd@$$krjkrkkioaseif$2kjs@kj5l4#";
  // String _store
  // = "";
  // String _local = "en";
  // String _currency = 'GHS';

  String _cookie = "";
  bool isLoading = false;
  bool forceUpdate = false;

  Response.Dio _dio = Response.Dio();

  _getStore() async {
    // this._store = GetStorage().read("store") ?? "";
    _cookie = await GetStorage().read("cookie");
    if (_cookie == null || _cookie == "") {
      _cookie = await GetStorage().read("anony-cookie");
    }
    // this._local = GetStorage().read("local") ?? "en";
    // this._currency = GetStorage().read('currency') ?? "GHS";
  }

  notifyRequest({
    String path,
    Map<String, dynamic> schema,
  }) async {
    var response = await _dio.post("$path",
        data: schema,
        options: Response.Options(method: 'POST', headers: {
          'apikey': '$accessToken',
          'Content-Type': 'application/json',
          'platform': "mobile/${Platform.operatingSystem}",
          'token': _cookie
        }));

    print(response.data);
  }

  checkoutRequest({
    String path,
    Map<String, dynamic> schema,
    @required void onResponse(dynamic response),
    void onError(Response.DioError error),
  }) async {
    Get.dialog(
      LoadingWidget(),
      barrierDismissible: true,
    );
    var response = await _dio
        .post("$_domain/api/payment/direct",
            data: schema,
            options: Response.Options(method: 'POST', headers: {
              'apikey': '$accessToken',
              'Content-Type': 'application/json',
              'platform': "mobile/${Platform.operatingSystem}",
              'token': _cookie
            }))
        .catchError((onerror) {
      var err = onerror as Response.DioError;
      // print(err.response.data.toString());
      Get.dialog(CustomDialog(
        title: 'Timeout',
        content: 'Request Timeout, please try again',
      ));
      // String message = "${err.response.data['error'][0]}";
      Get.back();
      onError(err);
    });
    if (response != null) {
      onResponse(response.data);
      print(response.data);
    }
  }

  Future<dynamic> uploadFile(filePath) async {
    print(filePath);
    var headers = {
      'apikey': '$accessToken',
      'Content-Type': 'multipart/form-data',
      'platform': "mobile/${Platform.operatingSystem}",
    };
    if (_cookie != "" && _cookie != null) headers["token"] = _cookie;

    // try {
    FormData formData = new FormData({
      "photo": await Response.MultipartFile.fromFile(filePath,
          filename: "imageFileName",
          contentType: new MediaType('photo', 'jpg')),
    });

    Response.Response response = await Response.Dio()
        .post("http://172.18.72.108:5002/api/id-card-upload",
            data: formData,
            options: Response.Options(
                headers: headers,
                followRedirects: false,
                validateStatus: (status) {
                  return status < 500;
                }));
    print(response.statusCode);
    return response;

    // } on Response.DioError catch (e) {
    //   return e.response;
    // } catch (e) {
    //   print(e.message);
    // }
  }

  dynamicRequest(
      {@required String path,
      @required String schema,
      method = "POST",
      @required void onResponse(dynamic response),
      void onError(Response.DioError error),
      bool showDialog = false,
      var header}) async {
    // show loading dialog
    if (showDialog) {
      isLoading = true;
      if (!Get.isDialogOpen) {
        Get.dialog(
          LoadingWidget(),
          barrierDismissible: true,
        );
      }
    }

    // get store config
    await _getStore();

    var headers = {
      'apikey': '$accessToken',
      'Content-Type': 'application/json',
      'platform': "mobile/${Platform.operatingSystem}",
    };
    if (_cookie != "" && _cookie != null) headers["token"] = _cookie;

    _dio
        .request(
      "$_domain/api$path",
      options: Response.Options(
        method: method,
        headers: header == null ? headers : header,
      ),
      data: schema != "" ? schema : null,
    )
        .catchError((onerror) {
      var err = onerror as Response.DioError;

      if (showDialog) {
        isLoading = false;
        if (Get.isDialogOpen) {
          Get.back();
        }

        if (onError != null) {
          print(err);
          onError(err);
        } else {
          var message =
              'Request failed, Please check that you have internet connection. Contact support if problem persist';
          if (err.response.data != null &&
              !(err.response.data is String) &&
              err.response.data.containsKey('error')) {
            message = err.response.data["error"] is String
                ? err.response.data['error']
                : err.response.data["error"][0];
          }
          Helper.showError(err.response.data ?? message);
        }
      }
    }).then((response) {
      // print(response.statusCode);/
      if (response != null) {
        // closing loading dialog
        if (showDialog) {
          isLoading = false;
          if (Get.isDialogOpen) {
            Get.back();
          }
        }
        // parsing response
        if ((response.statusCode == 200 || response.statusCode == 201) &&
            response.data != null) {
          onResponse(response.data);
        } else {
          Get.back();
          Helper.showError(response.data);
        }
      }
    });
  }
}
