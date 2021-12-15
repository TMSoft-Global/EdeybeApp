import 'package:edeybe/index.dart';
import 'package:flutter/material.dart';

class CartBottomBar extends StatelessWidget {
  final Function onGoToCheckout;
  final int quantity;
  final String totalAmount;
  final String currency;
  const CartBottomBar({
    Key key,
    @required this.onGoToCheckout,
    @required this.quantity,
    @required this.totalAmount,
    @required this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      height: 66.w,
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
              "${S.of(context).continueText.toUpperCase()} ($quantity ${S.of(context).items.toUpperCase()} ${S.of(context).fortext.toUpperCase()} $currency$totalAmount)",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: onGoToCheckout,
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
