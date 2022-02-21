import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        padding: EdgeInsets.all(8),
        height: size.width > 1000 ? 20.w: 40.w,
        width: size.width > 1000 ? 20.w: 40.w,
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
