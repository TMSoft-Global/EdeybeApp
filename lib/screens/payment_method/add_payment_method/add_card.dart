import 'package:edeybe/controllers/payment_method_controller.dart';
import 'package:edeybe/encryption/encryptData.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/models/card.dart';
import 'package:edeybe/utils/card_enum.dart';
import 'package:edeybe/utils/card_utils.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:edeybe/utils/helper.dart';
import 'package:edeybe/utils/keyboard-action.dart';
import 'package:edeybe/utils/strings.dart';
import 'package:edeybe/utils/text_formatter.dart';
import 'package:edeybe/widgets/action_sheet_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class AddCardScreen extends StatefulWidget {
  AddCardScreen({Key key, this.card, this.callback}) : super(key: key);
  final PaymentCard card;
  final Function callback;
  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  BuildContext loaderContext;
  final _paymentMethodController = Get.put(PaymentMethodController());
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  GlobalKey<FormFieldState> _cvv = new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _pan = new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _fullname = new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _expire = new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _voucher = new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _provider = new GlobalKey<FormFieldState>();
  var paymodeCtrl = new TextEditingController();
  var voucherCtrl = new TextEditingController();
  var mobileCtrl = new TextEditingController();
  var telcosCtrl = TextEditingController();
  PaymentCard _paymentCard = new PaymentCard();
  TextStyle style = TextStyle(fontSize: 14.w);
  bool checkoutInProgress = false;
  String _voucherCode;
  String _selectedCard;
  int _payMethod = 0;
  bool _autoValidate = false;
  String paymode;
  String encryptedNumber, encryptedYear, encryptedMonth, encryptedCvv;
  // String _selectedCard;
  var numberController = new TextEditingController();
  var fullnameController = new TextEditingController();
  var monthController = new TextEditingController();
  var cvvCtrl = new TextEditingController();
  var expiryCtrl = new TextEditingController();

  final FocusNode _fullnameF = FocusNode();
  final FocusNode _voucherF = FocusNode();
  final FocusNode _cvvF = FocusNode();
  final FocusNode _card = FocusNode();
  final FocusNode _expireF = FocusNode();
  final FocusNode _mobile = FocusNode();

  List<Map<String, String>> telcos = [
    {"name": 'MTN', "value": 'MTN'},
    {"name": 'AirtelTigo', "value": 'ATL'},
    {"name": 'Vodafone', "value": 'VDF'},
    {"name": 'G-Money', "value": 'GMY'},
  ];

  _setCardNumber(String text) {
    _paymentCard.number = CardUtils.getCleanedNumber(text);
  }

  _setFullname(String text) {
    _paymentCard.cardHolder = text;
  }

  _setCardExpireDate(String text) {
    print(text);
    List<int> expiryDate = CardUtils.getExpiryDate(text);
    _paymentCard.month = expiryDate[0];
    _paymentCard.year = expiryDate[1];
  }

  _setCardCVV(String text) {
    _paymentCard.cvv = int.parse(text);
    encryptData(_paymentCard.cvv.toString())
        .then((value) => setState(() => encryptedCvv = value));
  }

  @override
  void initState() {
    if (widget.card != null) {
      numberController.text = widget.card.number;
      fullnameController.text = widget.card.cardHolder;
      monthController.text = widget.card.month.toString();
      cvvCtrl.text = widget.card.cvv.toString();
      expiryCtrl.text = widget.card.year.toString();
      _paymentCard.type = widget.card.type;
    } else {
      _paymentCard.type = CardType.Invalid;
    }

    numberController.addListener(_getCardTypeFrmNumber);
    // paymodeCtrl.addListener(_getMomoTypeFrmNumber());
    super.initState();
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(focusNode: _fullnameF, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _voucherF, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _voucherF, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _voucherF, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _voucherF, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _cvvF, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _expireF, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _card, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _mobile, toolbarButtons: [action]),
      ],
    );
  }

  void _getCardTypeFrmNumber() async {
    String input = CardUtils.getCleanedNumber(numberController.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    String paymodeC = CardUtils.cardAbreviaton(cardType);
    print(input);
    await encryptData(input)
        .then((value) => setState(() => encryptedNumber = value));
    setState(() {
      _paymentCard.type = cardType;
      _paymentCard.paymode = paymodeC;
    });
  }

  void savePaymentMethod() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      widget.card == null
          ? _paymentMethodController.verify(_paymentCard)
          : _paymentMethodController.eidtPaymentMethod(_paymentCard);
      if (widget.callback != null) {
        widget.callback();
      } else {
        Get.back();
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  _setMode(String text) {
    CardType cardType = CardUtils.getMomoTypeFrmNumber(text);
    setState(() {
      _paymentCard.type = cardType;
      _paymentCard.paymode = text;
      paymode = text;
    });
  }

  _setVoucherCode(String text) {
    _voucherCode = text;
  }

  List<Widget> _getMomoWidget(_method) {
    return _method == 0
        ? [
            Container(
                padding: EdgeInsets.only(
                    top: 5.w, right: 20.w, left: 20.w, bottom: 5.w),
                width: double.infinity,
                // height: 40,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      key: _provider,
                      controller: telcosCtrl,
                      validator: (value) => value != null && value.isNotEmpty
                          ? null
                          : "Field is required",
                      readOnly: true,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(fontSize: 14.w),
                        suffixIcon: Icon(
                          Icons.arrow_drop_down,
                          size: 20,
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  Constants.themeGreyLight.withOpacity(0.2.w),
                            ),
                            borderRadius: BorderRadius.circular(5.w)),
                        contentPadding: EdgeInsets.all(10.w),
                        hintText: S.of(context).selectTelco,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintStyle: TextStyle(fontSize: 14.w),
                      ),
                      // style: TextStyle(color: CupertinoTheme.of(context).primaryContrastingColor, fontSize: 14.0),
                      onChanged: _setMode,
                      onTap: () => _changeProvider(_paymentCard.paymode),
                    ))),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 5.w,
                          right: paymode == "VDF" ? 10.w : 20.w,
                          left: 20.w,
                          bottom: 10.w),
                      child: TextFormField(
                        focusNode: _mobile,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: _voucher,
                        style: style,
                        keyboardType: TextInputType.number,
                        controller: mobileCtrl,
                        onSaved: _setCardNumber,
                        validator: Helper.validateMobileNumberStrict,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: 14.w),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    Constants.themeGreyLight.withOpacity(0.2.w),
                              ),
                              borderRadius: BorderRadius.circular(5.w)),
                          contentPadding: EdgeInsets.all(10.w),
                          hintText: S.of(context).mobileNo,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          hintStyle: TextStyle(fontSize: 14.w),
                        ),
                      ),
                    )),
                paymode == "GMY"
                    ? Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 15.w, right: 20.w, left: 10.w, bottom: 20.w),
                          child: TextFormField(
                            focusNode: _voucherF,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: style,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.number,
                            controller: voucherCtrl,
                            onSaved: _setVoucherCode,
                            validator: CardUtils.validateVoucherCode,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(fontSize: 14.w),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Constants.themeGreyLight
                                        .withOpacity(0.2.w),
                                  ),
                                  borderRadius: BorderRadius.circular(5.w)),
                              contentPadding: EdgeInsets.all(10.w),
                              hintText: S.of(context).voucherCode,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintStyle: TextStyle(fontSize: 14.w),
                            ),
                          ),
                        ))
                    : SizedBox.shrink()
              ],
            )
          ]
        : [
            Container(
              padding: EdgeInsets.only(right: 20.w, left: 20.w, bottom: 10.w),
              // margin: EdgeInsets.only(bottom: 20.w),
              // width: Get.width,
              // height: Get.height / 4.w,
              child: SizedBox(
                // height: 47.w,
                child: TextFormField(
                  focusNode: _card,
                  enabled: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _pan,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    new LengthLimitingTextInputFormatter(19),
                    _paymentCard.number ==
                            CardUtils.getCleanedNumber(
                                numberController.text.toString())
                        ? CardNumberInputFormatterMask()
                        : new CardNumberInputFormatter()
                  ],
                  controller: numberController,
                  style: style,
                  keyboardType: TextInputType.number,
                  onSaved: _setCardNumber,
                  validator: CardUtils.validateCardNumWithLuhnAlgorithm,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 14.w),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Constants.themeGreyLight.withOpacity(0.2.w),
                        ),
                        borderRadius: BorderRadius.circular(5.w)),
                    contentPadding: EdgeInsets.all(10.w),
                    hintText: S.of(context).cardNumber,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintStyle: TextStyle(fontSize: 14.w),
                  ),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(right: 12.w, left: 12.w, bottom: 10.w),
                // margin: EdgeInsets.only(bottom: 20.w),
                // width: Get.width,
                // height: Get.height / 4.w,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: SizedBox(
                        // height: 47.w,
                        child: TextFormField(
                          focusNode: _expireF,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: _expire,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            new LengthLimitingTextInputFormatter(4),
                            new CardExpireInputFormatter()
                          ],
                          controller: expiryCtrl,
                          style: style,
                          keyboardType:
                              TextInputType.numberWithOptions(signed: true),
                          // onFieldSubmitted: (String text) {
                          //   onDone();
                          // },
                          onChanged: (val) {
                            // String dt = (val);

                            // await encryptData(dtSplit[0]).then((value) =>
                            //     setState(() => encryptedMonth = value));

                            // await encryptData(dtSplit[1]).then((value) =>
                            //     setState(() => encryptedYear = value));
                          },
                          onSaved: _setCardExpireDate,
                          validator: CardUtils.validateDate,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      Constants.themeGreyLight.withOpacity(0.2),
                                ),
                                borderRadius: BorderRadius.circular(5.w)),
                            labelStyle: TextStyle(fontSize: 14.w),
                            contentPadding: EdgeInsets.all(10.w),
                            hintText: S.of(context).expiryDate,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            hintStyle: TextStyle(fontSize: 14.w),
                          ),
                        ),
                      ),
                    )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          // margin: EdgeInsets.only(bottom: 20.w),
                          // width: Get.width,
                          // height: Get.height / 4.w,
                          child: SizedBox(
                            // height: 47.w,
                            child: TextFormField(
                              focusNode: _cvvF,
                              enabled: true,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              key: _cvv,
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
                              onSaved: _setCardCVV,
                              onChanged: (val) {
                                // print(val);
                                // await encryptData(val).then((value) =>
                                //     setState(() => encryptedCvv = value));
                              },
                              validator: CardUtils.validateCVV,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Constants.themeGreyLight
                                          .withOpacity(0.2),
                                    ),
                                    borderRadius: BorderRadius.circular(5.w)),
                                labelStyle: TextStyle(fontSize: 14.w),
                                contentPadding: EdgeInsets.all(10.w),
                                hintText: S.of(context).cvv,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                hintStyle: TextStyle(fontSize: 14.w),
                              ),
                            ),
                          ),
                        ))
                  ],
                )),
          ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Get.theme.iconTheme.copyWith(color: Colors.black),
        automaticallyImplyLeading: true,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          S.of(context).addPaymentMethod,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      bottomNavigationBar: Container(
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
                onSurface: Get.theme.primaryColor.withOpacity(0.5.w),
              ),
              child: Text(
                "${S.of(context).savePayementMethod.toUpperCase()}",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: savePaymentMethod,
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
      ),
      body: KeyboardActions(
        config: _buildConfig(context),
        child: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.only(bottom: 20.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          blurRadius: 3.4.w,
                          offset: Offset(0, 3.4.w),
                          color: Constants.boxShadow)
                    ],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24.w),
                        bottomRight: Radius.circular(24.w))),
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autoValidate
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Radio(
                            value: 0,
                            groupValue: _payMethod,
                            onChanged: (value) {
                              numberController.clear();
                              cvvCtrl.clear();
                              expiryCtrl.clear();
                              mobileCtrl.clear();
                              voucherCtrl.clear();
                              // paymode="";
                              setState(() {
                                _selectedCard = "";
                                _paymentCard.paytype = value;
                                _payMethod = value;
                              });
                            },
                          ),
                          Text(
                            "Mobile Money",
                            style: TextStyle(
                                color: Get.theme.primaryColor, fontSize: 14.w),
                          ),
                          Radio(
                            value: 1,
                            groupValue: _payMethod,
                            onChanged: (value) {
                              numberController.clear();
                              cvvCtrl.clear();
                              expiryCtrl.clear();
                              mobileCtrl.clear();
                              voucherCtrl.clear();
                              setState(() {
                                _selectedCard = "";
                                _paymentCard.paytype = value;
                                _payMethod = value;
                              });
                            },
                          ),
                          Text(
                            'Card',
                            style: TextStyle(
                                color: Get.theme.primaryColor, fontSize: 14.w),
                          ),
                          // Radio(
                          //   value: 2,
                          //   groupValue: _payMethod,
                          //   onChanged: (value) {
                          //     numberController.clear();
                          //     cvvCtrl.clear();
                          //     expiryCtrl.clear();
                          //     mobileCtrl.clear();
                          //     voucherCtrl.clear();
                          //     setState(() {
                          //       _selectedCard = "";
                          //       _paymentCard.paytype = value;
                          //       _paymentCard.paymode = 'WLT';
                          //       _payMethod = value;
                          //     });
                          //   },
                          // ),
                          // Text(
                          //   'TELA Wallet',
                          //   style: TextStyle(
                          //       color: Get.theme.primaryColor, fontSize: 12.w),
                          // ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 20.w, right: 20.w, left: 20.w, bottom: 10.w),
                        child: SizedBox(
                          // height: 47.w,
                          child: TextFormField(
                            focusNode: _fullnameF,
                            enabled: true,
                            key: _fullname,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: fullnameController,
                            style: style,
                            keyboardType: TextInputType.text,
                            onSaved: _setFullname,
                            validator: (value) {
                              if (value.length < 4) return Strings.fieldReq;
                              return null;
                            },
                            decoration: InputDecoration(
                              labelStyle: TextStyle(fontSize: 14.w),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Constants.themeGreyLight
                                        .withOpacity(0.2.w),
                                  ),
                                  borderRadius: BorderRadius.circular(5.w)),
                              contentPadding: EdgeInsets.all(10.w),
                              hintText: S.of(context).cardHolderName,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintStyle: TextStyle(fontSize: 14.w),
                            ),
                          ),
                        ),
                      ),
                      ..._getMomoWidget(_payMethod),
                    ],
                  ),
                ))),
      ),
    );
  }

