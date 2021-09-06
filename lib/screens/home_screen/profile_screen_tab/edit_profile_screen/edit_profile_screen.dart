import 'package:edeybe/controllers/user_controller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/screens/home_screen/profile_screen_tab/change_password/change_password.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:edeybe/utils/keyboard-action.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // variables
  TextEditingController _fullnameCtrl = TextEditingController();
  // TextEditingController _countryCodeCtrl = TextEditingController();
  TextEditingController _mobileCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();

  final userController = Get.find<UserController>();
  bool canEditPersonalDetails = false;

  double changePasswordBtnOpacity = 1.0;
  final FocusNode _fullname = FocusNode();
  final FocusNode _mobile = FocusNode();
  final FocusNode _email = FocusNode();
  // state functions
  void _setContryCode(text) {
    setState(() {
      // _deliverto = text;
    });
  }

  void _changeCanEditDetails() {
    setState(() {
      changePasswordBtnOpacity = canEditPersonalDetails ? 0.0 : 1.0;
      canEditPersonalDetails = !canEditPersonalDetails;
    });
  }

  @override
  void initState() {
    _emailCtrl.text = userController.user.email;
    _fullnameCtrl.text =
        userController.user.firstname + " " + userController.user.lastname;
    super.initState();
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(focusNode: _fullname, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _mobile, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _email, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _mobile, toolbarButtons: [action]),
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
          title: Text(S.of(context).personalDetails),
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
        body: KeyboardActions(
          config: _buildConfig(context),
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(bottom: 20.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    if (canEditPersonalDetails)
                      BoxShadow(
                          blurRadius: 5,
                          offset: Offset(0.0, 5.0),
                          color: Constants.boxShadow)
                  ],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24.w),
                      bottomRight: Radius.circular(24.w))),
              child: Column(
                children: <Widget>[
                  Container(
                    width: Get.width / 3.w,
                    height: Get.width / 3.w,
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          "https://ae.edeybe.com/en/pub/media/wysiwyg/home-v4/Egypt_slider_mobile_EN-min.jpg"),
                    ),
                  ),
                  Form(
                    child: Padding(
                      padding: EdgeInsets.all(12.0.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 10.w),
                          Padding(
                              padding: EdgeInsets.all(8.w),
                              child: SizedBox(
                                height: 47.w,
                                child: TextFormField(
                                  focusNode: _fullname,
                                  enabled: canEditPersonalDetails,
                                  style: TextStyle(fontSize: 14.w),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    suffix: SizedBox(
                                        width: 30.w,
                                        height: 20.h,
                                        child: Center(
                                          child: InkWell(
                                              // iconSize: 20.w,
                                              onTap: () =>
                                                  _fullnameCtrl.clear(),
                                              child: Icon(
                                                Icons.clear,
                                                size: 15.w,
                                              )),
                                        )),
                                    hintText: S.of(context).fullName,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Constants.themeGreyLight,
                                            width: 1.0.w),
                                        borderRadius:
                                            BorderRadius.circular(5.w)),
                                    contentPadding: EdgeInsets.all(10.w),
                                  ),
                                  controller: _fullnameCtrl,
                                ),
                              )),
                          Padding(
                            padding: EdgeInsets.all(8.w),
                            child: SizedBox(
                              height: 47.w,
                              child: TextFormField(
                                focusNode: _email,
                                enabled: canEditPersonalDetails,
                                style: TextStyle(fontSize: 14.w),
                                decoration: InputDecoration(
                                  isDense: true,
                                  suffix: SizedBox(
                                      width: 30.w,
                                      height: 30.h,
                                      child: Center(
                                        child: InkWell(
                                            // iconSize: 20.w,
                                            onTap: () => _emailCtrl.clear(),
                                            child: Icon(
                                              Icons.clear,
                                              size: 15.w,
                                            )),
                                      )),
                                  hintText: S.of(context).email,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Constants.themeGreyLight,
                                          width: 1.0.w),
                                      borderRadius: BorderRadius.circular(5.w)),
                                  contentPadding: EdgeInsets.all(10.w),
                                ),
                                controller: _emailCtrl,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0.w),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: SizedBox(
                                    height: 47.w,
                                    child: TextFormField(
                                      focusNode: _mobile,
                                      enabled: canEditPersonalDetails,
                                      style: TextStyle(fontSize: 14.w),
                                      decoration: InputDecoration(
                                        suffix: SizedBox(
                                            width: 30.w,
                                            height: 30.h,
                                            child: Center(
                                              child: InkWell(
                                                  // iconSize: 20.w,
                                                  onTap: () =>
                                                      _mobileCtrl.clear(),
                                                  child: Icon(
                                                    Icons.clear,
                                                    size: 15.w,
                                                  )),
                                            )),
                                        isDense: true,
                                        hintText: S
                                            .of(context)
                                            .mobileNumberPlaceholder,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Constants.themeGreyLight,
                                                width: 1.0.w),
                                            borderRadius:
                                                BorderRadius.circular(5.w)),
                                        contentPadding: EdgeInsets.all(10.w),
                                        // suffixIcon: Container(
                                        //     width: 20.w,
                                        //     child: Icon(
                                        //       Icons.check_circle,
                                        //       color: Get.theme.primaryColor,
                                        //       size: 10.w,
                                        //     ))
                                      ),
                                      controller: _mobileCtrl,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Container(
                            width: Get.width,
                            child: Visibility(
                              visible: canEditPersonalDetails,
                              child: SizedBox(
                                height: 47.w,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.w)),
                                    backgroundColor: Get.theme.primaryColor,
                                    onSurface: Get.theme.primaryColor
                                        .withOpacity(.5.w),
                                  ),
                                  child: Text(
                                    S.of(context).saveChanges,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    userController.editProfile(
                                        _emailCtrl.text, _fullnameCtrl.text);
                                  },
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: Get.width,
                            child: Visibility(
                              visible: !canEditPersonalDetails,
                              child: SizedBox(
                                height: 47.w,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.w)),
                                    backgroundColor: Get.theme.primaryColor,
                                    onSurface: Get.theme.primaryColor
                                        .withOpacity(0.5.w),
                                  ),
                                  child: Text(
                                    S.of(context).changePassword,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () =>
                                      Get.off(ChangePasswordScreen()),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
