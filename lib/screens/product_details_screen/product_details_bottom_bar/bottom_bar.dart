import 'package:edeybe/index.dart';
import 'package:flutter/material.dart';

class ProductDetailsBottomBar extends StatelessWidget {
  final Function onSetQuantity;
  final Function onAddToCart;
  final int quantity;
  ProductDetailsBottomBar({
    Key key,
    @required this.onAddToCart,
    @required this.onSetQuantity,
    @required this.quantity,
  }) : super(key: key);
  final List quatityList = [1, 2, 3, 4, 5, 6];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.w),
      height: 60.w,
      child: Center(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                constraints: BoxConstraints(minHeight: 30.w, maxHeight: 55.w),
                decoration: BoxDecoration(
                    border: Border.all(width: 1.w, color: Colors.grey[200]),
                    borderRadius: BorderRadius.circular(5.w)),
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.only(left: 5.w, right: 8.w),
                child: Column(
                  children: <Widget>[
                    Text(
                      "QTY",
                      style: TextStyle(
                          fontSize: 8.w, fontWeight: FontWeight.normal),
                    ),
                    Expanded(
                      flex: 3,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                            value: quantity ?? 1,
                            isDense: true,
                            // icon: Icon(Icons.keyboard_arrow_down),
                            onChanged: onSetQuantity,
                            items: quatityList
                                .map<DropdownMenuItem<int>>(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      "$e",
                                      textAlign: TextAlign.center,
                                      style: Get.textTheme.bodyText1.copyWith(
                                          fontSize: 13.w,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                                .toList()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Get.theme.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.w)),
                  onSurface: Get.theme.primaryColor.withOpacity(.5.w),
                ),
                child: Text(
                  S.of(context).addToCart.toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: onAddToCart,
              ),
            )
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
