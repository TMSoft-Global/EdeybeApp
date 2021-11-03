
  // setQuantity(int productIndex, int newQTY, String proID,{String variantID}) {
  //   print("11111$newQTY");
  //   Map<String, dynamic> items = {};

  //   var item = cartItems[productIndex].setQuantity(newQTY);
  //   cartItems[productIndex] = item;
  //   items = {
  //     "items": variantID == null
  //         ? {
  //             "${item.productId}": {"quantity": newQTY}
  //           }
  //         : {
  //             "${item.productId}_${item.selectedVariant}": {
  //               "quantity": item.quantity
  //             }
  //           }
  //   };
  //   cartItems.forEach((item) {
  //     print(items);
  //     // if (item.selectedVariant != null && proID == item.productId) {
  //     //   items["items"][item.productId] = {"quantity": newQTY};
  //     // }
  //     //  else {
  //     //   items["items"][item.productId] = {"quantity": item.quantity};
  //     // }
  //   });
  //   // operations.updateCart(items, (response) {
  //   //   // getCartITems();
  //   //   update();
  //   // }, handleError);
  //   // print(cartItems[productIndex].);
  //   update();
  // }

 

 import 'package:flutter/material.dart';

class MyRadioOption<T> extends StatelessWidget {

  final T value;
  final T groupValue;
  final String label;
  final String text;
  final ValueChanged<T> onChanged;

  const MyRadioOption({
     this.value,
     this.groupValue,
     this.label,
     this.text,
     this.onChanged,
  });

  Widget _buildLabel() {
    final bool isSelected = value == groupValue;

    return Container(
      width: 30,
      height: 30,
      decoration: ShapeDecoration(
        shape: CircleBorder(
          side: BorderSide(
            color: Colors.black,
          ),
        ),
        color: isSelected ? Colors.cyan : Colors.white,
      ),
      child: Center(
        child: Text(
          value.toString(),
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.cyan,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildText() {
    return Text(
      text,
      style: const TextStyle(color: Colors.black, fontSize: 24),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: InkWell(
        onTap: () => onChanged(value),
        splashColor: Colors.cyan.withOpacity(0.5),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              _buildLabel(),
              const SizedBox(width: 10),
              _buildText(),
            ],
          ),
        ),
      ),
    );
  }
}