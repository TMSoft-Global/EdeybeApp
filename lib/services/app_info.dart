import 'dart:convert';
import 'dart:io';
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

  Future<dynamic> updateVersion(
      String version, String buildnumber, callback(dynamic)) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded =
        stringToBase64.encode(r'EdeybeMobile:up4a+erM0b!L23$');
        print("======================$encoded");
    var body = Platform.isIOS
        ? {"iosBuild": 3, "iosVersion": "1.0.1", "type": 'ios'}
        : {"androidBuild": 2, "androidVersion": "1.0.1", "type": 'andriod'};
    return dynamicRequest(
      path: "/app/m/version",
      schema: jsonEncode(body),
      method: "PUT",
      header: {
        'Authorization': 'Basic $encoded',
      },
      onResponse: (res) {
        print(res);
        Map<String, String> resData = {};
        if (res.isNotEmpty) {
          // resData = jsonDecode(res);
          callback(res);
        }
        return resData;
      },
    );
  }
}
