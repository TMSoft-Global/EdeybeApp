import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key key, this.height, this.thickness, this.color})
      : super(key: key);
  final double height;
  final double thickness;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Divider(
        height: height ?? 1.0,
        thickness: thickness ?? 1.0,
        color: color ?? Colors.grey[200],
      ),
    );
  }
}
