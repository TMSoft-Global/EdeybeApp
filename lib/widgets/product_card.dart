import 'package:edeybe/index.dart';
import 'package:edeybe/models/productModel.dart' as Pro;
// import 'package:edeybe/models/product.dart' as ProductModel;
import 'package:edeybe/utils/constant.dart';
import 'package:edeybe/utils/encryption.dart';
import 'package:edeybe/widgets/ShimmerLoader.dart';
import 'package:edeybe/widgets/money_widget.dart';
import 'package:edeybe/widgets/capsule.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
  ProductCard(
      {Key key,
      this.width,
      this.padding,
      this.hasDiscount = false,
      this.isLoading = false,
      @required this.title,
      @required this.image,
      @required this.isFav,
      @required this.rating,
      @required this.price,
      @required this.oldPrice,
      @required this.raters,
      @required this.discount,
      @required this.onAddToWishList,
      @required this.onViewDetails})
      : super(key: key);
  final String title;
  final num price;
  final num oldPrice;
  final Pro.Photos image;
  final bool isFav;
  final bool isLoading;
  final bool hasDiscount;
  final double rating;
  final double width;
  final double padding;
  final int raters;
  var discount;
  final Function onViewDetails;
  final VoidCallback onAddToWishList;
  final formatCurrency = new NumberFormat.simpleCurrency(name: "");
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? (Get.width / 2.3),
      color: Colors.white,
      margin: EdgeInsets.only(right: padding ?? 10.w),
      child: InkWell(
        onTap: onViewDetails,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
                      // height: 160.w,
                      width: width ?? (Get.width / 2.3).w,
                      child: ShimmerLoading(
                        isLoading: isLoading,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2.0.w),
                          child: isLoading
                              ? Container(
                                  height: 150.w,
                                  width: width ?? ((Get.width / 2.3 - 20)).w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Color(0XFFF6F6F6),
                                  ),
                                )
                              : CachedNetworkImage(
                                  imageUrl: image.sm,
                                  alignment: Alignment.center,
                                  fit: BoxFit.fitWidth,
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 6.w,
                      top: 6.w,
                      child: SizedBox(
                        width: 30.w,
                        height: 30.w,
                        child: RawMaterialButton(
                          onPressed: onAddToWishList,
                          fillColor: Constants.themeGreyLight,
                          shape: CircleBorder(),
                          elevation: 2.0.w,
                          child: Padding(
                            padding: EdgeInsets.all(5.w),
                            child: Center(
                              child: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: isFav
                                    ? Constants.ratingBG
                                    : Constants.themeGreyDark,
                                size: 18.w,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ShimmerLoading(
                      isLoading: isLoading,
                      child: isLoading
                          ? Container(
                              height: 10.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Color(0XFFF6F6F6),
                              ),
                            )
                          : Container(
                              width: Get.width.w,
                              child: Text(
                                "$title",
                                style: TextStyle(
                                  fontSize: 13.w,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            )),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ShimmerLoading(
                            isLoading: isLoading,
                            child: isLoading
                                ? Container(
                                    margin: EdgeInsets.only(top: 10.w),
                                    height: 10.w,
                                    width: Get.width.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Color(0XFFF6F6F6),
                                    ),
                                  )
                                : Row(
                                    children: <Widget>[
                                      MoneyWidget(
                                        offset: Offset(5, 0.1),
                                        scalefactor: 0.9,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        currencyFirst: true,
                                      ),
                                      // if (price.toString().contains("."))
                                      //   Row(
                                      //     children: [
                                      //       Text(
                                      //         price.toString(),
                                      //         maxLines: 2,
                                      //         style: TextStyle(
                                      //             fontSize: 16.w,
                                      //             fontWeight: FontWeight.w800),
                                      //         overflow: TextOverflow.ellipsis,
                                      //       ),
                                      //       Padding(
                                      //         padding: const EdgeInsets.only(
                                      //             bottom: 8.0, top: 3),
                                      //         child: Text(
                                      //           "${hasDecimal(price.toString())}",
                                      //           style: TextStyle(
                                      //               fontSize: 10.w,
                                      //               fontWeight:
                                      //                   FontWeight.w800),
                                      //           overflow: TextOverflow.ellipsis,
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      Row(
                                        children: [
                                          Text(
                                            hasDecimalMain(price.toString()),
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 16.w,
                                                fontWeight: FontWeight.w800),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0, top: 3),
                                            child: Text(
                                              "${hasDecimal(price.toString())}",
                                              style: TextStyle(
                                                  fontSize: 10.w,
                                                  fontWeight: FontWeight.w800),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                        if (hasDiscount)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(2.w),
                                child: Text(
                                  formatCurrency.format(oldPrice),
                                  maxLines: 2,
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 13.w,
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.w600),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(2.w),
                                child: MoneyWidget(
                                  offset: Offset(0, 0),
                                  scalefactor: 0.8,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                      ]),
                  if (hasDiscount)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CapsuleWiget(
                          borderRadius: 4.w,
                          padding: EdgeInsets.fromLTRB(5.w, 2.w, 5.w, 2.w),
                          color: Constants.lightGreen.withOpacity(.2.w),
                          borderColor: Colors.transparent,
                          child: Text(
                            "$discount % ${S.of(context).off}",
                            overflow: TextOverflow.ellipsis,
                            style: Get.textTheme.bodyText1.copyWith(
                                color: Constants.lightGreen, fontSize: 10.w),
                          ),
                        ),
                        CapsuleWiget(
                          borderRadius: 4.w,
                          padding: EdgeInsets.fromLTRB(5.w, 2.w, 5.w, 2.w),
                          color: Get.theme.primaryColor.withOpacity(.2.w),
                          borderColor: Colors.transparent,
                          child: Text(
                            "${S.of(context).freeShipping}",
                            overflow: TextOverflow.ellipsis,
                            style: Get.textTheme.bodyText1.copyWith(
                                color: Get.theme.primaryColor, fontSize: 10.w),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
