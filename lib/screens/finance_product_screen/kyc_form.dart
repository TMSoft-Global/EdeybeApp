import 'dart:io';

import 'package:edeybe/controllers/user_controller.dart';
import 'package:edeybe/screens/checkout_screen/index.dart';
import 'package:edeybe/services/server_operation.dart';
import 'package:edeybe/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class KYCForm extends StatefulWidget {
  final String email, firstName, lastName, phone, type;
  @required
  var products;

  KYCForm(
      {this.email,
      this.firstName,
      this.lastName,
      this.phone,
      this.type,
      this.products});

  @override
  State<KYCForm> createState() => _KYCFormState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _KYCFormState extends State<KYCForm> {
  final FocusNode _firstname = FocusNode();
  final FocusNode _lastname = FocusNode();
  final FocusNode _emailF = FocusNode();

  AppState state;
  File imageFile;
  CartController _cartController = Get.put(CartController());
  var _userCtrl = Get.find<UserController>();
  var _address = Get.find<AddressController>();
  String imgeUrl;
  var breakDown = [];

  @override
  void initState() {
    super.initState();
    state = AppState.free;

    if (widget.products != null) {
      _cartController.getProductBreakdown(widget.products, (value) {
        setState(() {
          breakDown = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailCTRL = TextEditingController(text: widget.email);
    final firstNameCTRL = TextEditingController(text: widget.firstName);
    final lastNameCTRL = TextEditingController(text: widget.lastName);
    print(widget.products);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.type == "asset" ? "Asset Finance" : "Hire Purchase"),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("User Details"),
                  SizedBox(
                    height: 12.w,
                  ),
                  TextFormField(
                    focusNode: _firstname,
                    maxLines: 1,
                    enableSuggestions: true,
                    enabled: false,
                    controller: firstNameCTRL,
                    validator: (value) {
                      return (value.isNotEmpty)
                          ? null
                          : S.of(context).invalidMail;
                    },
                    // onSaved: (newValue) => _firstName = newValue,
                    style: TextStyle(fontSize: 15.w),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2.w, horizontal: 10.w),
                      labelText: S.of(context).firstName,
                      hintStyle: TextStyle(fontSize: 14.w),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  TextFormField(
                    focusNode: _lastname,
                    maxLines: 1,
                    controller: lastNameCTRL,
                    enableSuggestions: true,
                    validator: (value) {
                      return (value.isNotEmpty)
                          ? null
                          : S.of(context).invalidMail;
                    },
                    // onSaved: (newValue) => _lastName = newValue,
                    style: TextStyle(fontSize: 14.w),
                    enabled: false,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2.w, horizontal: 10.w),
                      labelText: S.of(context).lastName,
                      hintStyle: TextStyle(fontSize: 14.w),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  TextFormField(
                    focusNode: _emailF,
                    maxLines: 1,
                    controller: emailCTRL,
                    enableSuggestions: true,
                    keyboardType: TextInputType.emailAddress,
                    validator: Helper.validateEmail,
                    // onSaved: (newValue) => _email = newValue,
                    style: TextStyle(fontSize: 14.w),
                    enabled: false,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2.w, horizontal: 10.w),
                      labelText: S.of(context).email,
                      hintStyle: TextStyle(fontSize: 14.w),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  CustomDivider(),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("ID Verification"),
                      TextButton(
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              // minimumSize: Size(50, 30),
                              alignment: Alignment.centerLeft),
                          onPressed: () {
                            _clearImage();
                          },
                          child: Text(
                            "Clear Image",
                            style: TextStyle(color: Get.theme.primaryColorDark),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    height: 200.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.5, color: Get.theme.dividerColor)),
                    child: imageFile == null &&
                            _userCtrl.user.kycIDCard.isNotEmpty &&
                            _userCtrl.user.kycIDCard != null
                        ? Image.network(
                            "$domain/api/images/${_userCtrl.user.kycIDCard}")
                        : imageFile != null
                            ? Image.file(
                                File(imageFile.path),
                                fit: BoxFit.contain,
                              )
                            : Center(
                                child: IconButton(
                                  icon: Icon(Icons.camera_alt),
                                  onPressed: () {
                                    _pickImage()
                                        .whenComplete(_cropImage)
                                        .then((d) {
                                      _cartController.uploadImageCard(imageFile,
                                          (val) {
                                        print(val);
                                        setState(() {
                                          imgeUrl = val;
                                        });
                                      });
                                    });
                                  },
                                ),
                              ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  CustomDivider(),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text("Breakdown Details"),
                  CustomDivider(),
                  Container(
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var x in breakDown) ...[
                              Row(
                                children: [
                                  Text("Downpayment: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  Text("              GHS${x['downPayment']}"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Interval Payment: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  Text("         GHS${x['intervalPayment']}"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Payment Duration: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  Text("       ${x['paymentDuration']} Month"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Interest: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  Text(
                                      "                           ${x['interest']}%"),
                                ],
                              )
                            ]
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Get.theme.primaryColor,
                      textStyle: TextStyle(
                        color: Colors.white,
                      )),
                  onPressed: () {
                    // print(_userCtrl.user.kycIDCard);
                    _cartController.submitHirePurchase(
                      "${widget.lastName} ${widget.firstName}",
                      widget.phone,
                      _address.delivery[0],
                      "type",
                      "financerId",
                      _userCtrl.user.kycIDCard == "" &&
                              _userCtrl.user.kycIDCard == null
                          ? imgeUrl
                          : _userCtrl.user.kycIDCard,
                    );
                    _userCtrl.getUserInfo();
                  },
                  child: Text("Submit",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<Null> _pickImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    imageFile = pickedImage != null ? File(pickedImage.path) : null;
    if (imageFile != null) {
      setState(() {
        state = AppState.picked;
      });
    }
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                // CropAspectRatioPreset.square,
                // CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                // CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                // CropAspectRatioPreset.square,
                // CropAspectRatioPreset.ratio3x2,
                // CropAspectRatioPreset.ratio4x3,
                // CropAspectRatioPreset.ratio5x3,
                // CropAspectRatioPreset.ratio5x4,
                // CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop',
            toolbarColor: Get.theme.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      imageFile = croppedFile;

      setState(() {
        state = AppState.cropped;
      });
    }
  }

  void _clearImage() {
    imageFile = null;
    _userCtrl.user.kycIDCard = "";
    setState(() {
      state = AppState.free;
    });
  }
}
