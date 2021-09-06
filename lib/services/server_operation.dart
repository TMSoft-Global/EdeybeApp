import 'dart:io';

import 'package:edeybe/index.dart';
import 'package:edeybe/utils/helper.dart';
import 'package:edeybe/widgets/loading_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

abstract class ServerOperations {
  final String _domain = "api.edeybe.com";
  final String _domainLocal = "172.18.72.61:5002";
  final String accessToken =
      r"3KJALFDKLAkjksoem$jis0*j3ji49509u5tojifk95%#lk33#4kjjksfkjd@$$krjkrkkioaseif$2kjs@kj5l4#";
  // String _store = "";
  // String _local = "en";
  // String _currency = 'GHS';

  String _cookie = "";
  bool isLoading = false;
  bool forceUpdate = false;

  Dio _dio = Dio();

  _getStore() async {
    // this._store = GetStorage().read("store") ?? "";
    _cookie = await GetStorage().read("cookie");
    if (_cookie == null || _cookie == "") {
      _cookie = await GetStorage().read("anony-cookie");
    }
    // this._local = GetStorage().read("local") ?? "en";
    // this._currency = GetStorage().read('currency') ?? "GHS";
  }

  dynamicRequest(
      {@required String path,
      @required String schema,
      method = "POST",
      @required void onResponse(dynamic response),
      void onError(DioError error),
      bool showDialog = false}) async {
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
      "https://$_domain/api$path",
      options: Options(
        method: method,
        headers: headers,
      ),
      data: schema != "" ? schema : null,
    )
        .catchError((onerror) {
      var err = onerror as DioError;

      if (showDialog) {
        isLoading = false;
        if (Get.isDialogOpen) {
          Get.back();
        }

        if (onError != null) {
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
