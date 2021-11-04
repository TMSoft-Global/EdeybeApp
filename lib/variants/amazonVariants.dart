import 'package:flutter/material.dart';

class AmazonVariants extends StatelessWidget {
  const AmazonVariants({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 170,
            width: double.infinity,
          ),
          Text("Getway Cropped Sweatshirt"),
          Text("Price: \$18.00"),
          Text("Fit: True to Size Order useal size"),
          Text("Size"),
          

        ],
      ),
    );
  }
}