import 'dart:convert';
import 'package:edeybe/services/server_operation.dart';

class AppInfo extends ServerOperations {
  Future<Map<String, String>> getInfo() {
    return dynamicRequest(
      path: "/app/m/version",
      schema: "",
      method: "PUT",
      onResponse: (res) {
        print(res);
        Map<String, String> resData = jsonDecode(res);

        return resData;
      },
    );
  }
}
