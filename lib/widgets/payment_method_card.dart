import 'package:edeybe/index.dart';
import 'package:edeybe/models/card.dart';
import 'package:edeybe/utils/card_utils.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:flutter/material.dart';

class PaymentMethodCard extends StatelessWidget {
  final PaymentCard paymentMethod;
  final VoidCallback onRemovePaymentMethod;
  final VoidCallback onCardPressed;
  final bool isSelected;
  const PaymentMethodCard(
      {Key key,
      @required this.onCardPressed,
      @required this.paymentMethod,
      @required this.onRemovePaymentMethod,
      this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardPressed,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.w),
            color: Colors.white,
            border: isSelected
                ? Border.symmetric(
                    vertical: BorderSide(color: Get.theme.primaryColor),
                    horizontal: BorderSide(color: Get.theme.primaryColor))
                : null,
            boxShadow: [
              BoxShadow(
                color: Constants.boxShadow,
                blurRadius: 3.4.w,
                offset: Offset(0, 3.4.w),
              )
            ]),
        margin: EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 10.w),
        padding: EdgeInsets.fromLTRB(10.w, 5.w, 10.w, 10.w),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Text(paymentMethod.cardHolder,
                      style: TextStyle(
                          fontSize: 18.w, fontWeight: FontWeight.w800)),
                ),
                if (onRemovePaymentMethod != null)
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        if (onRemovePaymentMethod != null)
                          Padding(
                            padding: EdgeInsets.all(0),
                            child: TextButton.icon(
                              icon: Icon(
                                FontAwesomeIcons.trash,
                                size: 13.w,
                                color: Constants.themeGreyDark,
                              ),
                              label: Text(S.of(context).remove,
                                  style: TextStyle(
                                      fontSize: 13.w,
                                      color: Constants.themeGreyDark)),
                              onPressed: onRemovePaymentMethod,
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
            Table(
              children: <TableRow>[
                TableRow(children: [
                  Container(
                    child: Text(S.of(context).cardNumber,
                        style: TextStyle(color: Constants.themeGreyDark)),
                  ),
                ]),
                TableRow(children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 0.0,
                          ),
                          child: Text(
                            CardUtils.maskCard(paymentMethod.number ?? ""),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10.w, bottom: 8.w),
                        // padding: EdgeInsets.all(5.w),
                        width: 60.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.w),
                          color: Colors.white,
                        ),
                        child: CardUtils.getCardIcon(paymentMethod.type),
                      ),
                    ],
                  ),
                ]),
              ],
            ),
            Table(
              children: <TableRow>[
                TableRow(children: [
                  Container(
                    child: Text(
                        S.of(context).month + " / " + S.of(context).year,
                        style: TextStyle(color: Constants.themeGreyDark)),
                  ),
                ]),
                TableRow(children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 0,
                    ),
                    child: Text(
                      paymentMethod.month != null
                          ? "${paymentMethod.month}/${paymentMethod.year}"
                          : '',
                    ),
                  ),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
