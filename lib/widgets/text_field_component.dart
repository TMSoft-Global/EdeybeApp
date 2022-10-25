import 'package:edeybe/utils/constant.dart';
import 'package:flutter/material.dart';

class CustomTexfield extends StatelessWidget {
  const CustomTexfield(
      {Key key,
      this.focusNode,
      this.controller,
      this.icon,
      this.hint,
      this.validString})
      : super(key: key);
  final FocusNode focusNode;
  final TextEditingController controller;
  final IconData icon;
  final String hint;
  final String validString;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: SizedBox(
        child: TextFormField(
          focusNode: focusNode,
          validator: (value) {
            return value.length > 2 ? null : validString;
          },
          style: TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            suffixIcon: icon == null ? null : Icon(icon),
            border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Constants.themeGreyLight, width: 1.0),
                borderRadius: BorderRadius.circular(5.0)),
            contentPadding: EdgeInsets.all(10.0),
          ),
          controller: controller,
        ),
      ),
    );
  }
}
