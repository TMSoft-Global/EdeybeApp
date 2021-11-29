import 'dart:io';

import 'package:edeybe/screens/checkout_screen/index.dart';
import 'package:edeybe/utils/helper.dart';
import 'package:edeybe/utils/imageUploadWidget.dart';
import 'package:edeybe/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';
import 'package:image_picker/image_picker.dart';

class KYCForm extends StatefulWidget {
  final String email, firstName, lastName, phone;

  KYCForm({this.email, this.firstName, this.lastName, this.phone});

  @override
  State<KYCForm> createState() => _KYCFormState();
}

class _KYCFormState extends State<KYCForm> {
  final FocusNode _firstname = FocusNode();

  final FocusNode _lastname = FocusNode();

  final FocusNode _emailF = FocusNode();

  final ImagePicker _picker = ImagePicker();

  List<XFile> _imageFileList;
  XFile _image;

  set _imageFile(XFile value) {
    _imageFileList = value == null ? null : [value];
  }

  dynamic _pickImageError;

  void _onImageButtonPressed(ImageSource source,
      {BuildContext context,
      bool isMultiImage = false,
      bool isCamera = false}) async {
    if (isMultiImage) {
      try {
        final pickedFileList = await _picker.pickMultiImage();
        setState(() {
          _imageFileList = pickedFileList;
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    } else {
      final pickedFile = await _picker.pickImage(
          source: isCamera ? ImageSource.camera : source,
          maxWidth: 300,
          maxHeight: 200);
      setState(() {
        _image = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailCTRL = TextEditingController(text: widget.email);
    final firstNameCTRL = TextEditingController(text: widget.firstName);
    final lastNameCTRL = TextEditingController(text: widget.lastName);
    print(widget.email);
    return Scaffold(
      appBar: AppBar(
        title: Text("Asset Finance"),
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
                            setState(() {
                              _image = null;
                            });
                          },
                          child: Text("Clear Image"))
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
                    child: _image != null
                        ? Image.file(
                            File(_image.path),
                            fit: BoxFit.contain,
                          )
                        : Center(
                            child: IconButton(
                              icon: Icon(Icons.camera_alt),
                              onPressed: () {
                                _onImageButtonPressed(ImageSource.gallery,
                                    context: context);
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
}
