import 'dart:io';

import 'package:edeybe/controllers/product_controller.dart';
import 'package:edeybe/utils/constant.dart';
// import 'package:edeybe/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';

class SearchScreen extends StatelessWidget {
  final productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: Platform.isAndroid,
        elevation: 1,
        title: Container(
            child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.w),
                  color: Colors.white,
                ),
                height: 36.w,
                child: TextField(
                  style: TextStyle(fontSize: 13.w),
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    hintText: S.of(context).searchOnedeybe,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Constants.themeGreyLight, width: 1.0.w),
                        borderRadius: BorderRadius.circular(12.w)),
                    contentPadding: EdgeInsets.all(8.w),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            if (Platform.isIOS)
              TextButton(
                onPressed: () => Get.back(),
                child: Text(S.of(context).cancel),
              )
          ],
        )),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 8.h,
            ),
          ],
        ),
      ),
    );
  }
}
