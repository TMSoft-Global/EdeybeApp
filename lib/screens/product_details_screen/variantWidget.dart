import 'package:edeybe/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';

class VariantWidget extends StatefulWidget {
  final productVariant;
  VariantWidget({this.productVariant});

  @override
  _VariantWidgetState createState() => _VariantWidgetState();
}

class _VariantWidgetState extends State<VariantWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    print(widget.productVariant);
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://media.istockphoto.com/photos/running-shoes-picture-id1249496770?s=612x612"),
                          )),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Type: ${widget.productVariant.variantAttributes[0].value}"),
                        Text("Size: " + size),
                        Text("Color: " + color),
                      ],
                    ),
                  ],
                ),
                Radio(
                    value: isSelected,
                    groupValue: widget.productVariant,
                    onChanged: (val) {
                      // setState(() {
                      //   isSelected = val.variantSelected;
                      // });
                      print(val);
                    })
              ],
            ),
          ),
          CustomDivider()
        ],
      ),
    );
    ;
  }
}
