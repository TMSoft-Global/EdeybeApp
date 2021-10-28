import 'package:edeybe/controllers/user_controller.dart';
import 'package:edeybe/screens/auth_screen/register_screen.dart';
import 'package:edeybe/screens/forgot_password/forgot_password.dart';
import 'package:edeybe/screens/home_screen/index.dart';
import 'package:edeybe/utils/keyboard-action.dart';
import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _mail, _password;
  bool _autoValidate = false;
  var userController = Get.find<UserController>();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  final FocusNode _emailF = FocusNode();
  final FocusNode _pass = FocusNode();
  bool _obscureText = true;


  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(focusNode: _emailF, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _pass, toolbarButtons: [action]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: KeyboardActions(
      config: _buildConfig(context),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 90.h,
              ),
              Image.asset(
                'assets/images/Logo.png',
                // height: 55.h,
              ),
              AutoSizeText(
                S.of(context).welcome,
                textAlign: TextAlign.center,
                style: Get.textTheme.headline5,
                maxLines: 1,
              ),
              AutoSizeText(
                S.of(context).singinOrRegsiter,
                textAlign: TextAlign.center,
                maxLines: 1,
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
                        focusNode: _emailF,
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
                      TextFormField(
                        focusNode: _pass,
                        maxLines: 1,
                        enableSuggestions: true,
                        obscureText: _obscureText,
                        validator: (value) {
                          return (value.isNotEmpty && value.length >= 6)
                              ? null
                              : S.of(context).password;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        onSaved: (newValue) => _password = newValue,
                        style: TextStyle(fontSize: 14.w),
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                              ),
                          hintStyle: TextStyle(fontSize: 14.w),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 2.w, horizontal: 10.w),
                          labelText: S.of(context).password,
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
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
                            userController.login(
                              username: _mail,
                              password: _password,
                            );
                          }
                        },
                        child: Text(
                          S.of(context).signIn,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Get.to(ForgotPassword());
                    },
                    style: TextButton.styleFrom(
                        textStyle: TextStyle(
                      color: Get.theme.primaryColor,
                    )),
                    child: Text(
                      S.of(context).forgetPassword,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.off(RegisterScreen());
                    },
                    style: TextButton.styleFrom(
                        textStyle: TextStyle(
                      color: Get.theme.primaryColor,
                    )),
                    child: Text(
                      S.of(context).createAccount,
                    ),
                  )
                ],
              ),
              TextButton(
                onPressed: () {
                  Get.offAll(HomeIndex());
                },
                child: Text(
                  S.of(context).skip,
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