// sort by dialog
  void _changeProvider(String groupValue) async {
    await actionSheetDialog(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 12.w,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              S.current.telco,
              textAlign: TextAlign.center,
              style: Get.textTheme.headline6.copyWith(fontSize: 20.w),
            ),
          ),
          Expanded(
            child: ListView(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                children: telcos
                    .map(
                      (e) => Container(
                        color: Colors.white,
                        child: RadioListTile(
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: e['value'],
                          title: AutoSizeText(
                            e["name"],
                            maxLines: 1,
                            style: Get.textTheme.subtitle1.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          activeColor: Get.theme.primaryColor,
                          groupValue: groupValue,
                          onChanged: (value) {
                            setState(() {
                              _setMode(value);
                            });
                            telcosCtrl.text = e["name"];
                            Get.back();
                          },
                        ),
                      ),
                    )
                    .toList()),
          ),
          Container(
            width: Get.width,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Constants.themeGreyLight,
              ),
              onPressed: () {
                Get.back();
              },
              child: Text(
                S.current.cancel,
              ),
            ),
          ),
        ],
      ),
      height: .5,
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    numberController.removeListener(_getCardTypeFrmNumber);
    // paymodeCtrl.removeListener(_getMomoTypeFrmNumber);
    numberController.dispose();
    paymodeCtrl.dispose();
    super.dispose();
  }
}
