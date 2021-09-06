import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';

class SeeMoreWidget extends StatelessWidget {
  final bool canSeeMore;
  final bool loading;

  final VoidCallback onPress;

  SeeMoreWidget({Key key, this.onPress, this.canSeeMore, this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: this.canSeeMore
            ? TextButton(
                style:
                    TextButton.styleFrom(textStyle: TextStyle(fontSize: 12.w)),
                onPressed: this.onPress,
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: this.loading
                      ? SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ))
                      : Text('See More'),
                )),
              )
            : Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 5.w),
                child: Text('No more data to show',
                    style: TextStyle(fontSize: 13.w))));
  }
}
