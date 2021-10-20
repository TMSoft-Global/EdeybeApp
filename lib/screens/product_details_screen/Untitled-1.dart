// import 'package:edeybe/controllers/cart_controller.dart';
// import 'package:edeybe/controllers/product_controller.dart';
// import 'package:edeybe/controllers/wishlist_controller.dart';
// import 'package:edeybe/screens/checkout_screen/checkout_screen.dart';
// import 'package:edeybe/screens/product_details_screen/product_details_bottom_bar/bottom_bar.dart';
// import 'package:edeybe/screens/products_view/products.dart';
// // import 'package:edeybe/screens/review_screen/review_screen.dart';
// import 'package:edeybe/screens/wishlist_screen/wishlist_screen.dart';
// import 'package:edeybe/services/server_operation.dart';
// import 'package:edeybe/utils/cart_item_type.dart';
// import 'package:edeybe/utils/constant.dart';
// import 'package:edeybe/utils/helper.dart';
// import 'package:edeybe/widgets/Shimmer.dart';
// import 'package:edeybe/widgets/capsule.dart';
// import 'package:edeybe/widgets/cart_dialog.dart';
// import 'package:edeybe/widgets/custom_divider.dart';
// import 'package:edeybe/widgets/money_widget.dart';
// import 'package:edeybe/widgets/post_gallery.dart';
// import 'package:edeybe/widgets/products_grid.dart';
// // import 'package:edeybe/widgets/start_rating.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter/material.dart';
// import 'package:edeybe/index.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter/rendering.dart';

// class ProductDetailsScreen extends StatefulWidget {
//   ProductDetailsScreen({Key key}) : super(key: key);
//   @override
//   _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
// }

// class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
//   _ProductDetailsScreenState();
//   int quanity;
//   final formatCurrency = new NumberFormat.simpleCurrency(name: "");
//   final _productController = Get.find<ProductController>();
//   final _cartController = Get.find<CartController>();
//   final _wishlistController = Get.find<WishlistController>();
//   String _deliverto;

// // state functions
//   void _setDeliveryLocation(text) {
//     setState(() {
//       _deliverto = text;
//     });
//   }

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
//         // _productController
//         //     .getProductbyId(_productController.product.value.sku));
//         _productController
//             .getProductVariantByID(_productController.product.value.sku));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           S.of(context).details,
//           style: TextStyle(fontSize: 20.w),
//         ),
//         centerTitle: false,
//         brightness: Brightness.dark,
//         actions: <Widget>[
//           IconButton(
//             iconSize: 25.w,
//             icon: Icon(
//               Helper.isFavourite(
//                       _productController.product.value.sku, _wishlistController)
//                   ? Icons.favorite
//                   : Icons.favorite_border,
//               color: Helper.isFavourite(
//                       _productController.product.value.sku, _wishlistController)
//                   ? Constants.ratingBG
//                   : Colors.white,
//             ),
//             onPressed: () {
//               _wishlistController.addToWishlist(
//                   _productController.product.value,
//                   ({String title}) => Get.dialog(
//                         CartDialog(
//                             title: title,
//                             type: CartItemType.Wishlist,
//                             onGoForward: () => Get.to(WishlistScreen()),
//                             productTitle: _productController.product.value.name,
//                             cartTotal: formatCurrency.format(
//                                 _wishlistController.wishlistItems.fold(
//                                     0,
//                                     (previousValue, element) =>
//                                         element.priceRange.minimumPrice
//                                             .finalPrice.value +
//                                         previousValue))),
//                         barrierDismissible: true,
//                       ));
//             },
//           ),
//           // IconButton(
//           //   iconSize: 25.w,
//           //   icon: Icon(Icons.share),
//           //   onPressed: () {

