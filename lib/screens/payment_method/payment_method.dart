import 'package:edeybe/controllers/payment_method_controller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/models/card.dart';
import 'package:edeybe/screens/payment_method/add_payment_method/add_card.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:edeybe/widgets/custom_dialog.dart';
import 'package:edeybe/widgets/payment_method_card.dart';
import 'package:flutter/material.dart';

class PaymentMethodScreen extends StatefulWidget {
  PaymentMethodScreen(
      {Key key, this.hasContinueButton = false, this.onContinuePressed})
      : super(key: key);
  final bool hasContinueButton;
  final Function onContinuePressed;
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String _activeIndex;
  final _paymentMethodController = Get.find<PaymentMethodController>();
  // final _paymentMethodController = Get.put(PaymentMethodController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        iconTheme: Get.theme.iconTheme.copyWith(color: Colors.white),
        automaticallyImplyLeading: true,
        title: Text(S.of(context).paymentMethod,
            style: TextStyle(color: Colors.white)),
      ),
      bottomNavigationBar: widget.hasContinueButton
          ? Container(
              padding: EdgeInsets.all(10.w),
              height: 85.w,
              child: Center(
                widthFactor: 1.w,
                child: Container(
                  width: Get.width,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.w)),
                      backgroundColor: Get.theme.primaryColor,
                      // disabledColor: Constants.themeGreyLight,
                      onSurface: Get.theme.primaryColor.withOpacity(0.5.w),
                    ),
                    child: Text(
                      "${S.of(context).continueText.toUpperCase()}",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => widget.onContinuePressed(_activeIndex),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(
                    color: Colors.grey[200],
                    width: 1.0.w,
                  ))),
            )
          : null,
      body: Obx((){

      return ListView.builder(
            itemCount: 1 + _paymentMethodController.cards.length,
            itemBuilder: (_, i) {
              if (i == (_paymentMethodController.cards.length)) {
                return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.w),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Constants.boxShadow,
                            blurRadius: 2.w,
                            offset: Offset(0, 3.4.w),
                          )
                        ]),
                    margin: EdgeInsets.all(10.w),
                    padding: EdgeInsets.all(0.0),
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.w)),
                      ),
                      icon: Icon(
                        Icons.add,
                      ),
                      label: Text(S.of(context).addPaymentMethod),
                      onPressed: () {
                        Get.to(AddCardScreen());
                      },
                    ));
              }
              PaymentCard paymentMethod = _paymentMethodController.cards[i];
              return PaymentMethodCard(
                onCardPressed: widget.hasContinueButton
                    ? () => setState(() => _activeIndex = paymentMethod.number)
                    : null,
                paymentMethod: paymentMethod,
                onRemovePaymentMethod: () => _removeCard(paymentMethod),
                isSelected: _activeIndex == paymentMethod.number,
              );
            });
      })
    );
  }

  void _removeCard(PaymentCard card) {
    Get.dialog(CustomDialog(
      title: S.of(context).removePaymentMethod,
      content: S.of(context).removePaymentMethodMessage,
      confrimPressed: () {
        _paymentMethodController.removePaymentMethod(card);
        Get.back();
      },
      cancelText: S.of(context).no,
      confrimText: S.of(context).yes,
    ));
  }
}
