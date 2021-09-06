import 'package:edeybe/index.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:flutter/material.dart';

class ListEmptyWidget extends StatelessWidget {
  final String icon;
  final String message;
  final Widget child;
  const ListEmptyWidget(
      {Key key, this.child, this.icon, @required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Image.asset(
                    icon ?? "assets/images/empty_icon.png",
                    width: Get.width / 2,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: Get.width / 2,
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Constants.themeGreyDark, fontSize: 17.w),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30.w),
            padding: EdgeInsets.only(right: 8.0.w, top: 8.0.w),
            child: ButtonTheme(
              height: 44.w,
              minWidth: (Get.width / 1.5).w,
              child: child ?? null,
            ),
          ),
        ],
      ),
    );
  }
}
