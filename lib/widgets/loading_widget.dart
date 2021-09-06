import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(8),
        height: 40.w,
        width: 40.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
        ),
      ),
    );
  }
}
