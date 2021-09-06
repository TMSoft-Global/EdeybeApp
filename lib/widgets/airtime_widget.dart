import 'dart:async';

import 'package:edeybe/screens/checkout_screen/index.dart';
import 'package:edeybe/services/airtime_controller.dart';
import 'package:edeybe/utils/card_enum.dart';
import 'package:edeybe/utils/keyboard-action.dart';
import 'package:edeybe/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class AirtimeWiget extends StatefulWidget {
  AirtimeWiget({Key key}) : super(key: key);

  @override
  _AirtimeWigetState createState() => _AirtimeWigetState();
}

class _AirtimeWigetState extends State<AirtimeWiget> {
  String currency = "GH¢ ";
  int _payMethod = 1;
  String paymode;
  String amount;
  String _voucherCode;
  String _selectedCard;
  DateTime startDateVal;
  DateTime endDateVal;
  bool _autoValidate = false;
  bool loadervisible = false;
  bool showForm = true;
  BuildContext loaderContext;
  final format = DateFormat("yyyy-MM-dd HH:mm:ss");
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  GlobalKey<FormFieldState> _voucher = new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _mobile = new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _provider = new GlobalKey<FormFieldState>();
  PaymentCard _paymentCard = new PaymentCard();

  bool isAttemptingCheckout = false;

  bool hasError = false;

  String errorMsg;

