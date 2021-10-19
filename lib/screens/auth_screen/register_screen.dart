import 'package:edeybe/controllers/user_controller.dart';
import 'package:edeybe/screens/auth_screen/login_screen.dart';
import 'package:edeybe/screens/home_screen/index.dart';
import 'package:edeybe/utils/helper.dart';
import 'package:edeybe/utils/keyboard-action.dart';
import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _email, _password, _firstName, _lastName, _confirmPass;
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  var userController = Get.find<UserController>();
  final FocusNode _firstname = FocusNode();
  final FocusNode _lastname = FocusNode();
  final FocusNode _emailF = FocusNode();
  final FocusNode _pass = FocusNode();
  final FocusNode _confirmpass = FocusNode();
  bool _obscureText = true;
  bool _obscureText1 = true;

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(focusNode: _firstname, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _lastname, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _lastname, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _lastname, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _emailF, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _pass, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _confirmpass, toolbarButtons: [action]),
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
                    S.of(context).signup,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.headline5,
                    maxLines: 1,
                  ),
                  AutoSizeText(
                    S.of(context).createAccountToGetStart,
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
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          TextFormField(
                            focusNode: _firstname,
                            maxLines: 1,
                            enableSuggestions: true,
                            validator: (value) {
                              return (value.isNotEmpty)
                                  ? null
                                  : S.of(context).invalidMail;
                            },
                            onSaved: (newValue) => _firstName = newValue,
                            style: TextStyle(fontSize: 15.w),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 2.w, horizontal: 10.w),
                              labelText: S.of(context).firstName,
                              hintStyle: TextStyle(fontSize: 14.w),
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
                            focusNode: _lastname,
                            maxLines: 1,
                            enableSuggestions: true,
                            validator: (value) {
                              return (value.isNotEmpty)
                                  ? null
                                  : S.of(context).invalidMail;
                            },
                            onSaved: (newValue) => _lastName = newValue,
                            style: TextStyle(fontSize: 14.w),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 2.w, horizontal: 10.w),
                              labelText: S.of(context).lastName,
                              hintStyle: TextStyle(fontSize: 14.w),
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
                            focusNode: _emailF,
                            maxLines: 1,
                            enableSuggestions: true,
                            keyboardType: TextInputType.emailAddress,
                            validator: Helper.validateEmail,
                            onSaved: (newValue) => _email = newValue,
                            style: TextStyle(fontSize: 14.w),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 2.w, horizontal: 10.w),
                              labelText: S.of(context).email,
                              hintStyle: TextStyle(fontSize: 14.w),
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
                            obscureText: _obscureText1,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) => value.length >= 8
                                ? null
                                : S.of(context).password,
                            onSaved: (newValue1) => _password = newValue1,
                            style: TextStyle(fontSize: 14.w),
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText1 = !_obscureText1;
                                  });
                                },
                                child: Icon(
                                  _obscureText1
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 2.w, horizontal: 10.w),
                              labelText: S.of(context).password,
                              hintStyle: TextStyle(fontSize: 14.w),
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
                            focusNode: _confirmpass,
                            maxLines: 1,
                            enableSuggestions: true,
                            obscureText: _obscureText,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) => value.length >= 8
                                ? null
                                : S.of(context).password,
                            onSaved: (newValue) => _confirmPass = newValue,
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
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 2.w, horizontal: 10.w),
                              labelText: "Confirm Password",
                              hintStyle: TextStyle(fontSize: 14.w),
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
                                textStyle: TextStyle(color: Colors.white)),
                            onPressed: () {
                              if (_key.currentState.validate()) {
                                _key.currentState.save();
                                userController.register(
                                  firstName: _firstName,
                                  lastName: _lastName,
                                  email: _email,
                                  password: _password,
                                  confirmPass: _confirmPass
                                );
                              }
                            },
                            child: Text(
                              S.of(context).signup,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AutoSizeText(S.of(context).haveAnAccount),
                      TextButton(
                        onPressed: () {
                          Get.off(LoginScreen());
                        },
                        style: TextButton.styleFrom(
                            textStyle: TextStyle(
                          color: Get.theme.primaryColor,
                        )),
                        child: Text(
                          S.of(context).signIn,
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
          )),
    );
  }
}
