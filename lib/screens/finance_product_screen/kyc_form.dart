import 'package:edeybe/screens/checkout_screen/index.dart';
import 'package:edeybe/utils/helper.dart';
import 'package:edeybe/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';

class KYCForm extends StatelessWidget {
  String _email, _password, _firstName, _lastName;

  final FocusNode _firstname = FocusNode();
  final FocusNode _lastname = FocusNode();
  final FocusNode _emailF = FocusNode();
  final FocusNode _pass = FocusNode();
  final FocusNode _confirmpass = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Finance"),
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
                  TextFormField(
                    focusNode: _firstname,
                    maxLines: 1,
                    enableSuggestions: true,
                    enabled: false,
                    validator: (value) {
                      return (value.isNotEmpty)
                          ? null
                          : S.of(context).invalidMail;
                    },
                    onSaved: (newValue) => _firstName = newValue,
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
                    enableSuggestions: true,
                    validator: (value) {
                      return (value.isNotEmpty)
                          ? null
                          : S.of(context).invalidMail;
                    },
                    onSaved: (newValue) => _lastName = newValue,
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
                    enableSuggestions: true,
                    keyboardType: TextInputType.emailAddress,
                    validator: Helper.validateEmail,
                    onSaved: (newValue) => _email = newValue,
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
                  Text("ID Verification"),
                  Container(
                    height: 200.h,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.5, color: Get.theme.dividerColor)),
                    child: Center(
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {},
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
                child: Text(
                  "Submit",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
