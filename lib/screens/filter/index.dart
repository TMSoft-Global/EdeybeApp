import 'package:edeybe/screens/checkout_screen/index.dart';
import 'package:edeybe/screens/filter/fillter_widget.dart';
import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';

class Filter extends StatelessWidget {
  Filter({Key key, this.switchListView, this.sortBy, this.viewType, this.onApply})
      : super(key: key);
  final Function switchListView;
  final Function sortBy;
  final Function(Map<String, String>) onApply;
  final bool viewType;
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 5.w),
      color: Colors.white,
      height: 40.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: TextButton.icon(
              onPressed: () {
                Get.to<Map<String,String>>(FilterWidget()).then((value){
                  if(value!=null) this.onApply(value);
                });
              },
              label: Container(
                // margin: EdgeInsets.only(right: 5.w),
                child: Text(
                  S.current.filter,
                  style: Get.textTheme.bodyText1
                      .copyWith(color: Constants.mainColor),
                ),
              ),
              icon: Icon(
                Icons.filter_list_rounded,
                size: 15.w,
                color: Constants.mainColor,
              ),
            ),
          ),
          Container(
            width: 1.w,
            height: 28.w,
            color: Constants.themeGreyLight,
          ),
          Expanded(
            child: TextButton.icon(
              onPressed: sortBy,
              label: Container(
                // margin: EdgeInsets.only(right: 10.w),
                child: Text(
                  S.current.sort,
                  style: Get.textTheme.bodyText1
                      .copyWith(color: Constants.mainColor),
                ),
              ),
              icon: Icon(
                Icons.sort,
                size: 15.w,
                color: Constants.mainColor,
              ),
            ),
          ),
          Container(
            width: 1.w,
            height: 28.w,
            color: Constants.themeGreyLight,
          ),
          Expanded(
            child: TextButton.icon(
              onPressed: switchListView,
              label: Container(
                // margin: EdgeInsets.only(right: 10.w),
                child: Text(
                  viewType ? S.current.listView : S.current.gridView,
                  style: Get.textTheme.bodyText1
                      .copyWith(color: Constants.mainColor),
                ),
              ),
              icon: Icon(
                viewType ? FontAwesomeIcons.list : FontAwesomeIcons.borderAll,
                size: 15.w,
                color: Constants.mainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