//           //   },
//           // ),
//         ],
//       ),
//       bottomNavigationBar: Obx(() => ProductDetailsBottomBar(
//             onSetQuantity: (value) {
//               setState(() {
//                 _productController.setQuantity(value);
//               });
//             },
//             onAddToCart: _productController.product != null
//                 ? () {
//                     _cartController.addToCart(_productController.product?.value,
//                         ({String title}) {
//                       if (Get.isDialogOpen) {
//                         Get.back();
//                       }
//                       Get.dialog(
//                         CartDialog(
//                             title: title,
//                             type: CartItemType.Cart,
//                             onGoForward: () => Get.off(CheckoutScreen()),
//                             productTitle: _productController.product.value.name,
//                             cartTotal: formatCurrency.format(
//                                 _cartController.cartItems.fold(
//                                     0,
//                                     (previousValue, element) =>
//                                         element.priceRange.minimumPrice
//                                             .finalPrice.value +
//                                         previousValue))),
//                         barrierDismissible: true,
//                       );
//                     });
//                   }
//                 : null,
//             quantity: _productController.product.value?.quantity,
//           )),
//       body: Shimmer(
//           linearGradient: Constants.shimmerGradient,
//           child: GetBuilder<ProductController>(
//             builder: (_productStl) => SingleChildScrollView(
//                 // controller: controller,
//                 child: Padding(
//               padding: EdgeInsets.only(bottom: 8.w),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.symmetric(vertical: 10.w),
//                     height: 260.h,
//                     width: Get.width.w,
//                     color: Constants.themeGreyLight,
//                     child: _productStl.productDetail.value.photos != null
//                         ? CarouselSlider(
//                             showDots: false,
//                             itemCount: _productController
//                                 .productDetail.value.photos?.length,
//                             itemBuilder: (context, ind) => Container(
//                               padding: EdgeInsets.all(10.w),
//                               margin: EdgeInsets.only(right: 10.w),
//                               width: Get.width.w,
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(12.w)),
//                               child: GestureDetector(
//                                 onTap: () => Get.dialog(PostGallery(
//                                   images:
//                                       _productStl.product.value.mediaGallery,
//                                   currentImage: ind,
//                                 )),
//                                 child: Image(
//                                   image: NetworkImage(
//                                     "$domain/api/images/" +
//                                             _productStl.productDetail.value
//                                                 .photos[ind].sm ??
//                                         "",
//                                   ),
//                                   alignment: Alignment.center,
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                             ),
//                           )
//                         : SizedBox.shrink(),
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(left: 20.w, right: 40.w, top: 5.w),
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       _productStl.productDetail.value.productName ?? "".tr,
//                       maxLines: 2,
//                       style: TextStyle(
//                           fontSize: 15.w, fontWeight: FontWeight.w600),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(left: 20.w),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Expanded(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Text(
//                                 "${S.of(context).brand} : ${_productStl.productDetail.value.brand}"
//                                     .tr,
//                                 maxLines: 2,
//                                 style: TextStyle(
//                                     fontSize: 13.w,
//                                     fontWeight: FontWeight.w600),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               MoneyWidget(
//                                 offset: Offset(3, 3.5),
//                                 scalefactor: 1,
//                                 fontWeight: FontWeight.w800,
//                                 children: [
//                                   TextSpan(
//                                     text: formatCurrency.format(
//                                         _productController
//                                             .product
//                                             .value
//                                             .priceRange
//                                             .minimumPrice
//                                             .finalPrice
//                                             .value),
//                                     style: TextStyle(
//                                         fontSize: 17.w,
//                                         fontWeight: FontWeight.w800,
//                                         color: Colors.black),
//                                   ),
//                                 ],
//                               ),
//                               if (_productStl.product.value.priceRange
//                                       .minimumPrice.finalPrice.value !=
//                                   _productStl.product.value.priceRange
//                                       .minimumPrice.regularPrice.value)
//                                 MoneyWidget(
//                                     offset: Offset(3, 3.5),
//                                     scalefactor: 1,
//                                     fontWeight: FontWeight.w800,
//                                     children: [
//                                       TextSpan(
//                                         text: formatCurrency.format(
//                                             _productController
//                                                 .product
//                                                 .value
//                                                 .priceRange
//                                                 .minimumPrice
//                                                 .regularPrice
//                                                 .value),
//                                         style: TextStyle(
//                                             decoration:
//                                                 TextDecoration.lineThrough,
//                                             fontSize: 13.w,
//                                             color: Colors.grey[400],
//                                             fontWeight: FontWeight.w600),
//                                       )
//                                     ]),
//                             ],
//                           ),
//                         ),
//                         Expanded(
//                           child: Padding(
//                             padding: EdgeInsets.only(right: 15.w, left: 10.w),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: <Widget>[
//                                 // StarRating(
//                                 //   onRatingChanged: (d) => Get.to(ReviewScreen(
//                                 //     reviews: [
//                                 //       {
//                                 //         "name": "Ella White",
//                                 //         "rating": 4.5,
//                                 //         "moment": "Today",
//                                 //         "review": "Great quality well spent!"
//                                 //       },
//                                 //       {
//                                 //         "name": "Jack Anderson",
//                                 //         "rating": 4.0,
//                                 //         "moment": "Yesterday",
//                                 //         "review": ""
//                                 //       },
//                                 //       {
//                                 //         "name": "Lilly Williams",
//                                 //         "rating": 3.5,
//                                 //         "moment": "Two weeks ago",
//                                 //         "review": "Fresh!"
//                                 //       },
//                                 //       {
//                                 //         "name": "Jeana Varzar",
//                                 //         "rating": 4.0,
//                                 //         "moment": "Two months ago",
//                                 //         "review":
//                                 //             "Loved it, pirce little high but worth it."
//                                 //       }
//                                 //     ],
//                                 //     product: _productStl.product.value,
//                                 //   )),
//                                 //   starCount: 5,
//                                 //   color: Constants.ratingBG,
//                                 //   allowHalfRating: true,
//                                 //   rating: 3.3,
//                                 //   size: 15.w,
//                                 // ),
//                                 // Container(
//                                 //   padding: EdgeInsets.all(5.w),
//                                 //   child: Text(
//                                 //     "(18 ${S.of(context).rating})",
//                                 //     maxLines: 2,
//                                 //     textAlign: TextAlign.center,
//                                 //     style: TextStyle(
//                                 //         color: Colors.grey[400],
//                                 //         fontSize: 13.w,
//                                 //         fontWeight: FontWeight.normal),
//                                 //     overflow: TextOverflow.ellipsis,
//                                 //   ),
//                                 // ),
//                                 if (_productStl.product.value.priceRange
//                                         .minimumPrice.discount.percentOff >
//                                     0)
//                                   CapsuleWiget(
//                                     borderRadius: 4.w,
//                                     padding: EdgeInsets.fromLTRB(
//                                         10.w, 2.w, 10.w, 2.w),
//                                     color: Get.theme.primaryColor
//                                         .withOpacity(0.2.w),
//                                     borderColor: Colors.transparent,
//                                     child: Text(
//                                       "${_productStl.product.value.priceRange.minimumPrice.discount.percentOff} % ${S.of(context).off}",
//                                       style: Get.textTheme.bodyText1.copyWith(
//                                           color: Get.theme.primaryColor,
//                                           fontSize: 13.w),
//                                     ),
//                                   )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.fromLTRB(20.w, 5.w, 20.w, 5.w),
//                     child: CustomDivider(
//                       color: Colors.grey[500],
//                     ),
//                   ),
//                   if (_productStl.product.value.configurableOptions != null)
//                     Column(
//                       children: _productController
//                           .product.value.configurableOptions
//                           .map(
//                             (e) => Container(
//                               padding:
//                                   EdgeInsets.fromLTRB(20.w, 0.w, 20.w, 0.w),
//                               child: Column(
//                                 children: <Widget>[
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: <Widget>[
//                                       Text(
//                                         e.label,
//                                         style: TextStyle(
//                                             color: Colors.grey[400],
//                                             fontSize: 13.w,
//                                             fontWeight: FontWeight.normal),
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.all(8.w),
//                                         child: Text(
//                                           e.values[0].label,
//                                           style: TextStyle(
//                                               fontSize: 13.w,
//                                               fontWeight: FontWeight.bold),
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   _buildCapsuleList(e.values, 0),
//                                 ],
//                               ),
//                             ),
//                           )
//                           .toList(),
//                     ),
//                   Padding(
//                       padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: <Widget>[
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Text(
//                                   "Availability",
//                                   style: TextStyle(
//                                       color: Colors.grey[400],
//                                       fontSize: 11,
//                                       fontWeight: FontWeight.normal),
//                                 ),
//                                 Text(
//                                   _productController
//                                               .product.value.stockStatus !=
//                                           null
//                                       ? _productStl.product.value
//                                               .stockStatus["instock"]
//                                           ? "In stock"
//                                           : "Sold out"
//                                       : "_",
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.normal),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Text(
//                                   "Model",
//                                   style: TextStyle(
//                                       color: Colors.grey[400],
//                                       fontSize: 11,
//                                       fontWeight: FontWeight.normal),
//                                 ),
//                                 Text(
//                                   "-----------",
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.normal),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Text(
//                                   "SKU",
//                                   style: TextStyle(
//                                       color: Colors.grey[400],
//                                       fontSize: 11,
//                                       fontWeight: FontWeight.normal),
//                                 ),
//                                 Text(
//                                   _productStl.product.value.sku ?? "",
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.normal),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       )),
//                   CustomDivider(
//                     height: 60.h,
//                     thickness: 60.h,
//                     color: Colors.grey[200],
//                   ),
//                   _buildDeliveryWidget(),
//                   CustomDivider(
//                     height: 60.h,
//                     thickness: 60.h,
//                     color: Colors.grey[200],
//                   ),
//                   _buildVarientProduct(),
//                   CustomDivider(
//                     height: 5.h,
//                     thickness: 5.h,
//                     color: Colors.grey[200],
//                   ),
//                   _buildProductAndSpecsDetails(),
//                   Padding(
//                     padding: EdgeInsets.all(8.w),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.all(10.w),
//                               child: Text('${S.of(context).sellerInfo}'),
//                             ),
//                           ],
//                         ),
//                         if (_productStl.product.value.seller != null)
//                           ListTile(
//                             tileColor: Colors.white,
//                             title: Text(
//                               "${_productStl.product.value.seller.name}".tr,
//                               maxLines: 2,
//                               style: TextStyle(
//                                   fontSize: 13.w, fontWeight: FontWeight.w600),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             trailing: Icon(
//                               Icons.arrow_forward_ios_rounded,
//                               size: 15.w,
//                             ),
//                             onTap: () => Get.to(ProductsView(
//                                 type: _productStl.product.value.seller)),
//                           )
//                       ],
//                     ),
//                   ),
//                   if (_productStl.product.value.relatedProducts != null &&
//                       _productController
//                           .product.value.relatedProducts.isNotEmpty)
//                     _buildRelatedProducts(),
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //   children: <Widget>[
//                   //     Padding(
//                   //       padding: EdgeInsets.only(
//                   //           bottom: 8.w, top: 8.w, left: 10.w, right: 10.w),
//                   //       child: Text(
//                   //           S.of(context).frequentlyBoughttogether.toUpperCase()),
//                   //     ),
//                   //     OutlinedButton(
//                   //       style: OutlinedButton.styleFrom(
//                   //           shape: RoundedRectangleBorder(
//                   //         side: BorderSide(color: Colors.transparent),
//                   //       )),
//                   //       onPressed: () {},
//                   //       child: Text(
//                   //         S.current.viewAll,
//                   //         style: Get.textTheme.bodyText1
//                   //             .copyWith(color: Constants.mainColor),
//                   //       ),
//                   //     )
//                   //   ],
//                   // ),
//                   // ProductsGrid(
//                   //   products: products,
//                   // ),
//                 ],
//               ),
//             )),
//           )),
//     );
//   }

