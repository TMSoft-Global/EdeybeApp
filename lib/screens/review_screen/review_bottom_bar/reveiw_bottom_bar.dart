import 'package:edeybe/index.dart';
import 'package:flutter/material.dart';

class ReviewBottomBar extends StatelessWidget {
  final Function onWriteReview;

  const ReviewBottomBar({
    Key key,
    @required this.onWriteReview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      height: 65.w,
      child: Center(
        widthFactor: 1.w,
        child: Container(
          width: Get.width,
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.w)),
              backgroundColor: Get.theme.primaryColor,
              onSurface: Get.theme.primaryColor.withOpacity(0.5.w),
            ),
            child: Text(
              "${S.of(context).writeReview.toUpperCase()}",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: onWriteReview,
          ),
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
            color: Colors.grey[200],
            width: 1.w,
          ))),
    );
  }
}
