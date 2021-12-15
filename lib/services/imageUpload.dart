// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:convert';
import 'dart:io';
import 'package:edeybe/widgets/custom_dialog.dart';
import 'package:edeybe/widgets/loading_widget.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../index.dart';
import 'server_operation.dart';

class ImageUpload {
  static final String accessToken =
      r"3KJALFDKLAkjksoem$jis0*j3ji49509u5tojifk95%#lk33#4kjjksfkjd@$$krjkrkkioaseif$2kjs@kj5l4#";

  static String _cookie = "";
  static _getStore() async {
    _cookie = await GetStorage().read("cookie");
    if (_cookie == null || _cookie == "") {
      _cookie = await GetStorage().read("anony-cookie");
    }
  }

  static Future onSavePhoto(File path, Function(String) onResponse,
      {bool showDialog = true}) async {
    bool isLoading = false;
    await _getStore();
    if (showDialog) {
      isLoading = true;
      if (!Get.isDialogOpen) {
        Get.dialog(
          LoadingWidget(),
          barrierDismissible: true,
        );
      }
    }
    var uri = Uri.parse("$domain/api/id-card-upload");

    var request = new http.MultipartRequest("POST", uri);

    // Attach the file in the request
    final file = await http.MultipartFile.fromPath('photo', path.path,
        contentType: MediaType("image", "jpg"));

    var header = {
      'apikey': '$accessToken',
      'Content-Type': 'multipart/form-data',
      'platform': "mobile/${Platform.operatingSystem}",
      // 'Accept':'application/json'
    };
    if (_cookie != "" && _cookie != null) header["token"] = _cookie;

    request.headers.addAll(header);

    // ignore: unnecessary_statements
    request.files.add(file);

    var response = await request.send();

    if (response.statusCode == 200) {
      if (showDialog) {
        isLoading = false;
        if (Get.isDialogOpen) {
          Get.back();
          Get.dialog(CustomDialog(
              title: "Success", content: "Image uploaded successfully"));
        }

        response.stream.bytesToString().then((value) {
          final data = json.decode(value);

          onResponse(data['lg']);
        });
      }
    } else {
      print("error");
      if (showDialog) {
        isLoading = false;
        if (Get.isDialogOpen) {
          Get.back();
          Get.dialog(
              CustomDialog(title: "Failed", content: "Image uploading failed"));
        }
      }
    }
  }
}
