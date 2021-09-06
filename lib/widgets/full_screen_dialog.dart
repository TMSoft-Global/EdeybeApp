import 'package:edeybe/index.dart';
import 'package:edeybe/utils/dialog_enum.dart';
import 'package:edeybe/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullScreenDialog extends StatelessWidget {
  final Color backgroundColor;
  final DialogEnum type;
  final CheckoutStateEnum state;
  final Widget message;
  final List<Widget> actions;
  final Widget icon;
  const FullScreenDialog(
      {Key key,
      this.actions,
      this.backgroundColor,
      this.message,
      this.type,
      this.state,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var iconType = type == DialogEnum.Success
        ? Icons.check_circle
        : FontAwesomeIcons.timesCircle;
    return Scaffold(
      backgroundColor: backgroundColor ?? Get.theme.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: state == null
                  ? icon ??
                      Icon(iconType,
                          size: 120.w,
                          color: type == DialogEnum.Success
                              ? Colors.white
                              : Colors.red)
                  : LoadingWidget(),
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                width: state == null ? Get.width / 1.6.w : (Get.width - 40).w,
                padding: EdgeInsets.all(20.w),
                alignment: Alignment.topCenter,
                child: message,
              )),
          if (actions != null)
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(10.w),
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: actions,
                ),
              ),
            )
        ],
      ),
    );
  }
}
