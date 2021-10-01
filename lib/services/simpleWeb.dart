import 'dart:convert';

import 'package:edeybe/encryption/encryptData.dart';
import 'package:edeybe/screens/splash_screen/splash_screen.dart';
import 'package:edeybe/services/user_operation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SimpleWebview extends StatefulWidget {
  @override
  _SimpleWebviewState createState() => _SimpleWebviewState();
}

class _SimpleWebviewState extends State<SimpleWebview> {
  WebViewController _controller;
  UserOperations _userOperations = UserOperations();

  String value;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Encryption.decryptData(jsonEncode({"data":"1234567876","sister":"sqdfasdgfs"}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebView"),
      ),
      body: _buildWebView(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     String datas;
      //     // data =
      //     encryptData("Oliver lets go home")
      //         .then((val) => datas = val)
      //         .whenComplete(() => print(datas));
      //   },
      //   child: Text("value"),
      //   backgroundColor: Colors.green,
      // ),
    );
  }

  Widget _buildWebView() {
    return WebView(
      initialUrl: "http://8fb7-197-251-220-74.ngrok.io/payment-methods/card/receive-details?status=Approved&code=000&reason=Approved&transaction_id=845112792821&merchant_id=TTM-00003346&session_id=614c5d3d8ca8342a7234cb39&token=sdfghjkasdfg",
      // "https://prod.theteller.net/v1.1/3ds/resource/mpgs/pareq/TTM-00003346/797418456382/163397000001",
      // onWebViewCreated: (WebViewController controller) {
      //   _controller = controller;
      //   _loadLocalHtmlFile();
      // },
      onPageFinished: (String url) {
        print('Page finished loading: $url');
      },
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: <JavascriptChannel>[
        _messageJavascriptChannel(context),
        _scriptJavascriptChannel(context),
      ].toSet(),
    );
  }

  JavascriptChannel _messageJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Print',
        
        onMessageReceived: (JavascriptMessage message) {
          setState(() {
            value = message.message;
          });
          print(message.message);
          if (message.message == "close") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SplashScreen()));
          }
        });
  }

  JavascriptChannel _scriptJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Postascript',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          print(message.message);
        });
  }

  // _loadLocalHtmlFile() async {
  //   String fileText = await rootBundle.loadString('assets/tester.html');
  //   _controller.loadUrl(Uri.dataFromString(fileText,
  //           mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
  //       .toString());
  // }
}