  bool successful;
  String defaultPhone = "";
  bool useDefaultNumber = false;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 14.w);
  bool checkoutInProgress = false;
  var numberController = new TextEditingController();
  var paymodeCtrl = new TextEditingController();
  var cvvCtrl = new TextEditingController();
  var cardholderCtrl = new TextEditingController();
  var expiryCtrl = new TextEditingController();
  var voucherCtrl = new TextEditingController();
  var mobileCtrl = new TextEditingController();
  var recipientMobileCtrl = new TextEditingController();
  var startDateCrtl = TextEditingController();
  var endDateCrtl = TextEditingController();
  Timer _reverStateTimer;
  TextEditingController amountCtrl = new TextEditingController();

  final FocusNode _phone = FocusNode();
  final FocusNode _recipient = FocusNode();
  final FocusNode _amount = FocusNode();
  final FocusNode _voucherF = FocusNode();

  List<Map<String, String>> telcos = [
    {"name": 'MTN', "value": 'MTN'},
    {"name": 'AirtelTigo', "value": 'ATL'},
    {"name": 'Vodafone', "value": 'VDF'},
    // {"name": 'G-Money', "value": 'GMY'}
  ];
  String selectedSlot;
  List<dynamic> availableSlots = [];

  bool sameAsSender = false;

  _setMode(String text) {
    CardType cardType = CardUtils.getMomoTypeFrmNumber(text);
    setState(() {
      _paymentCard.type = cardType;
      _paymentCard.paymode = text;
      paymode = text;
    });
  }

  _setCardNumber(String text) {
    _paymentCard.number = CardUtils.getCleanedNumber(text);
  }

  _setCardNumberRecipient(String text) {
    _paymentCard.recipientNumber = CardUtils.getCleanedNumber(text);
  }

  _setVoucherCode(String text) {
    _voucherCode = text;
  }

  _setAmount(String text) {
    setState(() {
      amount = text;
    });
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(focusNode: _phone, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _recipient, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _recipient, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _recipient, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _amount, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _voucherF, toolbarButtons: [action]),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    _paymentCard.type = CardType.Invalid;
    numberController.addListener(_getCardTypeFrmNumber);
    // paymodeCtrl.addListener(_getMomoTypeFrmNumber());
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy Airtime', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.close_rounded),
          onPressed: Get.back,
        ),
      ),
      backgroundColor: Constants.themeGreyLight,
      body: KeyboardActions(
        config: _buildConfig(context),
        child: SingleChildScrollView(child: _buildCheckoutForm()),
      ),
    );
  }

  // check inputs form
  Widget _checkoutForm(bool enable, int type) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.w))),
        child: Form(
            key: _formKey,
            autovalidateMode: _autoValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: Column(children: <Widget>[
              Column(children: <Widget>[
                if (type == 1)
                  Container(
                    padding: EdgeInsets.only(
                        top: 5.w, left: 5.w, right: 5.w, bottom: 15.w),
                    child: DropdownButtonFormField<String>(
                      key: _provider,
                      validator: (value) => value != null && value.isNotEmpty
                          ? null
                          : "Field is required",
                      value: paymode,
                      isExpanded: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 20,
                      ),
                      iconSize: 30.w,
                      elevation: 16,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(10.w),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        focusColor: Colors.grey,
                        fillColor: Constants.themeBlueLight,
                      ),
                      // style: TextStyle(color: KRedColor, fontSize: 14.0),
                      onChanged: enable ? _setMode : null,
                      hint: Text("Select Network Provider"),
                      items: telcos.map<DropdownMenuItem<String>>(
                          (Map<String, String> telco) {
                        return DropdownMenuItem<String>(
                          value: telco["value"],
                          child: Text(telco["name"]),
                        );
                      }).toList(),
                    ),
                  ),
                if (type == 1)
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            flex: 2,
                            child: TextFormField(
                              focusNode: _phone,
                              enabled: enable && !useDefaultNumber,
                              key: _mobile,
                              style: style,
                              keyboardType: TextInputType.phone,
                              controller: mobileCtrl,
                              onSaved: _setCardNumber,
                              validator: (text) => useDefaultNumber
                                  ? null
                                  : CardUtils.validateMobileNumber(text)
                                      ? null
                                      : "Enter a valid Mobile number",
                              decoration: InputDecoration(
                                // icon: Image(image:AssetImage('assets/images/calender.png'),width: 20,),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                focusColor: Colors.grey,
                                labelStyle: TextStyle(fontSize: 14.w),
                                labelText: "Mobile Number",
                                hintStyle: TextStyle(fontSize: 14.w),
                              ),
                            )),
                        paymode == "GMY"
                            ? Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(left: 10.w),
                                    child: TextFormField(
                                      focusNode: _voucherF,
                                      enabled: enable,
                                      style: style,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              signed: true),
                                      controller: voucherCtrl,
                                      onSaved: _setVoucherCode,
                                      validator: CardUtils.validateVoucherCode,
                                      decoration: InputDecoration(
                                        // icon: Image(image:AssetImage('assets/images/card_cvv.png'),width: 30,),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey)),
                                        border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey)),
                                        focusColor: Colors.grey,
                                        labelStyle: TextStyle(fontSize: 14.w),

                                        hintText: "Pin",
                                        labelText: "Pin",
                                        hintStyle: TextStyle(fontSize: 14.w),
                                      ),
                                    )))
                            : SizedBox.shrink()
                      ],
                    ),
                  ),

                if (type == 2)
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'You will be taken to a secure checkout page where you will enter your card details.',
                        style: TextStyle(fontSize: 12),
                      )),
                if (type == 1)
                  CheckboxListTile(
                    value: sameAsSender,
                    selected: sameAsSender,
                    activeColor: Get.theme.primaryColor,
                    onChanged: (bool val) {
                      setState(() {
                        sameAsSender = val;
                      });
                    },
                    title: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Text(
                        "Recipient same as sender",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontSize: 12.w),
                      ),
                    ),
                  ),
                Container(
                  margin: EdgeInsets.only(top: 15.w),
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: TextFormField(
                    focusNode: _recipient,
                    enabled: enable && !sameAsSender,
                    key: _voucher,
                    style: style,
                    keyboardType: TextInputType.phone,
                    controller: recipientMobileCtrl,
                    onSaved: _setCardNumberRecipient,
                    validator: (text) => sameAsSender
                        ? null
                        : CardUtils.validateMobileNumber(text)
                            ? null
                            : "Enter a valid Mobile number",
                    decoration: InputDecoration(
                      // icon: Image(image:AssetImage('assets/images/calender.png'),width: 20,),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusColor: Colors.grey,
                      labelStyle: TextStyle(fontSize: 14.w),
                      labelText: "Recipient Mobile Number",
                      hintStyle: TextStyle(fontSize: 14.w),
                    ),
                  ),
                ),

                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                          margin: EdgeInsets.only(top: 15.w, bottom: 15.w),
                          padding: EdgeInsets.only(right: 5, left: 5),
                          child: TextFormField(
                            focusNode: _amount,
                            obscureText: false,
                            controller: amountCtrl,
                            style: style,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            // onFieldSubmitted: (String text){ onDone();},
                            onChanged: _setAmount,
                            validator: (text) {
                              var isValid = text.isNotEmpty;
                              if (isValid) {
                                String msg;

                                var amt =
                                    num.parse(double.parse(text).toString());

                                msg = amt < 0.2
                                    ? 'Amount must not be greater than 2.0'
                                    : amt > 500
                                        ? 'Amount must not be less than 500.00'
                                        : null;
                                return msg;
                              }
                              return "Please, you must enter an amount!";
                            },

                            decoration: InputDecoration(
                              labelStyle: TextStyle(fontSize: 14),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              hintText: "10.00 ",
                              labelText: "Amount",
                              hintStyle: TextStyle(fontSize: 14),
                            ),
                          )),
                    )
                  ],
                ),
                // if (type == 1)
                //   CheckboxListTile(
                //     value: useDefaultNumber,
                //     selected: useDefaultNumber,
                //     activeColor: Get.theme.primaryColor,
                //     onChanged: (bool val) {
                //       setState(() {
                //         useDefaultNumber = val;
                //       });
                //     },
                //     title: Padding(
                //       padding: EdgeInsets.all(8.w),
                //       child: Text(
                //         "Use default number ($defaultPhone)",
                //         style: Theme.of(context)
                //             .textTheme
                //             .bodyText2
                //             .copyWith(fontSize: 12.w),
                //       ),
                //     ),
                //   )
              ]),
            ])));
  }

  show() async {
    setState(() {
      isAttemptingCheckout = true;
    });
    await showDialog(
            context: context,
            builder: (ctx) => LoadingWidget(),
            barrierDismissible: false)
        .then((r) {
      hide();
    });
  }

  hide() {
    if (isAttemptingCheckout) {
      setState(() {
        isAttemptingCheckout = false;
      });
      if (Navigator.canPop(context)) Get.back();
    }
  }

  // Checkout form builder
  Widget _buildCheckoutForm() {
    return new Padding(
      padding: new EdgeInsets.only(top: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildCheckoutHeader(),
          SizedBox(
            height: 15,
          ),
          Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(5.0.w)),
              padding: EdgeInsets.only(
                  right: 20.w, top: 5.w, bottom: 5.w, left: 5.w),
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: 15.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Text(
                          "Payment Method",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Radio(
                        value: 1,
                        activeColor: Get.theme.primaryColor,
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
                        style: TextStyle(color: Constants.themeBlueLight),
                      ),
                      Radio(
                        value: 2,
                        activeColor: Get.theme.primaryColor,
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
                        style: TextStyle(color: Constants.themeBlueLight),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: showForm,
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 10.w, bottom: 10.w, top: 10.w),
                      child: _checkoutForm(!isAttemptingCheckout, _payMethod),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed:
                            isAttemptingCheckout ? null : () => Get.back(),
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 15.w, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0.w),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      ElevatedButton(
                        onPressed: isAttemptingCheckout
                            ? null
                            : () => _validateInputs(onAttemptCheckout),
                        child: Text(
                          'Pay',
                          style: TextStyle(fontSize: 15.w, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Get.theme.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.w),
                              side: BorderSide(
                                  width: 1, color: Get.theme.primaryColor),
                            )),
                      )
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }

  // form header builder
  Widget _buildCheckoutHeader() {
    return new Padding(
      padding: new EdgeInsets.only(left: 0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.w),
            child: new Text(
              'Airtime',
              style: new TextStyle(
                  fontSize: 20.w,
                  fontWeight: FontWeight.bold,
                  color: Get.theme.primaryColor),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // Clean up the controller when the Widget is removed from the Widget tree
    numberController.removeListener(_getCardTypeFrmNumber);
    // paymodeCtrl.removeListener(_getMomoTypeFrmNumber);
    numberController.dispose();
    paymodeCtrl.dispose();
    if (_reverStateTimer != null && _reverStateTimer.isActive)
      _reverStateTimer.cancel();
  }

  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(numberController.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    String paymodeC = CardUtils.cardAbreviaton(cardType);
    setState(() {
      if (numberController.text.isEmpty) _selectedCard = "";
      _paymentCard.type = cardType;
      _paymentCard.paymode = paymodeC;
    });
  }

  void _validateInputs(Function submit) {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      setState(() {
        _autoValidate = true; // Start validating on every change.
      });
      _showInSnackBar('Please fix the errors before submitting.',
          type: "error");
    } else {
      if (_payMethod != 2 && (_selectedCard == null || _selectedCard.isEmpty))
        form.save();
      else {
        _setVoucherCode(voucherCtrl.text.toString());
      }
      // _showInSnackBar('We are processing your payment');

      submit();
    }
  }

  onAttemptCheckout() async {
    var payload = {
      // "payment_channel": _payMethod == 1 ? "momo" : "card",
      'userType': "mobile",
      'airtimeAmount':
          num.parse(double.parse(amount).toString()).toStringAsFixed(2)
    };
    if (_payMethod == 1) {
      payload.putIfAbsent("selectedNetwork", () => _paymentCard.paymode);
      payload.putIfAbsent(
          "recipientPhone",
          () => sameAsSender
              ? _paymentCard.number
              : _paymentCard.recipientNumber);
      payload.putIfAbsent("senderPhone",
          () => useDefaultNumber ? defaultPhone : _paymentCard.number);
    }
    if (_paymentCard.paymode == "GMY")
      payload.putIfAbsent("post_pin", () => _voucherCode);

    print(payload);
    AirtimeController().buyAirtime(
      payload,
    );
  }

  void _showInSnackBar(String value, {String type}) {
    ScaffoldMessenger.of(Get.context).hideCurrentSnackBar();
    ScaffoldMessenger.of(Get.context).showSnackBar(new SnackBar(
      backgroundColor:
          type == "error" ? Colors.red.withOpacity(0.6) : Colors.green,
      content: new Text(value),
      duration: new Duration(seconds: 3),
    ));
  }
}
