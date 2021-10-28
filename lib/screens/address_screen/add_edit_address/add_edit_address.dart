import 'package:edeybe/controllers/address_controller.dart';
import 'package:edeybe/controllers/delivery_coltroller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/models/deliveryModel.dart';
import 'package:edeybe/screens/address_screen/address_map/address_map.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:edeybe/utils/helper.dart';
import 'package:edeybe/utils/keyboard-action.dart';
import 'package:edeybe/utils/strings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class AddorEditScreen extends StatefulWidget {
  AddorEditScreen({Key key, this.address, this.deliveryAddress})
      : super(key: key);
  final DeliveryAddress address;
  ShippingAddress deliveryAddress;
  @override
  _AddorEditScreenState createState() => _AddorEditScreenState();
}

class _AddorEditScreenState extends State<AddorEditScreen> {
  // variables
  int _addressType = 1;
  TextEditingController _firstnameCtrl = TextEditingController();
  TextEditingController _mobileCtrl = TextEditingController();
  TextEditingController _lastnameCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _addressCtrl = TextEditingController();
  TextEditingController _addressMoreCtrl = TextEditingController();
  Map<String, dynamic> _address;
  final _addressController = Get.put(AddressController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _makeDefault = false;
  bool autoValidate = false;
  final FocusNode _firstname = FocusNode();
  final FocusNode _lastname = FocusNode();
  final FocusNode _email = FocusNode();
  final FocusNode _mobile = FocusNode();
  final FocusNode _ghanaPostAddress = FocusNode();

  String locationAddress, locID, locName, long, lat, gpsAddress;
  // state functions
  void _setAddressType(int val) {
    setState(() {
      _addressType = val;
    });
  }

  void _changeMakeDefault(val) {
    setState(() {
      _makeDefault = val;
    });
  }

  void saveAddress() {
    // final FormState form = _formKey.currentState;
    if (lat != null && long != null) {
      _addressController.addAddress({
        "type": _addressType == 1 ? "currentLocation" : "digitalAddress",
        "lat": lat,
        "long": long,
        "displayText": locationAddress,
        "placeName": locName,
        "digitalAddress": gpsAddress,
      });
      Get.back();
      // }
    } else {
      setState(() {
        autoValidate = true;
      });
      Get.back();
    }
  }

  @override
  void initState() {
    print(widget.address);

    if (widget.address != null) {
      locationAddress = widget.address.displayText;
      locID = widget.address.id;
      locName = widget.address.placeName;
      long = widget.address.long;
      lat = widget.address.lat;
    } else {
      locationAddress = "";
      locID = "";
      locName = "";
      long = "";
      lat = "";
    }

    if (widget.deliveryAddress != null) {
      _firstnameCtrl.text = widget.deliveryAddress.firstName;
      _lastnameCtrl.text = widget.deliveryAddress.lastName;
      _mobileCtrl.text = widget.deliveryAddress.phone;
      // _addressCtrl.text = widget.address.deliveryAddresses;
      _emailCtrl.text = widget.deliveryAddress.email;
    }
    super.initState();
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(focusNode: _firstname, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _lastname, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _lastname, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _lastname, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _email, toolbarButtons: [action]),
        KeyboardActionsItem(focusNode: _mobile, toolbarButtons: [action]),
        KeyboardActionsItem(
            focusNode: _ghanaPostAddress, toolbarButtons: [action]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          iconTheme: Get.theme.iconTheme.copyWith(color: Colors.white),
          title: Text(
            S.of(context).editaddaddress,
            style: TextStyle(color: Colors.white),
          ),
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
                  "${S.of(context).saveAddress.toUpperCase()}",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: saveAddress,
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
              child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                autovalidateMode: autoValidate
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Padding(
                  padding: EdgeInsets.all(12.0.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // Container(
                      //                         width: Get.width,
                      //                         padding: EdgeInsets.only(left: 8.w, right: 8.w),
                      //                         child: Text(S.of(context).firstName,
                      //                             style: TextStyle(fontSize: 17.w))),
                      // Padding(
                      //   padding: EdgeInsets.all(8.0.w),
                      //   child: SizedBox(
                      //     // height: 47.w,
                      //     child: TextFormField(
                      //       focusNode: _firstname,
                      //       validator: (value) {
                      //         return value.length > 3 ? null : Strings.fieldReq;
                      //       },
                      //       style: TextStyle(fontSize: 14.w),
                      //       decoration: InputDecoration(
                      //         hintText: S.of(context).firstName,
                      //         floatingLabelBehavior:
                      //             FloatingLabelBehavior.never,
                      //         border: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //                 color: Constants.themeGreyLight,
                      //                 width: 1.0.w),
                      //             borderRadius: BorderRadius.circular(5.0.w)),
                      //         contentPadding: EdgeInsets.all(10.0.w),
                      //       ),
                      //       controller: _firstnameCtrl,
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.all(8.0.w),
                      //   child: SizedBox(
                      //     // height: 47.w,
                      //     child: TextFormField(
                      //       focusNode: _lastname,
                      //       validator: (value) {
                      //         return value.length > 2 ? null : Strings.fieldReq;
                      //       },
                      //       style: TextStyle(fontSize: 14.w),
                      //       decoration: InputDecoration(
                      //         hintText: S.of(context).lastName,
                      //         floatingLabelBehavior:
                      //             FloatingLabelBehavior.never,
                      //         border: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //                 color: Constants.themeGreyLight,
                      //                 width: 1.0.w),
                      //             borderRadius: BorderRadius.circular(5.0.w)),
                      //         contentPadding: EdgeInsets.all(10.0.w),
                      //       ),
                      //       controller: _lastnameCtrl,
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.all(8.0.w),
                      //   child: SizedBox(
                      //     // height: 47.w,
                      //     child: TextFormField(
                      //       focusNode: _email,
                      //       validator: Helper.validateEmail,
                      //       style: TextStyle(fontSize: 14.w),
                      //       decoration: InputDecoration(
                      //         hintText: S.of(context).email,
                      //         floatingLabelBehavior:
                      //             FloatingLabelBehavior.never,
                      //         border: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //                 color: Constants.themeGreyLight,
                      //                 width: 1.0.w),
                      //             borderRadius: BorderRadius.circular(5.0.w)),
                      //         contentPadding: EdgeInsets.all(10.0.w),
                      //       ),
                      //       controller: _emailCtrl,
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.all(8.0.w),
                      //   child: Row(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: <Widget>[
                      //       // Expanded(
                      //       //   child: Container(
                      //       //     // constraints: BoxConstraints(maxHeight: 47.w),
                      //       //     // height: 47.w,
                      //       //     decoration: BoxDecoration(
                      //       //         border: Border.all(
                      //       //             width: 1.w, color: Constants.themeGreyDark),
                      //       //         borderRadius: BorderRadius.circular(5.w)),
                      //       //     padding: EdgeInsets.all(11.w),
                      //       //     child: DropdownButtonHideUnderline(
                      //       //       child: DropdownButton<String>(
                      //       //         isDense: true,
                      //       //         value: _countryCode,
                      //       //         onChanged: _setContryCode,
                      //       //         items: <DropdownMenuItem<String>>[
                      //       //           DropdownMenuItem(
                      //       //             value: "+233",
                      //       //             child: Text(
                      //       //               "+233",
                      //       //               textAlign: TextAlign.center,
                      //       //               style: Get.textTheme.bodyText1.copyWith(
                      //       //                   fontSize: 13,
                      //       //                   fontWeight: FontWeight.bold),
                      //       //             ),
                      //       //           ),
                      //       //         ],
                      //       //       ),
                      //       //     ),
                      //       //   ),
                      //       // ),
                      //       Expanded(
                      //         flex: 3,
                      //         child: SizedBox(
                      //           // height: 47.w,
                      //           child: TextFormField(
                      //             focusNode: _mobile,
                      //             validator: Helper.validateMobileNumberStrict,
                      //             style: TextStyle(fontSize: 14.w),
                      //             decoration: InputDecoration(
                      //               hintText:
                      //                   S.of(context).mobileNumberPlaceholder,
                      //               floatingLabelBehavior:
                      //                   FloatingLabelBehavior.never,
                      //               border: OutlineInputBorder(
                      //                   borderSide: BorderSide(
                      //                       color: Constants.themeGreyLight,
                      //                       width: 1.0.w),
                      //                   borderRadius:
                      //                       BorderRadius.circular(5.0.w)),
                      //               contentPadding: EdgeInsets.all(10.0.w),
                      //             ),
                      //             controller: _mobileCtrl,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(width: 10.w),
                      Container(
                          width: Get.width,
                          padding: EdgeInsets.only(left: 8.w, right: 8.w),
                          child: Text(
                              "${S.of(context).shipping}  ${S.of(context).address}",
                              style: TextStyle(fontSize: 17.w))),
                      SizedBox(width: 10.w),

                      Container(
                        padding: EdgeInsets.only(left: 8.w, right: 8.w),
                        child: Row(
                          children: [
                            Expanded(
                                child: Row(
                              children: [
                                Text("GPS"),
                                Radio(
                                    value: 1,
                                    groupValue: _addressType,
                                    onChanged: _setAddressType),
                              ],
                            )),
                            Expanded(
                                child: Row(
                              children: [
                                Text("Ghana Post"),
                                Radio(
                                    value: 2,
                                    groupValue: _addressType,
                                    onChanged: _setAddressType),
                              ],
                            )),
                          ],
                        ),
                      ),
                      _addressType == 1
                          ? Padding(
                              padding: EdgeInsets.all(8.w),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Constants.themeBlue),
                                onPressed: () {
                                  Get.to(
                                      AddressMapWidget(setAddress: (address) {
                                    print(address);
                                    if (address["GPSName"].startsWith("GA")) {
                                      setState(() {
                                        locationAddress = address['Area'];
                                        locName = address['Street'];
                                        long = address["WLong"].toString();
                                        lat = address["NLat"].toString();
                                        gpsAddress = address[''];
                                        // locID
                                        // _address = {
                                        //   "lat": address["NLat"],
                                        //   "long": address["WLong"],
                                        //   "displayText": address["Street"],
                                        //   "type": _addressType == 1
                                        //       ? "currentLocation"
                                        //       : "digitalAddress"
                                        // };
                                        // _addressCtrl.text = address["Street"];
                                      });
                                    } else {
                                      _address = null;
                                      showSnack(
                                          "Sorry, We only deliver with Greater Accra.");
                                    }
                                  }));
                                },
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  width: Get.width.w,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Get Cordinates",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Icon(
                                        FontAwesomeIcons.mapMarkerAlt,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.all(8.w),
                              child: SizedBox(
                                // height: 47.w,
                                child: TextFormField(
                                  focusNode: _ghanaPostAddress,
                                  validator: (value) {
                                    return value.length > 3
                                        ? null
                                        : Strings.fieldReq;
                                  },
                                  style: TextStyle(fontSize: 14.w),
                                  onChanged: (text) {
                                    setState(() {});
                                  },
                                  decoration: InputDecoration(
                                      hintText: S.of(context).ghanaPostAddress,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Constants.themeGreyLight,
                                              width: 1.0.w),
                                          borderRadius:
                                              BorderRadius.circular(5.0.w)),
                                      contentPadding: EdgeInsets.all(10.0.w),
                                      suffixIcon: InkWell(
                                          onTap: () {
                                            if (_addressMoreCtrl.text.isEmpty) {
                                              _address = null;
                                              showSnack(
                                                  "Please enter your Ghana Post address");
                                            } else if (_addressMoreCtrl
                                                    .text.length <
                                                9) {
                                              _address = null;
                                              showSnack(
                                                  "Please enter a valid Ghana Post address");
                                            } else if (_addressMoreCtrl
                                                    .text.isNotEmpty &&
                                                _addressMoreCtrl.text
                                                    .startsWith("GA")) {
                                              _addressController
                                                  .getGhanaPostAddress(
                                                      _addressMoreCtrl.text,
                                                      callback: (address) {
                                                print(address);
                                                setState(() {
                                                  locationAddress =
                                                      "${address["Area"]} ${address['Street']}";
                                                  locName = address['District'];
                                                  long =
                                                      address['CenterLongitude']
                                                          .toString();
                                                  lat =
                                                      address['CenterLatitude']
                                                          .toString();
                                                  gpsAddress =
                                                      address['GPSName'];

                                                  // _address = {
                                                  //   "lat": address["CenterLatitude"],
                                                  //   "long": address["CenterLongitude"],
                                                  //   "displayText":
                                                  //       "${address["Area"]} ${address['Street']}",
                                                  // };
                                                  // _addressCtrl.text =
                                                  //     "${address["Area"]} ${address['Street']}";
                                                });
                                              });
                                            } else {
                                              _address = null;
                                              showSnack(
                                                  "Sorry, We only deliver with Greater Accra");
                                            }
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(5.w),
                                                    bottomRight:
                                                        Radius.circular(5.w)),
                                                color: Constants.themeBlue,
                                              ),
                                              child: Icon(
                                                  Icons.search_outlined)))),
                                  controller: _addressMoreCtrl,
                                ),
                              ),
                            ),
                      SizedBox(width: 15.w),
                      Row(
                        children: [],
                      ),
                      SizedBox(width: 15.w),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            activeColor: Get.theme.primaryColor,
                            value: _makeDefault,
                            onChanged: _changeMakeDefault,
                          ),
                          Container(
                              child: RichText(
                            text: TextSpan(
                                text: S.of(context).makeDefaultShippingAddress,
                                style: TextStyle(color: Colors.black),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    _changeMakeDefault(!_makeDefault);
                                  }),
                          ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                  width: Get.width,
                  padding: EdgeInsets.fromLTRB(20.w, 10.w, 20.w, 10.w),
                  color: Constants.themeGreyLight.withOpacity(0.5),
                  child: Text(S.of(context).addressDetails.toUpperCase(),
                      style: TextStyle(
                          fontSize: 17.w, fontWeight: FontWeight.w600))),
              Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Constants.boxShadow,
                    blurRadius: 3.4.w,
                    offset: Offset(0, 3.4.w),
                  )
                ]),
                margin: EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 10.w),
                padding: EdgeInsets.fromLTRB(15.w, 5.w, 15.w, 20.w),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Text("Place Name",
                                style:
                                    TextStyle(color: Constants.themeGreyDark)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.only(
                              left: 10.w,
                            ),
                            child: Text(locName
                                // "${address.firstName} ${address.lastName}",

                                ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Text(S.of(context).address,
                                style:
                                    TextStyle(color: Constants.themeGreyDark)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.only(
                              left: 10.w,
                            ),
                            child: Text(
                              locationAddress ?? "",
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: <Widget>[
                    //     Expanded(
                    //       flex: 1,
                    //       child: Container(
                    //         child: Text("Longitude",
                    //             style:
                    //                 TextStyle(color: Constants.themeGreyDark)),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       flex: 3,
                    //       child: Container(
                    //         padding: EdgeInsets.only(
                    //           left: 10.w,
                    //         ),
                    //         child: Text(
                    //           long ?? "",
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: <Widget>[
                    //     Expanded(
                    //       flex: 1,
                    //       child: Container(
                    //         child: Text("Latitude",
                    //             style:
                    //                 TextStyle(color: Constants.themeGreyDark)),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       flex: 3,
                    //       child: Container(
                    //         padding: EdgeInsets.only(
                    //           left: 10.w,
                    //         ),
                    //         child: Text(
                    //           lat ?? "",
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          )),
        ));
  }

  void showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
      children: [
        Container(
            child: Text(
          message,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        )),
      ],
    )));
  }
}
