import 'dart:io';

import 'package:edeybe/screens/checkout_screen/index.dart';
import 'package:edeybe/utils/helper.dart';
import 'package:edeybe/utils/imageUploadWidget.dart';
import 'package:edeybe/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class KYCForm extends StatefulWidget {
  final String email, firstName, lastName, phone, type;

  KYCForm({this.email, this.firstName, this.lastName, this.phone, this.type});

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

  @override
  void initState() {
    super.initState();
    state = AppState.free;
  }

  @override
  Widget build(BuildContext context) {
    final emailCTRL = TextEditingController(text: widget.email);
    final firstNameCTRL = TextEditingController(text: widget.firstName);
    final lastNameCTRL = TextEditingController(text: widget.lastName);
    print(widget.email);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.type == "asset" ? "Asset Finance": "Hire Purchase"),
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
                          child: Text("Clear Image", style: TextStyle(color: Get.theme.primaryColorDark),))
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
                    child: imageFile != null
                        ? Image.file(
                            File(imageFile.path),
                            fit: BoxFit.contain,
                          )
                        : Center(
                            child: IconButton(
                              icon: Icon(Icons.camera_alt),
                              onPressed: () {
                                // if (state == AppState.free)
                                  _pickImage().whenComplete(()=>_cropImage()
                                  );
                                // else if (state == AppState.picked)
                                // Get.to(ImageUpload());
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
                  Text("Product Details"),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 150.h,
                              width: 150.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Get.theme.dividerColor, width: 0.5),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("SKU: 12354560145df"),
                                Text("Product: 32Inc Curved TV"),
                                Text("Price: GHS 1,000"),
                                Text("Initial Payment: GHS 200"),
                                Text("Monthly Payment: GHS 200"),
                              ],
                            )
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
            SizedBox(
              width: 200.w,
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Get.theme.primaryColor,
                    textStyle: TextStyle(
                      color: Colors.white,
                    )),
                onPressed: () {},
                child: Text("Submit",
                    style: TextStyle(
                      color: Colors.white,
                    )),
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
    setState(() {
      state = AppState.free;
    });
  }
}
