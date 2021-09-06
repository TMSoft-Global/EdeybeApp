import 'package:edeybe/index.dart';
import 'package:flutter/material.dart';

class CapsuleWiget extends StatelessWidget {
  CapsuleWiget(
      {Key key,
      this.color,
      this.borderColor,
      this.text,
      this.textColor,
      this.borderRadius,
      this.padding,
      this.child,
      this.onPressed})
      : super(key: key);
  final Color color;
  final Color borderColor;
  final EdgeInsets padding;
  final TextStyle textColor;
  final String text;
  final double borderRadius;
  final Widget child;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 30.w),
      // height: 30.h,
      margin: EdgeInsets.only(right: 5.w),
      decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? Colors.grey),
          borderRadius: BorderRadius.circular(borderRadius ?? 5.w),
          color: color ?? Colors.transparent),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: padding ??
              EdgeInsets.only(
                left: 8.w,
                right: 8.w,
              ),
          child: child ??
              Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: textColor != null
                      ? textColor
                      : Get.textTheme.bodyText1.copyWith(fontSize: 13.w),
                ),
              ),
        ),
      ),
    );
  }
}
