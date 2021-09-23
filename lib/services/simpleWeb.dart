import 'dart:convert';

import 'package:edeybe/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SimpleWebview extends StatefulWidget {
  @override
  _SimpleWebviewState createState() => _SimpleWebviewState();
}

class _SimpleWebviewState extends State<SimpleWebview> {
  WebViewController _controller;
  String value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebView"),
      ),
      body: _buildWebView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.evaluateJavascript(
              'changeImagePathWith("Add your image path here");');
        },
        child: Text(value),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildWebView() {
    return WebView(
      initialUrl: "about:blank",
      onWebViewCreated: (WebViewController controller) {
        _controller = controller;
        _loadLocalHtmlFile();
      },
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
          if(message.message == "close"){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
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

  _loadLocalHtmlFile() async {
    String fileText = await rootBundle.loadString('assets/tester.html');
    _controller.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}