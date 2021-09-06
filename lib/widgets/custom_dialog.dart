import 'package:edeybe/index.dart';
import 'package:edeybe/widgets/custom_divider.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confrimText;
  final String cancelText;
  final VoidCallback confrimPressed;
  final VoidCallback cancelPressed;
  CustomDialog(
      {Key key,
      this.title,
      this.content,
      this.confrimText,
      this.cancelText,
      this.confrimPressed,
      this.cancelPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8.w)),
          width: Get.width / 1.4,
          height: 145.w,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.only(top: 5.w, left: 10.w, right: 10.w),
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 15.w,
                            fontFamily: 'Arabic',
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                            color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 5.w, left: 20.w, right: 20.w, bottom: 5.w),
                      child: Text(
                        content,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                            fontFamily: 'Arabic',
                            fontSize: 14.w,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ],
                ),
              ),
              CustomDivider(
                height: 2,
                thickness: 1,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: (Get.width / 1.4) / 2,
                        height: 40.w,
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    width: .5.w, color: Colors.grey[200]))),
                        child: TextButton(
                          child: Text(
                            cancelText ?? "Cancel",
                            style: TextStyle(
                                fontFamily: 'Arabic',
                                fontSize: 14.w,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.none),
                          ),
                          onPressed: cancelPressed ??
                              () {
                                Get.back();
                              },
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: (Get.width / 1.4) / 2,
                        height: 40.w,
                        decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    width: .5.w, color: Colors.grey[200]))),
                        child: TextButton(
                          child: Text(
                            confrimText ?? "Okay",
                            style: TextStyle(
                                fontFamily: 'Arabic',
                                fontSize: 14.w,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.none),
                          ),
                          onPressed: confrimPressed ??
                              () {
                                Get.back();
                              },
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