//   // build delivery offer options
//   Widget _buildDeliveryOffers(String icon, {String label}) {
//     return Container(
//       alignment: Alignment.centerLeft,
//       padding: EdgeInsets.only(top: 10.0.w, bottom: 10.0.w),
//       width: (Get.width / 2.3 - 5),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           SvgPicture.asset(
//             icon,
//             width: 24.w,
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: 5.w, right: 5.w),
//             child: Text(
//               label,
//               style: TextStyle(fontSize: 13.w),
//               overflow: TextOverflow.ellipsis,
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   // build capsule list
//   Widget _buildCapsuleList(List capsules, int active) {
//     return Container(
//       height: 30.h,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: capsules.length,
//         itemBuilder: (BuildContext context, int i) {
//           var capsule = capsules[i];
//           return CapsuleWiget(
//             onPressed: () {},
//             text: capsule.label,
//             borderColor: active == i ? Get.theme.primaryColor : null,
//           );
//         },
//       ),
//     );
//   }

//   // build delivery widget
//   Widget _buildDeliveryWidget() {
//     return new Container(
//       padding: EdgeInsets.fromLTRB(20.w, 5.w, 20.w, 5.w),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//               // Text(
//               //   "${S.of(context).deliverTo}:",
//               //   style: TextStyle(
//               //       color: Colors.grey[400],
//               //       fontSize: 11.w,
//               //       fontWeight: FontWeight.normal),
//               // ),
//               // Container(
//               //   height: 35.w,
//               //   padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 5.w),
//               //   margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 5.w),
//               //   decoration: BoxDecoration(
//               //       color: Colors.white,
//               //       border: Border.all(
//               //           width: 1.w, color: Colors.grey.withOpacity(0.2)),
//               //       borderRadius: BorderRadius.circular(5.0)),
//               //   child: DropdownButtonHideUnderline(
//               //     child: DropdownButton(
//               //       value: _deliverto ?? "0",
//               //       isDense: true,
//               //       icon: Icon(Icons.keyboard_arrow_down),
//               //       onChanged: _setDeliveryLocation,
//               //       items: <DropdownMenuItem>[
//               //         DropdownMenuItem(
//               //           value: "0",
//               //           child: Text(
//               //             "Dubai",
//               //             textAlign: TextAlign.center,
//               //             style: Get.textTheme.bodyText1.copyWith(
//               //                 color: Get.theme.primaryColor,
//               //                 fontSize: 13.w,
//               //                 fontWeight: FontWeight.bold),
//               //           ),
//               //         ),
//               //         DropdownMenuItem(
//               //           child: Text(
//               //             "Ghoboar",
//               //             textAlign: TextAlign.center,
//               //             style: Get.textTheme.bodyText1.copyWith(
//               //                 fontSize: 13.w, fontWeight: FontWeight.bold),
//               //           ),
//               //         ),
//               //         DropdownMenuItem(
//               //           child: Text(
//               //             "Abu Dabi",
//               //             textAlign: TextAlign.center,
//               //             style: Get.textTheme.bodyText1.copyWith(
//               //                 fontSize: 13.w, fontWeight: FontWeight.bold),
//               //           ),
//               //         ),
//               //         DropdownMenuItem(
//               //           child: Text(
//               //             "Riyadh",
//               //             textAlign: TextAlign.center,
//               //             style: Get.textTheme.bodyText1.copyWith(
//               //                 fontSize: 13.w, fontWeight: FontWeight.bold),
//               //           ),
//               //         ),
//               //         DropdownMenuItem(
//               //           child: Text(
//               //             "Macca",
//               //             textAlign: TextAlign.center,
//               //             style: Get.textTheme.bodyText1.copyWith(
//               //                 fontSize: 13.w, fontWeight: FontWeight.bold),
//               //           ),
//               //         ),
//               //       ],
//               //     ),
//               //   ),
//               // ),
//               Padding(
//                 padding: EdgeInsets.all(8.w),
//                 child: Text(
//                   "Delivery in",
//                   style:
//                       TextStyle(fontSize: 12.w, fontWeight: FontWeight.normal),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(0.0),
//                 child: Text(
//                   "3 - 4 days",
//                   style: TextStyle(
//                       color: Get.theme.primaryColor,
//                       fontSize: 12.w,
//                       fontWeight: FontWeight.normal),
//                 ),
//               ),
//             ],
//           ),
//           CustomDivider(
//             color: Colors.grey[500],
//           ),
//           Wrap(
//             runSpacing: 0,
//             spacing: 10,
//             crossAxisAlignment: WrapCrossAlignment.start,
//             children: <Widget>[
//               _buildDeliveryOffers('assets/icons/warranty.svg',
//                   label: "Genuine & Warranted"),
//               // _buildDeliveryOffers('assets/icons/cash-on-delivery.svg',
//               //     label: "Cash On Delivery"),
//               // _buildDeliveryOffers('assets/icons/truck.svg',
//               //     label: "Free Shipping"),
//               _buildDeliveryOffers('assets/icons/return.svg',
//                   label: "Free & Easy Returns")
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // product details and specifications builder
//   Widget _buildProductAndSpecsDetails() {
//     Map<String, String> specs = {
//       "Colour": "Aura Glow",
//       "Display Type": "AMOLED",
//       "Screen Size": "6.8 inch",
//       "Internal Memory": "512 GB",
//       "Product Weight": "196 g",
//       "Battery Capacity": "4300 mAh",
//       "RAM": "12 GB",
//       "Operating System": "Android",
//       "Processor Speed": "2.73 GHz",
//       "SIM Count": "Single SIM",
//       "Model Number": "Note10plusglow",
//       "Model Name": "Note 10 Plus"
//     };
//     List<TableRow> rows = [];
//     specs.forEach((key, value) {
//       rows.add(TableRow(children: <Widget>[
//         Container(
//           color: Colors.grey[100],
//           padding: EdgeInsets.all(8.w),
//           child: Text(
//             key,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(color: Colors.grey[400]),
//           ),
//         ),
//         Container(
//             padding: EdgeInsets.all(8.w),
//             child: Text(
//               value,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(color: Colors.grey[400]),
//             ))
//       ]));
//     });
//     return DefaultTabController(
//         length: 1,
//         child: Container(
//           color: Colors.white,
//           constraints:
//               BoxConstraints(minHeight: 100.w, maxHeight: Get.height / 2),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               TabBar(
//                 indicatorColor: Get.theme.primaryColor,
//                 labelColor: Get.theme.primaryColor,
//                 unselectedLabelColor: Get.textTheme.bodyText1.color,
//                 tabs: <Widget>[
//                   Tab(text: S.of(context).productDetails.toUpperCase()),
//                   // Tab(text: S.of(context).specifications.toUpperCase())
//                 ],
//               ),
//               Expanded(
//                 child: TabBarView(
//                   children: <Widget>[
//                     SingleChildScrollView(
//                       child: Container(
//                         padding: EdgeInsets.all(20.w),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.min,
//                           children: <Widget>[
//                             Html(
//                               data: _productController
//                                       .product.value.description?.html ??
//                                   "",
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     // SingleChildScrollView(
//                     //   child: Container(
//                     //     padding: EdgeInsets.all(20.w),
//                     //     child: Table(
//                     //       border: TableBorder.all(color: Colors.grey[400]),
//                     //       children: rows,
//                     //     ),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ));
//   }

