import 'package:edeybe/controllers/user_controller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:flutter/material.dart';

class PostQuestionScreen extends StatefulWidget {
  PostQuestionScreen({Key key}) : super(key: key);

  @override
  _PostQuestionScreenState createState() => _PostQuestionScreenState();
}

class _PostQuestionScreenState extends State<PostQuestionScreen> {
  final TextEditingController _questionInputCtrl = TextEditingController();

  final _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Get.theme.iconTheme.copyWith(color: Colors.black),
        automaticallyImplyLeading: true,
        elevation: 0.0,
        centerTitle: true,
        title: Text(S.of(context).gotquestion),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      bottomNavigationBar: _questionInputCtrl.text.length > 0
          ? Container(
              padding: EdgeInsets.all(10.w),
              height: 85.w,
              child: Center(
                widthFactor: 1.w,
                child: Container(
                  width: Get.width,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.w)),
                      backgroundColor: Get.theme.primaryColor,
                      // disabledColor: Constants.themeGreyLight,
                      onSurface: Get.theme.primaryColor.withOpacity(0.5.w),
                    ),
                    child: Text(
                      "${S.of(context).submit.toUpperCase()}",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () =>
                        _userController.askQuestion(_questionInputCtrl.text),
                  ),
                ),
              ))
          : null,
      body: SingleChildScrollView(
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
                  bottomLeft: Radius.circular(24.w),
                  bottomRight: Radius.circular(24.w))),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                alignment: Alignment.centerLeft,
                child: Text(
                  S.of(context).yourQuestion,
                  style: TextStyle(fontSize: 17.w, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                alignment: Alignment.centerLeft,
                child: Text(
                  S.of(context).askQuestion,
                  style: TextStyle(
                      fontSize: 14.w,
                      fontWeight: FontWeight.w600,
                      color: Constants.themeGreyDark),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.w),
                margin: EdgeInsets.only(top: 10.w),
                width: Get.width,
                height: Get.height.h / 4.5.h,
                child: TextFormField(
                  textAlign: TextAlign.start,
                  maxLines: 10,
                  minLines: 10,
                  // expands: true,
                  onChanged: (text) {
                    setState(() {});
                  },
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(fontSize: 14.w),
                  decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintText: S.of(context).typeYourQuestion,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Constants.themeGreyLight.withOpacity(.2.w),
                          ),
                          borderRadius: BorderRadius.circular(5.w)),
                      contentPadding: EdgeInsets.all(20.w)),
                  controller: _questionInputCtrl,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                padding: EdgeInsets.only(bottom: 10.w),
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.check_circle,
                  color: Get.theme.primaryColor,
                  size: 40.w,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
