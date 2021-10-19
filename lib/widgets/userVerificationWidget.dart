import 'dart:async';

import 'package:edeybe/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

Widget OptVerifyWidget({
  @required String phoneNumber,
  @required String timer,
  @required BuildContext context,
  @required void Function() onResend,
  @required void Function() onVerify,
  @required Key key,
  @required StreamController<ErrorAnimationType> errorController,
  @required TextEditingController textEditingController,
  @required bool hasError,
  @required void Function(String value) onChange,
  @required Future<bool> Function() onWillPop,
  @required Key scaffoldKey,
  @required Widget timerWidget,
}) {
  final size = MediaQuery.of(context).size;
  return WillPopScope(
      onWillPop: () => onWillPop(),
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   backgroundColor: WHITE,
        //   elevation: 0,
        //   actions: [
        //     Container(
        //         height: 30,
        //         child:  ],
        // ),
        body: Container(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: <Widget>[
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Image.asset(
                  //         'assets/images/Logo.png',
                  //         width: 100,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 40),
                  Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Color(0xffF1F8FE), shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(60.0),
                        child: Image.asset(
                          "assets/images/Logo.png",
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "Verify phone number",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                    child: RichText(
                      text: TextSpan(
                          text: "We have sent a 6-digit  code to this \nEmail ",
                          children: [
                            TextSpan(
                                text: "${phoneNumber}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ],
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: 15,
                              height: 1.5)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: key,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 6,
                          obscureText: false,
                          obscuringCharacter: '*',
                          blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          validator: (v) {
                            if (v.length < 3) {
                              return "Invalid Code entered";
                            } else {
                              return null;
                            }
                          },
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(8),
                            fieldHeight: 45,
                            fieldWidth: 45,
                            borderWidth: 1,
                            inactiveColor: Colors.black,
                            activeFillColor: hasError
                                ? Get.theme.primaryColorLight
                                : Colors.white,
                          ),
                          cursorColor: Colors.black,
                          animationDuration: Duration(milliseconds: 300),
                          textStyle: TextStyle(fontSize: 20, height: 1.6),
                          backgroundColor: Colors.transparent,
                          enableActiveFill: false,
                          errorAnimationController: errorController,
                          controller: textEditingController,
                          keyboardType: TextInputType.number,
                          onCompleted: (v) {
                            print("Completed");
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                          onChanged: (String value) {},
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      hasError ? "*Please fill up all the cells properly" : "",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: CupertinoButton(
                      color: textEditingController.text.length < 6
                          ? Color(0xff889199)
                          : Get.theme.primaryColorDark,
                      child: Text("Verify"),
                      onPressed: onVerify,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     timerWidget,
                      int.parse(timer) == 0
                          ? TextButton(
                              onPressed: onResend,
                              child: Text(
                                "Resend",
                                style: TextStyle(
                                    color: Get.theme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ))
                          : Container(
                              width: 0,
                              height: 0,
                            )
                    ],
                  ),
                  SizedBox(
                    height: 14,
                  ),
                ],
              ),
            ),
          ),
        ),
      ));
}
