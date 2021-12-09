import 'dart:io';

import 'package:edeybe/controllers/product_controller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/models/order.dart';
import 'package:edeybe/screens/product_details_screen/product_details_bottom_bar/bottom_bar.dart';
import 'package:edeybe/screens/product_details_screen/product_details_screen.dart';
import 'package:edeybe/utils/cart_item_type.dart';
import 'package:edeybe/utils/helper.dart';
import 'package:edeybe/utils/ratingDialog.dart';
import 'package:edeybe/utils/ratingStars.dart';
import 'package:edeybe/widgets/ShimmerLoader.dart';
import 'package:edeybe/widgets/custom_dialog.dart';
import 'package:edeybe/widgets/money_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';

class CartItem extends StatelessWidget {
  final CartItemType type;
  final VoidCallback onMovePressed;
  final VoidCallback onRemovePressed;
  final VoidCallback onIncreaseQunatity;
  final VoidCallback onDecreaseQunatity;
  final VoidCallback onTrackOrder;
  final VoidCallback onViewDetails;
  final VoidCallback onRateComment;
  final Widget onCkeck;
  final dynamic product;
  final bool isLoading;
  final bool tappable;
  final bool isComment;
  final bool isCheckOut;
  final formatCurrency = new NumberFormat.simpleCurrency(name: "");
  CartItem(
      {Key key,
      @required this.type,
      this.onRateComment,
      @required this.product,
      this.onMovePressed,
      this.isLoading = false,
      this.isCheckOut = false,
      this.onTrackOrder,
      this.onIncreaseQunatity,
      this.onDecreaseQunatity,
      this.onViewDetails,
      this.isComment = false,
      this.tappable = true,
     @required this.onCkeck,
      this.onRemovePressed})
      : super(key: key);
  final _productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading || !tappable
          ? null
          : () {
              if (!(product is Order)) {
                _productController.setInViewProduct(product);
                Get.to(ProductDetailsScreen());
              }
            },
      child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 5.w,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.1), width: 5.w))),
          child: Stack(
            children: [
              if (isCheckOut) onCkeck,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: ShimmerLoading(
                            isLoading: isLoading,
                            child: Padding(
                              padding: EdgeInsets.only(right: 5.w),
                              child: isLoading
                                  ? Container(
                                      height: 65.w,
                                      color: Colors.black,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: product.photos[0].sm,
                                      // alignment: Alignment.center,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8.w),
                                  child: ShimmerLoading(
                                    isLoading: isLoading,
                                    child: isLoading
                                        ? Helper.textPlaceholder
                                        : Text(
                                            product.productName,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 13.w,
                                                fontWeight: FontWeight.normal),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                  ),
                                ),
                                ShimmerLoading(
                                  isLoading: isLoading,
                                  child: isLoading
                                      ? Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Helper.textPlaceholder,
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              S.of(context).soldBy +
                                                  " : ${product is Order ? "" : product.brand}",
                                              style: TextStyle(
                                                  fontSize: 12.w,
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                            if (isComment != null && isComment)
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.w),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    androidSelectCity(
                                                        context: context,
                                                        title: product);
                                                  },
                                                  child: Text(
                                                    "Rate",
                                                    style: TextStyle(
                                                      fontSize: 14.w,
                                                    ),
                                                  ))
                                          ],
                                        ),
                                ),
                                ShimmerLoading(
                                  isLoading: isLoading,
                                  child: isLoading
                                      ? Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Helper.textPlaceholder,
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            if (product.variants != null)
                                              for (var x in product.variants)
                                                if (x.variantId ==
                                                    product.selectedVariant)
                                                  MoneyWidget(
                                                    offset: Offset(3, 3.5),
                                                    scalefactor: 1,
                                                    currency: "GHS",
                                                    fontWeight: FontWeight.w800,
                                                    currencyFirst: true,
                                                    children: [
                                                      // TextSpan(text: "Hellp")
                                                      TextSpan(
                                                        text:
                                                            "${formatCurrency.format(product is Order ? double.parse(product.productTotal) : (x.discountPrice == null && x.price == null ? product.price : x.hasDiscount ? x.discountPrice : x.price))}",
                                                        style: Get
                                                            .textTheme.bodyText1
                                                            .copyWith(
                                                                fontSize: 14.w,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    ],
                                                  ),
                                            if (!product.hasVariants)
                                              MoneyWidget(
                                                offset: Offset(3, 3.5),
                                                scalefactor: 1,
                                                currency: "GHS",
                                                fontWeight: FontWeight.w800,
                                                currencyFirst: true,
                                                children: [
                                                  // TextSpan(text: "Hellp")
                                                  TextSpan(
                                                    text:
                                                        "${formatCurrency.format(product is Order ? double.parse(product.productTotal) : (product.hasDiscount ? product.discountPrice : product.price))}",
                                                    style: Get
                                                        .textTheme.bodyText1
                                                        .copyWith(
                                                            fontSize: 14.w,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                  ),
                                                ],
                                              ),
                                            if (product.hasVariants &&
                                                product.selectedVariant == null)
                                              MoneyWidget(
                                                offset: Offset(3, 3.5),
                                                scalefactor: 1,
                                                currency: "GHS",
                                                fontWeight: FontWeight.w800,
                                                children: [
                                                  // TextSpan(text: "Hellp")
                                                  TextSpan(
                                                    text:
                                                        "${formatCurrency.format(product is Order ? double.parse(product.productTotal) : (!product.hasDiscount ? product.price : product.discountPrice))}",
                                                    style: Get
                                                        .textTheme.bodyText1
                                                        .copyWith(
                                                            fontSize: 14.w,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                  ),
                                                ],
                                              ),
                                            if (product
                                                .availableForHirePurchasing)
                                              banner,

                                         
                                            if (type == CartItemType.Checkout)
                                              Container(
                                                child: Text(
                                                  "QTY : ${product.quantity}",
                                                  style: Get.textTheme.bodyText1
                                                      .copyWith(
                                                          fontSize: 14.w,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                ),
                                              )
                                          ],
                                        ),
                                ),
                                if (type == CartItemType.Orders ||
                                    type == CartItemType.Track)
                                  ShimmerLoading(
                                    isLoading: isLoading,
                                    child: isLoading
                                        ? Helper.textPlaceholder
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                child: Text(
                                                  "QTY : ${product.quantity}",
                                                  style: Get.textTheme.bodyText1
                                                      .copyWith(
                                                          fontSize: 14.w,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                ),
                                              ),
                                              ButtonTheme(
                                                  minWidth: 20.w,
                                                  height: 20.w,
                                                  child: TextButton(
                                                    style: TextButton.styleFrom(
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      backgroundColor: Get
                                                          .theme.primaryColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.w),
                                                      ),
                                                    ),
                                                    onPressed: type ==
                                                            CartItemType.Orders
                                                        ? onViewDetails
                                                        : onTrackOrder,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10.0),
                                                      child: Text(
                                                        type ==
                                                                CartItemType
                                                                    .Orders
                                                            ? S
                                                                .of(context)
                                                                .viewDetails
                                                            : S
                                                                .of(context)
                                                                .trackOrder,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                  )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (type == CartItemType.Cart ||
                      type == CartItemType.Wishlist)
                    ShimmerLoading(
                      isLoading: isLoading,
                      child: isLoading
                          ? Row(
                              children: [
                                Helper.textPlaceholder,
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  flex: type == CartItemType.Wishlist ? 0 : 2,
                                  child: type == CartItemType.Wishlist
                                      ? Container(
                                          height: 0,
                                          width: 0,
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                                width: 25.w,
                                                height: 25.w,
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    padding: EdgeInsets.all(0),
                                                    backgroundColor:
                                                        Colors.white,
                                                    shape: CircleBorder(
                                                        side: BorderSide(
                                                            color: Get.theme
                                                                .primaryColor)),
                                                  ),
                                                  onPressed: onDecreaseQunatity,
                                                  child: Icon(
                                                    Icons.remove,
                                                    size: 15.w,
                                                    color:
                                                        Get.theme.primaryColor,
                                                  ),
                                                )),
                                            Container(
                                              width: 30.w,
                                              padding: EdgeInsets.all(5.w),
                                              child: Text(
                                                "${product.quantity ?? 1}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                                width: 25.w,
                                                height: 25.w,
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    padding: EdgeInsets.all(0),
                                                    backgroundColor:
                                                        Colors.white,
                                                    shape: CircleBorder(
                                                        side: BorderSide(
                                                            color: Get.theme
                                                                .primaryColor)),
                                                  ),
                                                  onPressed: onIncreaseQunatity,
                                                  child: Icon(Icons.add,
                                                      size: 15.w,
                                                      color: Get
                                                          .theme.primaryColor),
                                                )),
                                          ],
                                        ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: onMovePressed,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: 30.w,
                                                child: type ==
                                                        CartItemType.Wishlist
                                                    ? SvgPicture.asset(
                                                        'assets/icons/ic_cart.svg',
                                                        width: 15.w,
                                                        color: Get
                                                            .theme.primaryColor,
                                                      )
                                                    : Icon(
                                                        FontAwesomeIcons.heart,
                                                        size: 18.w,
                                                      ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(5.w),
                                                child: Text(
                                                  ("${type == CartItemType.Wishlist ? S.of(context).moveToCart : S.of(context).moveToWishlist}"),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Get.textTheme.bodyText1
                                                      .copyWith(
                                                    color: type ==
                                                            CartItemType
                                                                .Wishlist
                                                        ? Get.theme.primaryColor
                                                        : Get.textTheme
                                                            .bodyText1.color,
                                                    fontSize: 12.w,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 1.w,
                                          height: 20.w,
                                          padding: EdgeInsets.all(5.w),
                                          decoration: BoxDecoration(
                                            color: type == CartItemType.Wishlist
                                                ? Colors.transparent
                                                : Colors.grey,
                                          ),
                                          child: Text(
                                            ("${type == CartItemType.Wishlist ? S.of(context).moveToCart : S.of(context).moveToWishlist}"),
                                            overflow: TextOverflow.ellipsis,
                                            style: Get.textTheme.bodyText1
                                                .copyWith(
                                              color:
                                                  type == CartItemType.Wishlist
                                                      ? Get.theme.primaryColor
                                                      : Get.textTheme.bodyText1
                                                          .color,
                                              fontSize: 12.w,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: onRemovePressed,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 20.w,
                                                // padding: EdgeInsets.only(right: 10),
                                                child: IconButton(
                                                  padding: EdgeInsets.all(0),
                                                  icon: Icon(
                                                    FontAwesomeIcons.trash,
                                                    size: 15.w,
                                                  ),
                                                  onPressed: null,
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(4.w),
                                                child: Text(
                                                    S.of(context).remove,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Get
                                                        .textTheme.bodyText1
                                                        .copyWith(
                                                            fontSize: 12.w)),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                ],
              ),
            ],
          )),
    );
  }
}

Widget _ratings(
    {BuildContext context,
    Function(double rating) onRating,
    TextEditingController controller,
    FocusNode focus}) {
  return Container(
    color: Colors.white,
    // height: 100,
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ratingStar(
          size: 30,
          function: (double rating) {
            print(rating);
            Platform.isIOS
                ? iosRatingDialog(
                    commentController: controller,
                    commentFocus: focus,
                    context: context,
                    star: "$rating",
                    submit: onRating(rating),
                    rate: rating.toString(),
                  )
                : ratingDialog(
                    commentController: controller,
                    commentFocus: focus,
                    context: context,
                    star: "$rating",
                    submit: onRating(rating));
          },
          rate: 0,
        ),
      ],
    ),
  );
}