//   Widget _buildRelatedProducts() {
//     return GetBuilder<ProductController>(builder: (_p) {
//       return Container(
//         child: Wrap(
//           children: [
//             Row(
//               children: <Widget>[
//                 Container(
//                   padding: EdgeInsets.only(
//                       bottom: 8.w, top: 8.w, left: 10.w, right: 10.w),
//                   alignment: Alignment.bottomLeft,
//                   child: Text(S.of(context).relatedProducts.toUpperCase()),
//                 ),
//               ],
//             ),
//             ProductsGrid(
//               scrollDirection: Axis.vertical,
//               products: _p.product.value.relatedProducts,
//             ),
//           ],
//         ),
//       );
//     });
//   }

//   Widget _buildVarientProduct() {
//     return GetBuilder<ProductController>(builder: (_p) {
//       return Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           // color: Colors.white
//         ),
//         child: Column(
//           children: [
//             Text("Available Variant", style: Get.theme.textTheme.subtitle1),
//             Wrap(
//               children: [
//                 for (int x = 0; x < _p.productDetail.value.variants.length; x++)
//                   varientButton(
//                       p: _p,
//                       index: x,
//                       onTap: () {
//                         setState(() {
//                           print(
//                               "Has Variant ${_p.productDetail.value.variants[x].discountPrice == null ? _p.productDetail.value.price : _p.productDetail.value.variants[x].price}");
//                         });
//                       })
//               ],
//             )
//           ],
//         ),
//       );
//     });
//   }
// }

