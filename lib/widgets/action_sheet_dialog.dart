import 'package:edeybe/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';

Future<bool> actionSheetDialog(Widget child, {double height}) {
  return Get.bottomSheet<bool>(
      DraggableScrollableSheet(
          initialChildSize: height ?? .5,
          minChildSize: height ?? .5,
          maxChildSize: .9,
          expand: true,
          builder: (context, scrollController) => Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      blurRadius: 1.4.w,
                      offset: Offset(0, 1.4.w),
                      color: Constants.boxShadow)
                ],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.w),
                    topLeft: Radius.circular(20.w)),
                color: Colors.white,
              ),
              child: CustomScrollView(controller: scrollController, slivers: [
                SliverFillRemaining(
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: (Get.width / 3).w,
                          height: 3.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Constants.themeGreyDark,
                              borderRadius: BorderRadius.circular(5.w)),
                        ),
                      ),
                      Expanded(
                        child: child ?? null,
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                    ],
                  ),
                )
              ]))),
      isDismissible: true,
      isScrollControlled: true,
      ignoreSafeArea: false);
}
