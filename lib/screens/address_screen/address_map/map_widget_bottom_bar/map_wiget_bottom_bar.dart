import 'package:edeybe/index.dart';
import 'package:flutter/material.dart';

class MapWidgetBottomBar extends StatelessWidget {
  final Function onGetLocation;
  final Function onConfirmLocation;
  const MapWidgetBottomBar({
    Key key,
    @required this.onGetLocation,
    @required this.onConfirmLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
      height: 60.h,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Get.theme.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(4.w)),
                onSurface: Get.theme.primaryColor.withOpacity(0.5),
              ),
              child: Text(
                S.of(context).locateme,
                style: TextStyle(color: Get.theme.primaryColor),
              ),
              onPressed: onGetLocation,
            ),
            SizedBox(
              width: 10.w,
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Get.theme.primaryColor,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Get.theme.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(4.w)),
                onSurface: Get.theme.primaryColor.withOpacity(0.5),
              ),
              child: Text(
                S.of(context).confirmLocation,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: onConfirmLocation,
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
            color: Colors.grey[200],
            width: 1.0,
          ))),
    );
  }
}
