import 'package:edeybe/index.dart';
import 'package:edeybe/models/productModel.dart';
import 'package:flutter/material.dart';

Widget imageCarousel({List<Photos> images, BuildContext context}) {
  return Container(
    height: 180.w,
    width: Get.width.w,
    child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (_, i) {
          return Container(
            width: MediaQuery.of(context).size.width - 10,
            child: CachedNetworkImage(
              imageUrl: images[i].sm,
              fit: BoxFit.fitWidth,
            ),
          );
        }),
  );
}
