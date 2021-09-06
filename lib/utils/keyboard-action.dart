import 'package:edeybe/screens/checkout_screen/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget action(FocusNode node) {
  return GestureDetector(
    onTap: () => node.unfocus(),
    child: Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 15.w),
      child: Text(
        "Done",
        style: TextStyle(color: Constants.themeBlueLight),
      ),
    ),
  );
}
