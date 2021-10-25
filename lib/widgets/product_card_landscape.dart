import 'package:edeybe/index.dart';
import 'package:edeybe/models/productModel.dart' as Pro;
// import 'package:edeybe/models/product.dart' as ProductModel;
import 'package:edeybe/utils/constant.dart';
import 'package:edeybe/utils/helper.dart';
import 'package:edeybe/widgets/ShimmerLoader.dart';
import 'package:edeybe/widgets/money_widget.dart';
import 'package:edeybe/widgets/capsule.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductCardLandscape extends StatelessWidget {
  ProductCardLandscape(
      {Key key,
      this.width,
      @required this.title,
      this.isLoading = false,
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
  final double rating;
  final double width;
  final int raters;
  final int discount;
  final Function onViewDetails;
  final VoidCallback onAddToWishList;
  final formatCurrency = new NumberFormat.simpleCurrency(name: "");
  final GlobalKey productKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onViewDetails,
      child: Container(
        key: productKey,
        height: 125.w,
        width: width ?? Get.width,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(10.w),
                height: 150.w,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(2.w),
                    child: ShimmerLoading(
                        isLoading: isLoading,
                        child: _buildShimmerLoaderChild(
                          CachedNetworkImage(
                            imageUrl: "${image?.sm}",
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                          ),
                        ))),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Padding(
                              padding: EdgeInsets.only(right: 12.0),
                              child: ShimmerLoading(
                                isLoading: isLoading,
                                child: _buildShimmerLoaderChild(Text(
                                  "$title",
                                  style: TextStyle(
                                    fontSize: 11.w,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                )),
                              )),
                        ),
                        SizedBox(
                          width: 30.w,
                          height: 30.w,
                          child: RawMaterialButton(
                            onPressed:onAddToWishList,
                            fillColor: Constants.themeGreyLight,
                            shape: CircleBorder(),
                            elevation: 2.0.w,
                            child: Padding(
                              padding: EdgeInsets.all(5.w),
                              child: Center(
                                child: Icon(
                                  isFav
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFav
                                      ? Constants.ratingBG
                                      : Constants.themeGreyDark,
                                  size: 18.w,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: ShimmerLoading(
                                  isLoading: isLoading,
                                  child: _buildShimmerLoaderChild(
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          formatCurrency.format(price),
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 14.w,
                                              fontWeight: FontWeight.w800),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        MoneyWidget(
                                          offset: Offset(4, 2),
                                          scalefactor: 0.7,
                                          fontWeight: FontWeight.w500,
                                        )
                                      ],
                                    ),
                                  ))),
                          if (price != oldPrice)
                            ShimmerLoading(
                                isLoading: isLoading,
                                child: _buildShimmerLoaderChild(Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(3.w),
                                      child: Text(
                                        formatCurrency.format(oldPrice),
                                        maxLines: 2,
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 10.w,
                                            color: Colors.grey[400],
                                            fontWeight: FontWeight.w600),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5.w),
                                      child: MoneyWidget(
                                        offset: Offset(0, 0),
                                        fontSize: 10.w,
                                        scalefactor: 1,
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                )))
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        if (discount > 0)
                          ShimmerLoading(
                              isLoading: isLoading,
                              child: _buildShimmerLoaderChild(CapsuleWiget(
                                borderRadius: 4.w,
                                padding:
                                    EdgeInsets.fromLTRB(5.w, 2.w, 5.w, 2.w),
                                color: Constants.lightGreen.withOpacity(.2.w),
                                borderColor: Colors.transparent,
                                child: Text(
                                  "$discount % ${S.of(context).off}",
                                  overflow: TextOverflow.ellipsis,
                                  style: Get.textTheme.bodyText1.copyWith(
                                      color: Constants.lightGreen,
                                      fontSize: 11.w),
                                ),
                              ))),
                        // ShimmerLoading(
                        //     isLoading: isLoading,
                        //     child: _buildShimmerLoaderChild(CapsuleWiget(
                        //       borderRadius: 4.w,
                        //       padding: EdgeInsets.fromLTRB(5.w, 2.w, 5.w, 2.w),
                        //       color: Get.theme.primaryColor.withOpacity(.2.w),
                        //       borderColor: Colors.transparent,
                        //       child: Text(
                        //         "${S.of(context).freeShipping}",
                        //         overflow: TextOverflow.ellipsis,
                        //         style: Get.textTheme.bodyText1.copyWith(
                        //             color: Get.theme.primaryColor,
                        //             fontSize: 11.w),
                        //       ),
                        //     ))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerLoaderChild(Widget child) {
    if (isLoading) {
      return Helper.textPlaceholder;
    } else
      return child;
  }
}
