import 'package:edeybe/controllers/payment_method_controller.dart';
import 'package:edeybe/screens/payment_method/payment_method.dart';
import 'package:edeybe/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../index.dart';

class SimpleWebview extends StatefulWidget {
  final String url;
  SimpleWebview({@required this.url});
  @override
  _SimpleWebviewState createState() => _SimpleWebviewState();
}

class _SimpleWebviewState extends State<SimpleWebview> {
  WebViewController _controller;
  var _paymentController = Get.find<PaymentMethodController>();

  String value;
  @override
  void initState() {
    super.initState();

    // Encryption.decryptData(jsonEncode({"data":"1234567876","sister":"sqdfasdgfs"}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment", style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: _buildWebView(widget.url),
    );
  }

  Widget _buildWebView(String url) {
    return WebView(
      initialUrl: "$url",
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
            _paymentController.getAllPayment();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PaymentMethodScreen(
                  hasContinueButton: true,
                )));
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
}
