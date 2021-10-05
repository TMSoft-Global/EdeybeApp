import 'package:edeybe/generated/l10n.dart';
import 'package:edeybe/utils/card_utils.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:edeybe/index.dart';

Future<void> cvvAlert(BuildContext context, TextEditingController controller,
    FocusNode focusNode,{VoidCallback onTap}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        // title: Text('Rewind and remember'),
        content: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: SizedBox(
                // height: 47.w,
                child: TextFormField(
                  focusNode: focusNode,
                  enabled: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
              
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    new LengthLimitingTextInputFormatter(4),
                  ],
                  controller: controller,
                  style: TextStyle(fontSize: 14.w),
                  keyboardType: TextInputType.number,
                  validator: CardUtils.validateCVV,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Constants.themeGreyLight.withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(5.w)),
                    labelStyle: TextStyle(fontSize: 14.w),
                    contentPadding: EdgeInsets.all(10.w),
                    hintText: S.of(context).cvv,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintStyle: TextStyle(fontSize: 14.w),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.w)),
                    backgroundColor: Get.theme.primaryColor,
                    onSurface: Get.theme.primaryColor.withOpacity(0.5.w),
                  ),
                  onPressed: onTap,
                  child: Text("Complete Payment", style: TextStyle(color: Colors.white, fontSize: 15.h),),
                ),
              ),
            )
          ],
        )),
        // actions: <Widget>[
        //   FlatButton(
        //     child: Text('Ok'),
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //   ),
        // ],
      );
    },
  );
}

// Widget al(){ return Get.defaultDialog(
//       title: '',
//        radius: 10.0);