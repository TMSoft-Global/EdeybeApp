import 'dart:async';

import 'package:edeybe/index.dart';
import 'package:edeybe/screens/home_screen/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TransLoading extends StatefulWidget {
  @override
  _TransLoadingState createState() => _TransLoadingState();
}

class _TransLoadingState extends State<TransLoading> {
  String paymentStatus = "Transaction is been processed";
  bool showLoad = false;
  bool circleShow = true;
  bool showButton = false;
  fakeTransLoading() {
    Timer(Duration(seconds: 15), () {
      setState(() {
        paymentStatus = "Please wait...";
        showLoad = true;
        circleShow = false;
        showButton = true;
      });
    });
  }

  initPay() {
    Timer(Duration(seconds: 0), fakeTransLoading);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                paymentStatus,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
               SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Visibility(
                  visible: showLoad,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 50,
                      animation: true,
                      animationDuration: 15000,
                      lineHeight: 25.0,
                      percent: 1.0,
                      center: Text(
                        "100.0%",
                        style: TextStyle(fontSize: 12),
                      ),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Get.theme.primaryColorLight,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Visibility(
                visible: showButton,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0.w, top: 8.0.w),
                  child: ButtonTheme(
                    minWidth: 120.w,
                    height: 40.w,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white, width: 1.0.w),
                            borderRadius: BorderRadius.circular(8.w)),
                        backgroundColor: Get.theme.primaryColor,
                        onSurface: Get.theme.primaryColor.withOpacity(0.5.w),
                      ),
                      child: Text(
                        "Go Home",
                        maxLines: 1,
                        style: TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                      onPressed: () {
                        Get.to(HomeIndex(
                          indexPage: 0,
                        ));
                        // Get.off(WriteReviewScreen());
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: Center(
            child: circleShow
                ? CircularProgressIndicator()
                : Container(
                    height: 0,
                  )),
      ),
    );
  }
}
