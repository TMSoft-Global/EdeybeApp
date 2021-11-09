import 'package:edeybe/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget ratingStar({
  @required double rate,
  @required void Function(double rating) function,
  double size = 40,
}) {
  return RatingBar.builder(
    glow: false,
    initialRating: rate,
    minRating: 1,
    direction: Axis.horizontal,
    allowHalfRating: true,
    itemSize: size,
    itemCount: 5,
    unratedColor: Get.theme.primaryColorDark.withOpacity(.4),
    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
    itemBuilder: (context, _) => Icon(
      Icons.star,
      color: Get.theme.primaryColor,
    ),
    onRatingUpdate: function,
  );
}
