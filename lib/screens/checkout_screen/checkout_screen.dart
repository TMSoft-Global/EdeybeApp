import 'package:dio/dio.dart';
import 'package:edeybe/encryption/encryptData.dart';
import 'package:edeybe/models/deliveryModel.dart';
import 'package:edeybe/screens/home_screen/index.dart';
import 'package:edeybe/utils/card_enum.dart';
import 'package:edeybe/utils/helper.dart';
import 'package:edeybe/utils/strings.dart';
import 'package:edeybe/widgets/Shimmer.dart';
import 'package:edeybe/widgets/alert.dart';
import 'package:edeybe/widgets/custom_dialog.dart';
import 'package:edeybe/widgets/custom_web_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'index.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/screens/address_screen/add_edit_address/add_edit_address.dart';
import 'package:edeybe/screens/review_screen/write_review/write_review.dart';
import 'package:edeybe/utils/cart_item_type.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:edeybe/utils/dialog_enum.dart';
import 'package:edeybe/widgets/cart_item.dart';
import 'package:edeybe/widgets/custom_divider.dart';
import 'package:edeybe/widgets/full_screen_dialog.dart';
import 'package:edeybe/widgets/money_widget.dart';
import 'package:edeybe/widgets/address_card.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen({Key key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final formatCurrency = new NumberFormat.simpleCurrency(name: "");
  DeliveryAddress address;
  ShippingAddress ship;
  PaymentCard _paymentCard = PaymentCard();
  TextEditingController pinController = TextEditingController();
  TextEditingController _firstnameCtrl = TextEditingController();
  TextEditingController _mobileCtrl = TextEditingController();
  TextEditingController _lastnameCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();
  FocusNode cvvFocus = FocusNode();
  String _selectedPaymentMethod;
  var _cartController = Get.find<CartController>();
  var _addressController = Get.find<AddressController>();
  var _paymentController = Get.find<PaymentMethodController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode _firstname = FocusNode();
  final FocusNode _lastname = FocusNode();
  final FocusNode _email = FocusNode();
  final FocusNode _mobile = FocusNode();

  bool autoValidate = false;
  bool acceptTnC = false;
  // final name
  // GlobalKey<FormFieldState> _cvv = new GlobalKey<FormFieldState>();
  TextStyle style = TextStyle(fontSize: 14.w);
  String cvvNo;
  var cvvCtrl = new TextEditingController();
  _setCardCVV(String text) {
    setState(() {
      _paymentCard.cvv = int.parse(text);
    });
  }

  void _setPaymentMethod(value) {
    setState(() => _selectedPaymentMethod = value);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _cartController.getCartITems();
      if (_addressController.selectedAddress != null &&
          _addressController.selectedAddress.id != null) {
        _cartController.getDeliveryCost();
      }
    });
    if (_addressController.addresses != null &&
        _addressController.addresses.isNotEmpty) {
      print(_addressController.addresses);
      _mobileCtrl.text = _addressController.addresses[0].phone;
      _firstnameCtrl.text = _addressController.addresses[0].firstName;
      _lastnameCtrl.text = _addressController.addresses[0].lastName;
      _emailCtrl.text = _addressController.addresses[0].email;
    }
  }

  bool canPlaceOrder() {
    return (_addressController.selectedAddress != null &&
            _addressController.selectedAddress.id != null) &&
        _selectedPaymentMethod != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          iconTheme: Get.theme.iconTheme.copyWith(color: Colors.white),
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Text(S.of(context).checkout,
              style: TextStyle(color: Colors.white)),
        ),
        bottomNavigationBar: AnimatedContainer(
          duration: Duration(microseconds: 200),
          padding: EdgeInsets.all(10.w),
          height: 85.h,
          child: Center(
            widthFactor: 1.w,
            child: Container(
              width: Get.width,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.w)),
                  backgroundColor: canPlaceOrder()
                      ? Get.theme.primaryColor
                      : Constants.themeGreyLight,
                  onSurface: Get.theme.primaryColor.withOpacity(0.5),
                ),
                child: Text(
                  S.of(context).placeOrder.toUpperCase(),
                  style: TextStyle(
                      color: canPlaceOrder() ? Colors.white : Colors.black),
                ),
                onPressed: canPlaceOrder()
                    ? () {
                        if (acceptTnC) {
                          // "rico@mail.com password!1$"
                          if (_formKey.currentState.validate()) {
                            var selectedCard = _paymentController.cards
                                .firstWhere((card) =>
                                    card.id == _selectedPaymentMethod);

                            if (selectedCard.paytype == 1) {
                              cvvAlert(context, pinController, cvvFocus,
                                  onTap: () async {
                                Get.back();
                                await encryptData(pinController.text.trim())
                                    .then((value) => cvvNo = value);
                                if (pinController.text.isNotEmpty) {
                                  _cartController.checkout({
                                    "paymentMethodId": selectedCard.id,
                                    "deliveryAddressId":
                                        _addressController.selectedAddress.id,
                                    "cvv": selectedCard.paytype == 1
                                        ? cvvNo
                                        : null,
                                    "shippingAddress": {
                                      "firstName": _firstnameCtrl.text,
                                      "lastName": _lastnameCtrl.text,
                                      "phone": _mobileCtrl.text.trim(),
                                      "email": _emailCtrl.text.trim(),
                                    }
                                  }, (data) {
                                    var err = data as DioError;
                                    String message =
                                        "${err.response.data['error'][0]}";
                                    print(data);
                                    // String message =
                                    //     "${data.response.data['error'][0]}";
                                    print(message);
                                    // if (data.containsKey("success")) {
                                    //   if (data.containsKey("code") &&
                                    //       data["code"] != null) {
                                    //     showCheckoutDialog(
                                    //         type: data["code"] == '000'
                                    //             ? DialogEnum.Success
                                    //             : DialogEnum.Error);
                                    //   } else {
                                    //     showCheckoutDialog(type: DialogEnum.Error);
                                    //   }
                                    // } else {
                                    //   var message = data["error"] is String
                                    //       ? data['error']
                                    //       : data["error"][0];
                                    //   Helper.showError(message);
                                    // }
                                  });
                                } else {
                                  Get.dialog(CustomDialog(
                                    title: 'Required',
                                    content: 'Pin required',
                                  ));
                                }
                              });
                            } else {
                              // Get.to(HomeIndex(
                              //   indexPage: 0,
                              // ));
                              // Get.defaultDialog(
                              //   title: 'Processing',
                              //   content: Text("Transaction is being processed"),
                              // );
                              // showCheckoutDialog(state: CheckoutStateEnum.Init);
                              _cartController.checkout({
                                "paymentMethodId": selectedCard.id,
                                "deliveryAddressId":
                                    _addressController.selectedAddress.id,
                                "cvv": null,
                                "shippingAddress": {
                                  "firstName": _firstnameCtrl.text,
                                  "lastName": _lastnameCtrl.text,
                                  "phone": _mobileCtrl.text.trim(),
                                  "email": _emailCtrl.text.trim(),
                                }
                              }, (data) {
                                print("------------------------$data");
                                if (data.containsKey("success")) {
                                  // if (data.containsKey("code") &&
                                  //     data["code"] != null) {
                                  showCheckoutDialog(type: DialogEnum.Success);
                                  _cartController.getCartITems();
                                  // } else {
                                  // }
                                } else {
                                  showCheckoutDialog(type: DialogEnum.Error);
                                  var message = data["error"] is String
                                      ? data['error']
                                      : data["error"][0];
                                  Helper.showError(message);
                                }
                              });
                            }
                          }
                        } else {
                          Get.dialog(CustomDialog(
                            title: "Accept Terms and Condition",
                            content:
                                "Scroll to the bottom and accept T&C, You can tap on it to read T&C.",
                          ));
                        }
                      }
                    : null,
              ),
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(
                color: Colors.grey[200],
                width: 1.0,
              ))),
        ),
        body: Shimmer(
            linearGradient: Constants.shimmerGradient,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _buildCartSummary,
                  _shippingTo,
                  GetBuilder<AddressController>(
                      builder: (_) => _addressController.selectedAddress !=
                                  null &&
                              _addressController.selectedAddress.id != null
                          ? AddressCard(
                              onCardPressed: null,
                              showChangeButton: true,
                              onChangeButtonPressed: () => Get.to(AddressScreen(
                                    hasContinueButton: true,
                                    onContinuePressed: Get.back,
                                  )),
                              deliveryAddress:
                                  _addressController.selectedAddress,
                              onEditAddress: () => Get.to(AddorEditScreen(
                                    address: _addressController.selectedAddress,
                                  )),
                              onRemoveAddress: null)
                          : Container(
                              // height: 30.w,
                              margin: EdgeInsets.all(10.w),
                              padding: EdgeInsets.all(10.0.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.w),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Constants.boxShadow,
                                      blurRadius: 3.4.w,
                                      offset: Offset(0, 3.4.w),
                                    )
                                  ]),
                              child: Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: InkWell(
                                        onTap: () => Get.to(AddressScreen(
                                          hasContinueButton: true,
                                          onContinuePressed: Get.back,
                                        )),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 10.w, bottom: 8.w),
                                              width: 60.w,
                                              height: 40.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.w),
                                                color: Colors.white,
                                                border: Border.symmetric(
                                                    vertical: BorderSide(
                                                        color: Constants
                                                            .themeGreyDark),
                                                    horizontal: BorderSide(
                                                        color: Constants
                                                            .themeGreyDark)),
                                              ),
                                              child:
                                                  Icon(Icons.add, size: 25.w),
                                            ),
                                            Container(
                                              height: 40.w,
                                              child: Text(
                                                  S.of(context).addAddress,
                                                  style: Get.textTheme.bodyText1
                                                      .copyWith(
                                                          fontSize: 16.w)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ))),
                  _biuldPaymentMethod,
                  _buildCartItem,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:10.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      TextButton(
                          onPressed: () => Get.to(CustomWebView(
                                title: "Term and Conditions",
                                url: 'https://edeybe.com/m/terms-conditions',
                              )),
                          child: Text(
                            "Terms and conditions applied",
                            style: Get.theme.textTheme.bodyText2,
                          )),
                      Checkbox(
                          activeColor: Get.theme.toggleableActiveColor,
                          value: acceptTnC,
                          onChanged: (va) {
                            setState(() {
                              acceptTnC = !acceptTnC;
                            });
                          })
                    ]),
                  )
                ],
              ),
            )));
  }

  Widget get _shippingTo {
    return Container(
      margin: EdgeInsets.fromLTRB(10.w, 20.w, 10.w, 10.w),
      padding: EdgeInsets.all(5.0.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.w),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Constants.boxShadow,
              blurRadius: 3.4.w,
              offset: Offset(0, 3.4.w),
            )
          ]),
      child: Form(
        key: _formKey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        // autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Shipping Address",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18.w)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
              child: SizedBox(
                child: TextFormField(
                  focusNode: _firstname,
                  validator: (value) {
                    return value.length > 3 ? null : Strings.fieldReq;
                  },
                  style: TextStyle(fontSize: 14.w),
                  decoration: InputDecoration(
                    hintText: S.of(context).firstName,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Constants.themeGreyLight, width: 1.0.w),
                        borderRadius: BorderRadius.circular(5.0.w)),
                    contentPadding: EdgeInsets.all(10.0.w),
                  ),
                  controller: _firstnameCtrl,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: SizedBox(
                child: TextFormField(
                  focusNode: _lastname,
                  validator: (value) {
                    return value.length > 2 ? null : Strings.fieldReq;
                  },
                  style: TextStyle(fontSize: 14.w),
                  decoration: InputDecoration(
                    hintText: S.of(context).lastName,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Constants.themeGreyLight, width: 1.0.w),
                        borderRadius: BorderRadius.circular(5.0.w)),
                    contentPadding: EdgeInsets.all(10.0.w),
                  ),
                  controller: _lastnameCtrl,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: SizedBox(
                // height: 47.w,
                child: TextFormField(
                  focusNode: _email,
                  validator: Helper.validateEmail,
                  style: TextStyle(fontSize: 14.w),
                  decoration: InputDecoration(
                    hintText: S.of(context).email,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Constants.themeGreyLight, width: 1.0.w),
                        borderRadius: BorderRadius.circular(5.0.w)),
                    contentPadding: EdgeInsets.all(10.0.w),
                  ),
                  controller: _emailCtrl,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      // height: 47.w,
                      child: TextFormField(
                        focusNode: _mobile,
                        validator: Helper.validateMobileNumberStrict,
                        style: TextStyle(fontSize: 14.w),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: S.of(context).mobileNumberPlaceholder,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Constants.themeGreyLight,
                                  width: 1.0.w),
                              borderRadius: BorderRadius.circular(5.0.w)),
                          contentPadding: EdgeInsets.all(10.0.w),
                        ),
                        controller: _mobileCtrl,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // build card for cart summary
  Widget get _buildCartSummary {
    return GetBuilder<CartController>(builder: (_) {
      var totalAmonut = _cartController.cartItems.fold(
          0,
          (previousValue, element) =>
              previousValue +
              (element.hasDiscount ? element.discountPrice : element.price) *
                  (element.quantity));
      var totalDiscount = _cartController.cartItems.fold(
          0,
          (previousValue, element) =>
              previousValue +
              ((element.hasDiscount ? element.discountPrice : 0) *
                  element.quantity));
      //     *
      // (element.price)));
      return Container(
        margin: EdgeInsets.fromLTRB(10.w, 20.w, 10.w, 10.w),
        padding: EdgeInsets.all(10.0.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.w),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Constants.boxShadow,
                blurRadius: 3.4.w,
                offset: Offset(0, 3.4.w),
              )
            ]),
        child: Table(
          children: <TableRow>[
            TableRow(children: [
              TableCell(
                child: Text(S.of(context).cartSummary,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18.w)),
              ),
              TableCell(
                child: Text(""),
              )
            ]),
            TableRow(children: [
              TableCell(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "${S.of(context).subtotal} (${_cartController.cartItems.length} ${S.of(context).items})"),
                ),
              ),
              TableCell(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: MoneyWidget(
                    offset: Offset(0, 3.5),
                    fontWeight: FontWeight.w700,
                    currencyFirst: true,
                    children: [
                      TextSpan(
                          text: formatCurrency.format(double.parse(
                              "${_cartController.cartCost.total}".toString())),
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 14.w))
                    ],
                  ),
                ),
              ),
            ]),
            // TableRow(children: [
            //   TableCell(
            //     child: Container(
            //       alignment: Alignment.centerLeft,
            //       child: Text("${S.of(context).promotionDiscounts}"),
            //     ),
            //   ),
            //   TableCell(
            //     child: Container(
            //       alignment: Alignment.centerRight,
            //       child: MoneyWidget(
            //         offset: Offset(0, 4),
            //         fontWeight: FontWeight.w700,
            //         currencyFirst: true,
            //         children: [
            //           TextSpan(
            //               text: formatCurrency.format(totalDiscount),
            //               style: TextStyle(
            //                   fontWeight: FontWeight.normal,
            //                   color: Colors.black,
            //                   fontSize: 14.w))
            //         ],
            //       ),
            //     ),
            //   ),
            // ]),
            TableRow(children: [
              TableCell(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(""),
                ),
              ),
              TableCell(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(""),
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text("${S.of(context).deliveryCharges}"),
                ),
              ),
              TableCell(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: _cartController.deliveryCost.deliveryCost != null
                      ? MoneyWidget(
                          offset: Offset(0, 4),
                          fontWeight: FontWeight.w700,
                          currencyFirst: true,
                          children: [
                            TextSpan(
                                text: _cartController.deliveryCost.deliveryCost
                                    .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontSize: 14.w))
                          ],
                        )
                      : Helper.textPlaceholder,
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Est. ${S.of(context).total}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17.w)),
                ),
              ),
              TableCell(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: _cartController.deliveryCost.deliveryCost != null
                      ? MoneyWidget(
                          offset: Offset(0, 6),
                          scalefactor: 1,
                          fontWeight: FontWeight.w700,
                          currencyFirst: true,
                          children: [
                            // totalDiscount
                            TextSpan(
                                text: formatCurrency.format(double.parse(
                                        _cartController
                                            .deliveryCost.overallCost ) 
                                    ),
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                    fontSize: 16.w))
                          ],
                        )
                      : Helper.textPlaceholder,
                ),
              ),
            ]),
          ],
        ),
      );
    });
  }

  // build card items i.e. wishlist , selected items
  Widget get _buildCartItem {
    return GetBuilder<CartController>(
        builder: (_) => Column(
                children: [
              Container(
                margin: EdgeInsets.only(top: 10.w, bottom: 8.w),
                child: CustomDivider(
                  height: 2.w,
                  thickness: 2.w,
                ),
              )
            ]..addAll(_cartController.cartItems
                    // <-- should be a list of user selected items
                    .map<Widget>((e) => CartItem(
                          product: e,
                          type: CartItemType.Checkout,
                        ))
                    .toList())));
  }

  // biuld payment method card
  Widget get _biuldPaymentMethod {
    return GetBuilder<PaymentMethodController>(
        builder: (_) => Container(
            // height: 30.w,
            margin: EdgeInsets.all(10.w),
            padding: EdgeInsets.all(10.0.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.w),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Constants.boxShadow,
                    blurRadius: 3.4.w,
                    offset: Offset(0, 3.4.w),
                  )
                ]),
            child: Table(
              children: <TableRow>[
                TableRow(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 8.w),
                      child: Text(S.of(context).paymentMethod,
                          style: Get.textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 18.w)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Table(
                      children: _paymentController.cards
                          .map<TableRow>((e) => TableRow(children: [
                                _paymentMethodItem(
                                    e.type,
                                    e.number,
                                    e.id,
                                    CardUtils.getCardIcon(e.type),
                                    _selectedPaymentMethod == e.number,
                                    () => _setPaymentMethod)
                              ]))
                          .toList(),
                    ),
                  ],
                ),
                TableRow(children: [
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: InkWell(
                            onTap: () => Get.to(PaymentMethodScreen(
                              hasContinueButton: true,
                              onContinuePressed: (pan) {
                                print(pan);
                                _setPaymentMethod(pan);
                                Get.back();
                              },
                            )),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin:
                                      EdgeInsets.only(right: 10.w, bottom: 8.w),
                                  width: 60.w,
                                  height: 40.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.w),
                                    color: Colors.white,
                                    border: Border.symmetric(
                                        vertical: BorderSide(
                                            color: Constants.themeGreyDark),
                                        horizontal: BorderSide(
                                            color: Constants.themeGreyDark)),
                                  ),
                                  child: Icon(Icons.add, size: 25.w),
                                ),
                                Container(
                                  height: 40.w,
                                  child: Text(S.of(context).addPaymentMethod,
                                      style: Get.textTheme.bodyText1
                                          .copyWith(fontSize: 16.w)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ],
            )));
  }

  // payment method item
  Widget _paymentMethodItem(type, String pan, String id, Widget icon,
      bool isSelected, VoidCallback onSelect) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10.w, bottom: 8.w),
                padding: EdgeInsets.all(5.w),
                width: 60.w,
                height: 45.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.w),
                  color: Colors.white,
                  border: isSelected
                      ? Border.symmetric(
                          vertical: BorderSide(color: Get.theme.primaryColor),
                          horizontal: BorderSide(color: Get.theme.primaryColor))
                      : null,
                ),
                child: icon,
              ),
              Container(
                height: 40.w,
                child: Text(pan,
                    style: Get.textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 17.w,
                        color: isSelected
                            ? Get.theme.primaryColor
                            : Colors.black)),
              ),
            ],
          ),
          if (type == CardType.MasterCard || type == CardType.Visa)
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Offstage(
                  offstage: !isSelected,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    width: Get.width,
                    child: TextFormField(
                      autofocus: isSelected,
                      enabled: true,
                      // key: _cvv,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        new LengthLimitingTextInputFormatter(4),
                      ],
                      controller: cvvCtrl,
                      style: style,
                      keyboardType: TextInputType.number,
                      // onFieldSubmitted: (String text) {
                      //   onDone();
                      // },
                      onChanged: _setCardCVV,
                      validator: CardUtils.validateCVV,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Constants.themeGreyLight.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(5.w)),
                        labelStyle: TextStyle(fontSize: 14.w),
                        contentPadding: EdgeInsets.all(10.w),
                        hintText: '233',
                        labelText: S.of(context).cvv,
                        // floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintStyle: TextStyle(fontSize: 14.w),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          Container(
              alignment: Alignment.centerRight,
              child: Radio(
                toggleable: true,
                activeColor: Get.theme.primaryColor,
                groupValue: _selectedPaymentMethod,
                onChanged: _setPaymentMethod,
                value: id,
              ))
        ],
      ),
    );
  }

  void showCheckoutDialog({DialogEnum type, CheckoutStateEnum state}) {
    var call = state == null ? Get.off : Get.to;
    call(FullScreenDialog(
      type: type,
      state: state,
      actions: <Widget>[
        if (type == DialogEnum.Success)
          // Padding(
          //   padding: EdgeInsets.only(left: 8.0.w, top: 8.0.w),
          //   child: ButtonTheme(
          //     minWidth: Get.width,
          //     height: 40.w,
          //     child: TextButton(
          //       style: TextButton.styleFrom(
          //         shape: RoundedRectangleBorder(
          //             side: BorderSide(color: Colors.white, width: 1.0.w),
          //             borderRadius: BorderRadius.circular(8.w)),
          //         backgroundColor: Get.theme.primaryColor,
          //         onSurface: Get.theme.primaryColor.withOpacity(0.5.w),
          //       ),
          //       child: Text(
          //         "${S.of(context).writeAReview}",
          //         maxLines: 1,
          //         style: TextStyle(color: Colors.white),
          //         overflow: TextOverflow.ellipsis,
          //       ),
          //       onPressed: () {
          //         if (navigator.canPop()) navigator.pop();
          //         Get.off(WriteReviewScreen());
          //       },
          //     ),
          //   ),
          // ),

          Padding(
            padding: EdgeInsets.only(left: 8.0.w, top: 8.0.w),
            child: ButtonTheme(
              minWidth: Get.width,
              height: 45.w,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Get.theme.primaryColor),
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  state != null
                      ? S.of(context).problemWithPayment
                      : S.of(context).continueShopping,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(color: Get.theme.primaryColor),
                ),
                onPressed: () {
                  _cartController.getCartITems();
                  Get.off(HomeIndex());
                },
              ),
            ),
          ),
      ],
      message: Text(
          state == CheckoutStateEnum.Init
              ? S.of(context).processingRequest
              : type == DialogEnum.Success
                  ? S.of(context).orderPlaceSuccess
                  : S.of(context).orderPlaceFailed,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: state != null ? 15.w : 20.w)),
    ));
  }
}