// Widget varientButton({var p, VoidCallback onTap, int index}) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 7),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Container(
//                 height: 100.h,
//                 width: 100.w,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     image: DecorationImage(
//                       image: NetworkImage("$domain/api/images/" +
//                           p.productDetail.value.photos[index].sm),
//                     )),
//               ),
//               SizedBox(
//                 width: 15,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Type: " +
//                       p.productDetail.value.variants[index].variantName),
//                   Text("Size: " +
//                       p.productDetail.value.variants[index].variantAttributes[0]
//                           .value),
//                   Text("Color: " +
//                       p.productDetail.value.variants[index].variantAttributes[1]
//                           .value),
//                 ],
//               ),
//             ],
//           ),
//           Checkbox(value: false, onChanged: (v) {})
//         ],
//       ),
//     ),
//   );
// }




//   // biuld payment method card
//   Widget get _biuldPaymentMethod {
//     return GetBuilder<PaymentMethodController>(
//         builder: (_) => Container(
//             // height: 30.w,
//             margin: EdgeInsets.all(10.w),
//             padding: EdgeInsets.all(10.0.w),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8.w),
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Constants.boxShadow,
//                     blurRadius: 3.4.w,
//                     offset: Offset(0, 3.4.w),
//                   )
//                 ]),
//             child: Table(
//               children: <TableRow>[
//                 TableRow(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.only(bottom: 8.w),
//                       child: Text(S.of(context).paymentMethod,
//                           style: Get.textTheme.bodyText1.copyWith(
//                               fontWeight: FontWeight.bold, fontSize: 18.w)),
//                     ),
//                   ],
//                 ),
//                 TableRow(
//                   children: [
//                     Table(
//                       children: _paymentController.cards
//                           .map<TableRow>((e) => TableRow(children: [
//                                 _paymentMethodItem(
//                                     e.type,
//                                     e.number,
//                                     e.id,
//                                     CardUtils.getCardIcon(e.type),
//                                     _selectedPaymentMethod == e.number,
//                                     () => _setPaymentMethod)
//                               ]))
//                           .toList(),
//                     ),
//                   ],
//                 ),
//                 TableRow(children: [
//                   Container(
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         Expanded(
//                           child: InkWell(
//                             onTap: () => Get.to(PaymentMethodScreen(
//                               hasContinueButton: true,
//                               onContinuePressed: (pan) {
//                                 print(pan);
//                                 _setPaymentMethod(pan);
//                                 Get.back();
//                               },
//                             )),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: <Widget>[
//                                 Container(
//                                   margin:
//                                       EdgeInsets.only(right: 10.w, bottom: 8.w),
//                                   width: 60.w,
//                                   height: 40.w,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(8.w),
//                                     color: Colors.white,
//                                     border: Border.symmetric(
//                                         vertical: BorderSide(
//                                             color: Constants.themeGreyDark),
//                                         horizontal: BorderSide(
//                                             color: Constants.themeGreyDark)),
//                                   ),
//                                   child: Icon(Icons.add, size: 25.w),
//                                 ),
//                                 Container(
//                                   height: 40.w,
//                                   child: Text(S.of(context).addCard,
//                                       style: Get.textTheme.bodyText1
//                                           .copyWith(fontSize: 16.w)),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ]),
//               ],
//             )));
//   }

  