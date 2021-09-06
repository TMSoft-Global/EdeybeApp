import 'package:edeybe/index.dart';
import 'package:flutter/material.dart';

class ApplyFillterBottomBar extends StatelessWidget {
  final Function onApply;
  final int totalPossible;

  const ApplyFillterBottomBar({
    Key key,
    @required this.onApply,
    @required this.totalPossible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      height: 95.w,
      child: Center(
        widthFactor: 1.w,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text("(${totalPossible ?? 0}) items"),
            ),
            Container(
              width: Get.width,
              height: 45,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.w)),
                  backgroundColor: Get.theme.primaryColor,
                  onSurface: Get.theme.primaryColor.withOpacity(0.5.w),
                ),
                child: Center(
                  child: Text(
                    "${S.of(context).apply}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: onApply,
              ),
            ),
          ],
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
