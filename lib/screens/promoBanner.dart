import 'package:flutter/material.dart';

class PromoBanner extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xffe8e8e8),
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.close))],
      ),
      backgroundColor: Color(0xffe8e8e8),
      body: Center(
        child: Image.asset("assets/images/banner.jpg")),
    );
  }
}