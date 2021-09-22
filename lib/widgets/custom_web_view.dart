import 'package:edeybe/controllers/cart_controller.dart';
import 'package:edeybe/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:io';

import 'package:edeybe/widgets/loading_widget.dart';

class CustomWebView extends StatefulWidget {
  final Function(Map<String, dynamic>) onLoadFinish;
  final Uri watch;
  final String url;
  final String title;
  CustomWebView({this.title, this.url, this.onLoadFinish, this.watch});

  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  InAppWebViewController webView;
  bool showLoader = true;
  bool hideWebView = false;
  var _cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                widget.title,
                style: TextStyle(color: Colors.white),
              ),
              automaticallyImplyLeading: false,
              leading: IconButton(
                color: Colors.white,
                icon: Icon(Icons.close),
                onPressed: closeCheckout,
              ),
            ),
            body: SafeArea(
              child: Container(
                child: Stack(children: [
                  !hideWebView ? _getWebView : SizedBox.shrink(),
                  if (showLoader) LoadingWidget()
                ]),
              ),
            ),
          )
        : CupertinoPageScaffold(
            child: SafeArea(
              child: Container(
                child: Stack(children: [
                  !hideWebView ? _getWebView : SizedBox.shrink(),
                  if (showLoader) LoadingWidget()
                ]),
              ),
            ),
            navigationBar: CupertinoNavigationBar(
              middle: Text(widget.title),
              leading: CupertinoButton(
                onPressed: closeCheckout,
                child: Icon(CupertinoIcons.clear),
              ),
            ),
          );
  }

  void closeCheckout() {
    Map<String, dynamic> data = {
      "code": -999,
      "status": "userClosed",
      "reason": "User closed",
      "transaction_id": ""
    };
    if (Navigator.canPop(context)) Get.back();
    widget.onLoadFinish(data);
  }

  get _getWebView {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          supportZoom: false,
        ),
      ),
      onWebViewCreated: (InAppWebViewController controller) {
        webView = controller;
      },
      onLoadStart: (InAppWebViewController controller, Uri url) {
        if (!showLoader) {
          setState(() {
            showLoader = true;
          });
        }
        // if()
        if (url.path == widget.watch.path) {
          setState(() {
            hideWebView = true;
          });
          Map<String, dynamic> data = {
            "code": url.queryParameters['code'],
            "status": url.queryParameters['status'],
            "transaction_id": url.queryParameters['transaction_id']
          };
          _cartController.checkOrderStatus(
              {"transactionId": data["transaction_id"]}, (data) {
            if (Navigator.canPop(context)) Get.back();
            widget.onLoadFinish(data);
            _cartController.getCartITems();
          });
        }
      },
      onLoadStop: (InAppWebViewController controller, Uri url) async {
        setState(() {
          showLoader = false;
        });
      },
      onProgressChanged: (InAppWebViewController controller, int progress) {
        // setState(() {
        //   this.progress = progress / 100;
        // });
      },
    );
  }
}
