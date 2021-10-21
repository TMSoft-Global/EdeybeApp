import 'package:edeybe/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';

class VariantWidget extends StatefulWidget {
  final productVariant;
   bool isSelected;
   Function onChange;

  VariantWidget({this.productVariant, this.isSelected,this.onChange});

  @override
  _VariantWidgetState createState() => _VariantWidgetState();
}

class _VariantWidgetState extends State<VariantWidget> {
  // bool isSelected = false;
  // int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // print(widget.index);
        // setState(() {
        //   isSelected = !isSelected;
        // });
      },
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
                        Text("Type: ${widget.productVariant.variantName}"),
                        Text("${widget.productVariant.variantAttributes[0].value}".length >1 ? "Color:  ${widget.productVariant.variantAttributes[0].value}": "Size: " + "${widget.productVariant.variantAttributes[0].value}"),
                        Text("${widget.productVariant.variantAttributes[1].value}".length >1 ? "Color:  ${widget.productVariant.variantAttributes[1].value}": "Size: " + "${widget.productVariant.variantAttributes[1].value}"),
                      ],
                    ),
                  ],
                ),
                Radio(
                    value: widget.isSelected,
                    groupValue:widget.productVariant.variantSelected ,
                    onChanged: (val) {
                      // setState(() {
                      //   selectedIndex = val;
                      // });
                      // print(val);
                    })
              ],
            ),
          ),
          CustomDivider()
        ],
      ),
    );
    
  }
}
