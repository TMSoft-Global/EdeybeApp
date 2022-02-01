import 'dart:convert';
import 'package:edeybe/services/server_operation.dart';

class AppInfo extends ServerOperations {
  Future<dynamic> getInfo(callback(dynamic)) {
    return dynamicRequest(
      path: "/app/m/version",
      schema: "",
      method: "GET",
      onResponse: (res) {
        print(res);
        Map<String, String> resData = {};
        if (res.isNotEmpty) {
          resData = jsonDecode(res);
          callback(res);
        }
        return resData;
      },
    );
  }

  Future<dynamic> updateVersion(callback(dynamic)) {
    return dynamicRequest(
      path: "/app/m/version",
      schema: "",
      method: "PUT",
      onResponse: (res) {
        print(res);
        Map<String, String> resData = {};
        if (res.isNotEmpty) {
          resData = jsonDecode(res);
          callback(res);
        }
        return resData;
      },
    );
  }



  Future<dynamic> checkVersion(callback(dynamic)) {
    return dynamicRequest(
      path: "/app/m/version",
      schema: "",
      method: "PUT",
      onResponse: (res) {
        print(res);
        Map<String, String> resData = {};
        if (res.isNotEmpty) {
          resData = jsonDecode(res);
          callback(res);
        }
        return resData;
      },
    );
  }



}
