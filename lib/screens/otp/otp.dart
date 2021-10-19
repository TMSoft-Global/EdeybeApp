import 'dart:async';
import 'package:edeybe/controllers/payment_method_controller.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';

class Otp extends StatefulWidget {
  final Function onVerify;
  final Function onResend;
  final String data;
  const Otp(
      {Key key,
      @required this.data,
      @required this.onVerify,
      @required this.onResend})
      : super(key: key);

  @override
  _OtpState createState() => new _OtpState(data: data);
}

class _OtpState extends State<Otp> with SingleTickerProviderStateMixin {
  // Constants
  final String data;
  _OtpState({this.data});
  AnimationController _controller;

  var paymentMethodController = Get.find<PaymentMethodController>();
  // Variables
  Size _screenSize;
  int _currentDigit;
  int _firstDigit;
  int _secondDigit;
  int _thirdDigit;
  int _fourthDigit;
  int _fifthDigit;
  int _sixthDigit;

  final int time = 300;
  Timer timer;
  Timer resetStateTimer;
  int resendCount = 1;
  int totalTimeInSeconds;
  bool _hideResendButton;
  bool loadervisible = false;
  bool alertVisible = false;
  bool noMatch = false;

  // Return "OTP" input field
  get _getInputField {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _otpTextField(_firstDigit),
        _otpTextField(_secondDigit),
        _otpTextField(_thirdDigit),
        _otpTextField(_fourthDigit),
        _otpTextField(_fifthDigit),
        _otpTextField(_sixthDigit),
      ],
    );
  }

  // Returns "OTP" input part
  Widget _getInputPart(onresend) {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // _getNotMyNumberBtn,
        new SizedBox(
          height: 10.0,
        ),
        _getInputField,
        new SizedBox(
          height: 10.0,
        ),
        Visibility(
          visible: noMatch,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.w),
            child: Text(
              "You entered a wrong OTP",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
        _hideResendButton ? _getTimerText : _getResendButton(onresend),
        _getOtpKeyboard()
      ],
    );
  }

  String getCode() {
    return '$_firstDigit$_secondDigit$_thirdDigit$_fourthDigit$_fifthDigit$_sixthDigit';
  }

  // Returns "Timer" label
  get _getTimerText {
    return Container(
      height: 60,
      child: Offstage(
        offstage: !_hideResendButton,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('Request new otp in'.toUpperCase()),
            new SizedBox(
              width: 5.0,
            ),
            new Icon(Icons.access_time),
            new SizedBox(
              width: 5.0,
            ),
            OtpTimer(_controller, 15.0, Colors.black),
          ],
        ),
      ),
    );
  }

  // Returns "Resend" button
  _getResendButton(onPress) {
    return Container(
        height: 60.h,
        // padding: EdgeInsets.only(top: 20.w),
        width: Get.width.w,
        alignment: Alignment.center,
        child: TextButton(
          onPressed: onPress,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "REQUEST NEW OTP",
                style: Get.textTheme.button.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Constants.mainColor),
              ),
            ],
          ),
        ));
  }

  // Returns "Otp" keyboard
  _getOtpKeyboard() {
    return new Container(
        child: Wrap(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _otpKeyboardInputButton(
                label: "1",
                onPressed: () {
                  _setCurrentDigit(1);
                }),
            _otpKeyboardInputButton(
                label: "2",
                onPressed: () {
                  _setCurrentDigit(2);
                }),
            _otpKeyboardInputButton(
                label: "3",
                onPressed: () {
                  _setCurrentDigit(3);
                }),
          ],
        ),
        new SizedBox(
          height: 40.0,
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _otpKeyboardInputButton(
                label: "4",
                onPressed: () {
                  _setCurrentDigit(4);
                }),
            _otpKeyboardInputButton(
                label: "5",
                onPressed: () {
                  _setCurrentDigit(5);
                }),
            _otpKeyboardInputButton(
                label: "6",
                onPressed: () {
                  _setCurrentDigit(6);
                }),
          ],
        ),
        new SizedBox(
          height: 40.0,
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _otpKeyboardInputButton(
                label: "7",
                onPressed: () {
                  _setCurrentDigit(7);
                }),
            _otpKeyboardInputButton(
                label: "8",
                onPressed: () {
                  _setCurrentDigit(8);
                }),
            _otpKeyboardInputButton(
                label: "9",
                onPressed: () {
                  _setCurrentDigit(9);
                }),
          ],
        ),
        new SizedBox(
          height: 40.0,
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new SizedBox(
              width: 80.0,
            ),
            _otpKeyboardInputButton(
                label: "0",
                onPressed: () {
                  _setCurrentDigit(0);
                }),
            _otpKeyboardActionButton(
                label: new Icon(
                  Icons.backspace,
                  // color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    if (_sixthDigit != null) {
                      _sixthDigit = null;
                    } else if (_fifthDigit != null) {
                      _fifthDigit = null;
                    } else if (_fourthDigit != null) {
                      _fourthDigit = null;
                    } else if (_thirdDigit != null) {
                      _thirdDigit = null;
                    } else if (_secondDigit != null) {
                      _secondDigit = null;
                    } else if (_firstDigit != null) {
                      _firstDigit = null;
                    }
                  });
                }),
          ],
        ),
      ],
    ));
  }

  // Overridden methods
  @override
  void initState() {
    totalTimeInSeconds = time;
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: totalTimeInSeconds))
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          setState(() {
            _hideResendButton = !_hideResendButton;
          });
        }
      });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
    _startCountdown();
  }

  @override
  void dispose() {
    _controller.dispose();
    if (timer != null && timer.isActive) timer.cancel();
    if (resetStateTimer != null && resetStateTimer.isActive)
      resetStateTimer.cancel();
    super.dispose();
  }

  // Returns "Otp custom text field"
  Widget _otpTextField(int digit) {
    return Container(
      width: 50.0,
      height: 50.0,
      padding: EdgeInsets.all(5.w),
      // decoration: BoxDecoration(color: '#F4F5F7'.toColor()),
      child: Container(
        alignment: Alignment.center,
        child: new Text(
          digit != null ? digit.toString() : "",
          style: new TextStyle(
            fontSize: 25.0,
            // color: Colors.black,
          ),
        ),
        decoration: BoxDecoration(
//            color: Colors.grey.withOpacity(0.4),
            border: Border(
                bottom: BorderSide(
          width: 2.0,
          color: digit != null
              ? Constants.themeBlueLight
              : Constants.themeGreyDark,
        ))),
      ),
    );
  }

  // Returns "Otp keyboard input Button"
  Widget _otpKeyboardInputButton({String label, VoidCallback onPressed}) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        onTap: onPressed,
        borderRadius: new BorderRadius.circular(40.0),
        child: new Container(
          height: 60.0,
          width: 60.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: new Center(
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: 25.0,
                // color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Returns "Otp keyboard action Button"
  _otpKeyboardActionButton({Widget label, VoidCallback onPressed}) {
    return new InkWell(
      onTap: onPressed,
      borderRadius: new BorderRadius.circular(40.0),
      child: new Container(
        height: 80.0,
        width: 80.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: new Center(
          child: label,
        ),
      ),
    );
  }

  // Current digit
  void _setCurrentDigit(int i) {
    setState(() {
      _currentDigit = i;
      if (_firstDigit == null) {
        _firstDigit = _currentDigit;
      } else if (_secondDigit == null) {
        _secondDigit = _currentDigit;
      } else if (_thirdDigit == null) {
        _thirdDigit = _currentDigit;
      } else if (_fourthDigit == null) {
        _fourthDigit = _currentDigit;
      } else if (_fifthDigit == null) {
        _fifthDigit = _currentDigit;
      } else if (_sixthDigit == null) {
        _sixthDigit = _currentDigit;
      }
    });
  }

  Future<Null> _startCountdown() async {
    setState(() {
      _hideResendButton = true;
      totalTimeInSeconds = time * resendCount;
    });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
  }

  Future<Null> _resendStartCountdown(res) async {
    setState(() {
      _hideResendButton = true;
      totalTimeInSeconds = time * resendCount;
    });
    _controller.duration = Duration(seconds: time * resendCount);

    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
  }

  void clearOtp() {
    _fourthDigit = null;
    _thirdDigit = null;
    _secondDigit = null;
    _firstDigit = null;
    _fifthDigit = null;
    _sixthDigit = null;
    setState(() {});
  }

  void showInSnackBar(String value, {String type}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      backgroundColor: type == "error" ? Colors.orange : Colors.green,
      content: new Text(value),
      duration: new Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = Get.size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 450.w,
          // alignment: Alignment.center,
          height: Get.height,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: Get.back,
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 10.h,
                // ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: AutoSizeText(
                    "An (OTP) has been sent to the mobile number you want to save",
                    textAlign: TextAlign.center,
                    style: Get.textTheme.headline5.copyWith(fontSize: 16),
                    maxLines: 2,
                  ),
                ),
                AutoSizeText(
                  "(+233) $data",
                  textAlign: TextAlign.center,
                  style: Get.textTheme.headline6.copyWith(fontSize: 18),
                  maxLines: 1,
                ),
                SizedBox(
                  height: 10.h,
                ),
                AutoSizeText(
                  "Enter OTP",
                  textAlign: TextAlign.center,
                  style: Get.textTheme.headline5.copyWith(fontSize: 18),
                  maxLines: 1,
                ),
                _getInputPart(() => widget.onResend(_resendStartCountdown)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.w, horizontal: 20.w),
                      child: SizedBox(
                        height: 40.w,
                        width: Get.width - 50,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: canSubmit()
                                ? Constants.mainColor
                                : Constants.themeGreyLight,
                          ),
                          onPressed: canSubmit()
                              ? () async {
                                  if (canSubmit()) {
                                    widget.onVerify(
                                      getCode(),
                                    );
                                  }
                                }
                              : null,
                          child: Text(
                            "Submit",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool canSubmit() {
    return _firstDigit != null &&
        _secondDigit != null &&
        _thirdDigit != null &&
        _fourthDigit != null &&
        _fifthDigit != null &&
        _sixthDigit != null;
  }
}

class OtpTimer extends StatelessWidget {
  final AnimationController controller;
  double fontSize;
  Color timeColor = Colors.black;

  OtpTimer(this.controller, this.fontSize, this.timeColor);

  String get timerString {
    Duration duration = controller.duration * controller.value;
    if (duration.inHours > 0) {
      return '${duration.inHours}:${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Duration get duration {
    Duration duration = controller.duration;
    return duration;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return new Text(
            timerString,
            style: new TextStyle(
                fontSize: fontSize,
                color: timeColor,
                fontWeight: FontWeight.w600),
          );
        });
  }
}
