import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:edeybe/controllers/user_controller.dart';
import 'package:edeybe/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../widgets/userVerificationWidget.dart';
import 'package:http/http.dart' as http;

class OtpVerification extends StatefulWidget {
  final int timer;
  final String phone;
  final String id;
  final String password;

  OtpVerification({
    @required this.timer,
    @required this.phone,
    @required this.id,
    @required this.password,
  });

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController verificationCodeController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  StreamController<ErrorAnimationType> errorController;
  UserController _userController = Get.put(UserController());
  bool hasError = false;
  String currentText = "";
  bool _isLoading = false;

  String showLoadingMessage = "";

  // int timer = 10;

  int time = 10;
  Timer _timer;

  @override
  void initState() {
    _startTimer();
    setState(() {
      _isLoading = false;
    });
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        OptVerifyWidget(
          context: context,
          onVerify: _onVerify,
          phoneNumber: "${widget.phone}",
          timer: "$time",
          onResend: () => _onOPTResend(widget.phone),
          errorController: errorController,
          hasError: hasError,
          key: _formKey,
          onChange: _onChange,
          textEditingController: verificationCodeController,
          onWillPop: () => _onBack(),
          scaffoldKey: scaffoldKey,
        ),
        // _isLoading ? customLoadingPage(msg: "") : Container(width: 0, height: 0)
      ],
    );
  }

  void _onChange(String value) {
    setState(() {
      hasError = false;
      currentText = value;
    });
  }

  _onBack() async {
    return true;
  }

  void _onVerify() {
    if (verificationCodeController.text.length != 6) {
      setState(() {
        _isLoading = false;
      });
      // Triggering error shake animation
      errorController.add(ErrorAnimationType.shake);
      setState(() {
        hasError = true;
      });
    } else {
      print(verificationCodeController.text);
      print(widget.id);
      // print(widget.password);
      _userController.verifyUser(
        otp: verificationCodeController.text,
        regId: widget.id,
        email: widget.phone,
        password:widget.password
      );
      // _onOPTVerification(verificationCodeController.text);
    }
  }

  Future<void> _onOPTVerification(String otp) async {}

  Future<void> _onOPTResend(String phonoe) async {}

  Future<void> _setTimer({seconds = 3}) async {
    await Future.delayed(Duration(seconds: seconds), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _startTimer() {
    const oneSec =  Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (time > 0) {
            time = time - 1;
            print(time);
          } else {
            timer.cancel();
          }
        },
      ),
    );
  }
}
