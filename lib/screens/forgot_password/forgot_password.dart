import 'package:edeybe/controllers/user_controller.dart';
import 'package:edeybe/screens/auth_screen/login_screen.dart';
import 'package:edeybe/screens/configuration_screen/config_screen.dart';
import 'package:edeybe/utils/dialog_enum.dart';
import 'package:edeybe/widgets/full_screen_dialog.dart';
import 'package:flutter/material.dart';

import '../../index.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String _mail;
  bool _autoValidate = false;
  var userController = Get.find<UserController>();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 15.w),
              child: AutoSizeText(
                S.of(context).forgetPassword,
                textAlign: TextAlign.justify,
                style: Get.textTheme.headline5,
                maxLines: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: AutoSizeText(
                S.of(context).forgotPasswordMessage,
                // textAlign: TextAlign.justify,
                style: Get.textTheme.bodyText1.copyWith(fontSize: 17.w),
                maxLines: 8,
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Divider(
              endIndent: 24.w,
              indent: 24.w,
            ),
            SizedBox(
              height: 12.h,
            ),
            Form(
              key: _key,
              autovalidateMode: _autoValidate
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      maxLines: 1,
                      enableSuggestions: true,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        return (value.isNotEmpty && value.isEmail)
                            ? null
                            : S.of(context).invalidMail;
                      },
                      onSaved: (newValue) => _mail = newValue,
                      style: TextStyle(fontSize: 14.w),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 14.w),
                        labelText: S.of(context).email,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 2.w, horizontal: 10.w),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Get.theme.primaryColor,
                          textStyle: TextStyle(
                            color: Colors.white,
                          )),
                      onPressed: () {
                        if (_key.currentState.validate()) {
                          _key.currentState.save();
                          userController.forgotPassword(
                              email: _mail,
                              callback: (DialogEnum type) =>
                                  Get.off(FullScreenDialog(
                                    type: type,
                                    actions: <Widget>[
                                      if (type == DialogEnum.Success)
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 8.0.w, top: 8.0.w),
                                          child: SizedBox(
                                            width: Get.width,
                                            height: 45.w,
                                            child: ButtonTheme(
                                              height: 45.w,
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: Get.theme
                                                              .primaryColor),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.w)),
                                                ),
                                                child: Text(
                                                  S.of(context).signIn,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: Get
                                                          .theme.primaryColor),
                                                ),
                                                onPressed: () {
                                                  if (navigator.canPop()) {
                                                    navigator.pop();
                                                  }
                                                  Get.off(LoginScreen());
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 8.0.w, top: 8.0.w),
                                        child: SizedBox(
                                          width: Get.width,
                                          height: 45.w,
                                          child: ButtonTheme(
                                            height: 45.w,
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: Colors.white,
                                                        width: 1.0.w),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.w)),
                                                backgroundColor:
                                                    Get.theme.primaryColor,
                                                onSurface: Get
                                                    .theme.primaryColor
                                                    .withOpacity(0.5.w),
                                              ),
                                              child: Text(
                                                S.of(context).skip,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                Get.offAll(
                                                    ConfigurationScreen());
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    message: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(10.w),
                                          child: Text(S.of(context).checkMail,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 22.w)),
                                        ),
                                        Text(S.of(context).emailSent,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14.w))
                                      ],
                                    ),
                                  )));
                        }
                      },
                      child: Text(
                        S.of(context).sendInstructions,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
          ],
        ),
      ),
    );
  }
}
