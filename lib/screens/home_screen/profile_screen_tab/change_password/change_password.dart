import 'package:edeybe/controllers/user_controller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:edeybe/utils/keyboard-action.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({Key key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final userController = Get.find<UserController>();

  // variables
  TextEditingController _oldPasswordCtrl = TextEditingController();
  // TextEditingController _countryCodeCtrl = TextEditingController();
  TextEditingController _newPasswordCtrl = TextEditingController();
  TextEditingController _confirmNewPasswordCtrl = TextEditingController();

  bool canEditPersonalDetails = false;
  bool showPass = false;

  double changePasswordBtnOpacity = 1.0;

  void _changeCanEditDetails() {
    setState(() {
      changePasswordBtnOpacity = canEditPersonalDetails ? 0.0 : 1.0;
      canEditPersonalDetails = !canEditPersonalDetails;
    });
  }

  final FocusNode _passOld = FocusNode();
  final FocusNode _passNew = FocusNode();
  final FocusNode _passConfirm = FocusNode();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(focusNode: _passOld, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _passNew, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _passConfirm, toolbarButtons: [action]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Get.theme.iconTheme.copyWith(color: Colors.black),
        automaticallyImplyLeading: true,
        elevation: 0.0,
        centerTitle: true,
        title: Text(S.of(context).changePassword),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        actions: <Widget>[
          IconButton(
            onPressed: _changeCanEditDetails,
            icon: Icon(
              Icons.edit,
              color: Colors.black,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: Get.width,
        child: TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.w)),
            backgroundColor: Get.theme.primaryColor,
            onSurface: Get.theme.primaryColor.withOpacity(0.5.w),
          ),
          child: Text(
            S.of(context).changePassword,
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            userController.changePassword(_oldPasswordCtrl.text,
                _newPasswordCtrl.text, _confirmNewPasswordCtrl.text);
          },
        ),
      ),
      body: KeyboardActions(
        config: _buildConfig(context),
        child: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.only(bottom: 20.w),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    blurRadius: 3.4.w,
                    offset: Offset(0, 3.4.w),
                    color: Constants.boxShadow)
              ],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24))),
          child: Form(
            child: Padding(
              padding: EdgeInsets.all(12.0.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 10.w),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 47.w,
                      child: TextFormField(
                        focusNode: _passOld,
                        obscureText: showPass,
                        decoration: InputDecoration(
                          suffix: SizedBox(
                            width: 20.w,
                            height: 47.w,
                            child: IconButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () => _oldPasswordCtrl.clear(),
                                icon: Icon(
                                  Icons.clear,
                                  size: 15.w,
                                )),
                          ),
                          hintText: S.of(context).oldPassword,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Constants.themeGreyLight,
                                  width: 1.0.w),
                              borderRadius: BorderRadius.circular(5.0.w)),
                          contentPadding: EdgeInsets.all(10.0.w),
                        ),
                        controller: _oldPasswordCtrl,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 47.w,
                      child: TextFormField(
                        focusNode: _passNew,
                        obscureText: showPass,
                        decoration: InputDecoration(
                          suffix: SizedBox(
                            width: 30.w,
                            height: 47.w,
                            child: Center(
                              child: IconButton(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(0),
                                  onPressed: () => _newPasswordCtrl.clear(),
                                  icon: Icon(
                                    Icons.clear,
                                    size: 15.w,
                                  )),
                            ),
                          ),
                          hintText: S.of(context).newPassword,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Constants.themeGreyLight,
                                  width: 1.0.w),
                              borderRadius: BorderRadius.circular(5.0.w)),
                          contentPadding: EdgeInsets.all(10.0.w),
                        ),
                        controller: _newPasswordCtrl,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 47.w,
                      child: TextFormField(
                        focusNode: _passConfirm,
                        obscureText: showPass,
                        decoration: InputDecoration(
                          suffix: SizedBox(
                            width: 30.w,
                            height: 47.w,
                            child: Center(
                              child: IconButton(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(0),
                                  onPressed: () =>
                                      _confirmNewPasswordCtrl.clear(),
                                  icon: Icon(
                                    Icons.clear,
                                    size: 15.w,
                                  )),
                            ),
                          ),
                          hintText: S.of(context).confirmNewPassword,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Constants.themeGreyLight,
                                  width: 1.0.w),
                              borderRadius: BorderRadius.circular(5.0.w)),
                          contentPadding: EdgeInsets.all(10.0.w),
                        ),
                        controller: _confirmNewPasswordCtrl,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        onPressed: () => setState(() => showPass = !showPass),
                        child: Icon(
                          showPass
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
