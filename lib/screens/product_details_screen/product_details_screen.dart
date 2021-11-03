import 'package:edeybe/controllers/cart_controller.dart';
import 'package:edeybe/controllers/product_controller.dart';
import 'package:edeybe/controllers/user_controller.dart';
import 'package:edeybe/controllers/wishlist_controller.dart';
import 'package:edeybe/models/productModel.dart';
import 'package:edeybe/screens/auth_screen/login_screen.dart';
import 'package:edeybe/screens/checkout_screen/checkout_screen.dart';
import 'package:edeybe/screens/product_details_screen/product_details_bottom_bar/bottom_bar.dart';
import 'package:edeybe/screens/products_view/products.dart';
// import 'package:edeybe/screens/review_screen/review_screen.dart';
import 'package:edeybe/screens/wishlist_screen/wishlist_screen.dart';
import 'package:edeybe/services/server_operation.dart';
import 'package:edeybe/utils/cart_item_type.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:edeybe/utils/helper.dart';
import 'package:edeybe/variants/variantsImage.dart';
import 'package:edeybe/widgets/Shimmer.dart';
import 'package:edeybe/widgets/capsule.dart';
import 'package:edeybe/widgets/cart_dialog.dart';
import 'package:edeybe/widgets/custom_dialog.dart';
import 'package:edeybe/widgets/custom_divider.dart';
import 'package:edeybe/widgets/money_widget.dart';
import 'package:edeybe/widgets/post_gallery.dart';
import 'package:edeybe/widgets/products_grid.dart';
// import 'package:edeybe/widgets/start_rating.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';
import 'package:intl/intl.dart';
import 'package:flutter/rendering.dart';

import 'Untitled-1.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductDetailsScreen({Key key}) : super(key: key);
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  _ProductDetailsScreenState();
  int quanity;
  final formatCurrency = new NumberFormat.simpleCurrency(name: "");
  final _productController = Get.find<ProductController>();
  final _cartController = Get.find<CartController>();
  final _wishlistController = Get.find<WishlistController>();
  final _userCtrler = Get.find<UserController>();
  String _deliverto;
  dynamic variantAmount = 0;
  dynamic discountedVarianAmount = 0;
  String variantSelected;
  String variantID;
  List<Images> imgs = [];
  List<Photos> variantImg = [];
  bool hasVariant = false;
  bool selectedVariant = false;

// state functions
  void _setDeliveryLocation(text) {
    setState(() {
      _deliverto = text;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _productController.getProductVariantByID(
          _productController.productDetail.value.productId);
    });
    // _productController
    //     .getProductbyId(_productController.product.value.sku));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).details,
          style: TextStyle(fontSize: 20.w),
        ),
        centerTitle: false,
        brightness: Brightness.dark,
        actions: <Widget>[
          IconButton(
            iconSize: 25.w,
            icon: Icon(
              Helper.isFavourite(
                      _productController.productDetail.value.productId,
                      _wishlistController)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Helper.isFavourite(
                      _productController.productDetail.value.productId,
                      _wishlistController)
                  ? Constants.ratingBG
                  : Colors.white,
            ),
            onPressed: () {
              _wishlistController.addToWishlist(
                  _productController.productDetail.value,
                  ({String title}) => Get.dialog(
                        CartDialog(
                            title: title,
                            type: CartItemType.Wishlist,
                            onGoForward: () => Get.to(WishlistScreen()),
                            productTitle: _productController
                                .productDetail.value.productName,
                            cartTotal: formatCurrency.format(
                                _wishlistController.wishlistItems.fold(
                                    0,
                                    (previousValue, element) =>
                                        element.price + previousValue))),
                        barrierDismissible: true,
                      ));
            },
          ),
          // IconButton(
          //   iconSize: 25.w,
          //   icon: Icon(Icons.share),
          //   onPressed: () {

          //   },
          // ),
        ],
      ),
      bottomNavigationBar: Obx(() => ProductDetailsBottomBar(
            onSetQuantity: (value) {
              setState(() {
                _productController.setQuantity(value);
              });
            },
            onAddToCart: _productController.productDetail != null
                ? () {
                    _cartController
                        .addToCart(_productController.productDetail?.value, (
                            {String title}) {
                      if (Get.isDialogOpen) {
                        Get.back();
                      }
                      Get.dialog(
                        CartDialog(
                            title: title,
                            type: CartItemType.Cart,
                            onGoForward: () => _userCtrler.isLoggedIn()
                                ? Get.off(CheckoutScreen())
                                : Get.offAll(LoginScreen()),
                            productTitle: _productController
                                .productDetail.value.productName,
                            cartTotal: formatCurrency.format(
                                _cartController.cartItems.fold(
                                    0,
                                    (previousValue, element) =>
                                        discountedVarianAmount != 0
                                            ? discountedVarianAmount
                                            : variantAmount != 0
                                                ? variantAmount
                                                : element.hasDiscount
                                                    ? element.discountPrice
                                                    : element.price +
                                                        previousValue))),
                        barrierDismissible: true,
                      );
                    }, variantID: variantID);
                  }
                : null,
            quantity: _productController.productDetail.value?.quantity,
          )),
      body: Shimmer(
          linearGradient: Constants.shimmerGradient,
          child: GetBuilder<ProductController>(
            builder: (_productStl) => SingleChildScrollView(
                // controller: controller,
                child: Padding(
              padding: EdgeInsets.only(bottom: 8.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.w),
                    height: 260.h,
                    width: Get.width.w,
                    color: Constants.themeGreyLight,
                    child: _productStl.productDetail.value.photos != null
                        ? Container(
                            height: 180.w,
                            width: Get.width.w,
                            child: imageCarousel(
                              context: context,
                              images: variantImg.isEmpty
                                  ? _productStl.productDetail.value.photos
                                  : variantImg,
                            )
                            //     ListView.builder(
                            // scrollDirection: Axis.horizontal,
                            // itemCount: _productStl
                            //     .productDetail.value.photos.length,
                            // itemBuilder: (_, i) {
                            //   return Container(
                            //     width:
                            //         MediaQuery.of(context).size.width - 10,
                            //     child: Image.network(
                            //       _productStl
                            //           .productDetail.value.photos[i].sm,
                            //       fit: BoxFit.fitWidth,
                            //     ),
                            //   );
                            // }),
                            )
                        // CarouselSlider(
                        //     showDots: false,
                        //     itemCount: _productController
                        //         .productDetail.value.photos?.length,
                        //     itemBuilder: (context, ind) => Container(
                        //       padding: EdgeInsets.all(10.w),
                        //       margin: EdgeInsets.only(right: 10.w),
                        //       width: Get.width.w,
                        //       decoration: BoxDecoration(
                        //           color: Colors.white,
                        //           borderRadius: BorderRadius.circular(12.w)),
                        //       child: GestureDetector(
                        //         onTap: () => Get.dialog(PostGallery(
                        //           images:
                        //               _productStl.productDetail.value.photos,
                        //           currentImage: ind,
                        //         )),
                        //         child: Image(
                        //           image: CachedNetworkImageProvider(
                        //             _productStl.productDetail.value.photos[ind]
                        //                     .sm ??
                        //                 "",
                        //           ),
                        //           // alignment: Alignment.center,
                        //           fit: BoxFit.contain,
                        //         ),
                        //       ),
                        //     ),
                        //   )
                        : SizedBox.shrink(),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20.w, right: 40.w, top: 5.w),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _productStl.productDetail.value.productName ?? "".tr,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 15.w, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${S.of(context).brand} : ${_productStl.productDetail.value.brand}"
                                    .tr,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 13.w,
                                    fontWeight: FontWeight.w600),
                                overflow: TextOverflow.ellipsis,
                              ),
                              MoneyWidget(
                                offset: Offset(3, 3.5),
                                scalefactor: 1,
                                fontWeight: FontWeight.w800,
                                currencyFirst: true,
                                children: [
                                  TextSpan(
                                    text: formatCurrency.format(
                                      discountedVarianAmount == 0 ||
                                              discountedVarianAmount == null
                                          ? _productController.productDetail
                                                  .value.hasDiscount
                                              ? _productController.productDetail
                                                  .value.discountPrice
                                              : _productController
                                                  .productDetail.value.price
                                          : discountedVarianAmount,
                                    ),
                                    style: TextStyle(
                                        fontSize: 17.w,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              if (_productStl.productDetail.value.hasDiscount)
                                MoneyWidget(
                                    offset: Offset(3, 3.5),
                                    scalefactor: 1,
                                    fontWeight: FontWeight.w800,
                                    currencyFirst: true,
                                    children: [
                                      TextSpan(
                                        text: formatCurrency.format(
                                          variantAmount == 0
                                              ? _productController
                                                  .productDetail.value.price
                                              : variantAmount,
                                        ),
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 13.w,
                                            color: Colors.grey[400],
                                            fontWeight: FontWeight.w600),
                                      )
                                    ]),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 15.w, left: 10.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                // StarRating(
                                //   onRatingChanged: (d) => Get.to(ReviewScreen(
                                //     reviews: [
                                //       {
                                //         "name": "Ella White",
                                //         "rating": 4.5,
                                //         "moment": "Today",
                                //         "review": "Great quality well spent!"
                                //       },
                                //       {
                                //         "name": "Jack Anderson",
                                //         "rating": 4.0,
                                //         "moment": "Yesterday",
                                //         "review": ""
                                //       },
                                //       {
                                //         "name": "Lilly Williams",
                                //         "rating": 3.5,
                                //         "moment": "Two weeks ago",
                                //         "review": "Fresh!"
                                //       },
                                //       {
                                //         "name": "Jeana Varzar",
                                //         "rating": 4.0,
                                //         "moment": "Two months ago",
                                //         "review":
                                //             "Loved it, pirce little high but worth it."
                                //       }
                                //     ],
                                //     product: _productStl.product.value,
                                //   )),
                                //   starCount: 5,
                                //   color: Constants.ratingBG,
                                //   allowHalfRating: true,
                                //   rating: 3.3,
                                //   size: 15.w,
                                // ),
                                // Container(
                                //   padding: EdgeInsets.all(5.w),
                                //   child: Text(
                                //     "(18 ${S.of(context).rating})",
                                //     maxLines: 2,
                                //     textAlign: TextAlign.center,
                                //     style: TextStyle(
                                //         color: Colors.grey[400],
                                //         fontSize: 13.w,
                                //         fontWeight: FontWeight.normal),
                                //     overflow: TextOverflow.ellipsis,
                                //   ),
                                // ),
                                if (_productStl.productDetail.value.hasDiscount)
                                  CapsuleWiget(
                                    borderRadius: 4.w,
                                    padding: EdgeInsets.fromLTRB(
                                        10.w, 2.w, 10.w, 2.w),
                                    color: Get.theme.primaryColor
                                        .withOpacity(0.2.w),
                                    borderColor: Colors.transparent,
                                    child: Text(
                                      "${_productStl.productDetail.value.percentageDiscount} % ${S.of(context).off}",
                                      style: Get.textTheme.bodyText1.copyWith(
                                          color: Get.theme.primaryColor,
                                          fontSize: 13.w),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20.w, 5.w, 20.w, 5.w),
                    child: CustomDivider(
                      color: Colors.grey[500],
                    ),
                  ),
                  // if (_productStl.product.value.configurableOptions != null)
                  //   Column(
                  //   children: _productController
                  //       .product.value.configurableOptions
                  //       .map(
                  //         (e) => Container(
                  //           padding:
                  //               EdgeInsets.fromLTRB(20.w, 0.w, 20.w, 0.w),
                  //           child: Column(
                  //             children: <Widget>[
                  //               Row(
                  //                 mainAxisAlignment: MainAxisAlignment.start,
                  //                 children: <Widget>[
                  //                   Text(
                  //                     e.label,
                  //                     style: TextStyle(
                  //                         color: Colors.grey[400],
                  //                         fontSize: 13.w,
                  //                         fontWeight: FontWeight.normal),
                  //                     overflow: TextOverflow.ellipsis,
                  //                   ),
                  //                   Padding(
                  //                     padding: EdgeInsets.all(8.w),
                  //                     child: Text(
                  //                       e.values[0].label,
                  //                       style: TextStyle(
                  //                           fontSize: 13.w,
                  //                           fontWeight: FontWeight.bold),
                  //                       overflow: TextOverflow.ellipsis,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //               _buildCapsuleList(e.values, 0),
                  //             ],
                  //           ),
                  //         ),
                  //       )
                  //       .toList(),
                  // ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Availability",
                                  style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 11,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  _productController
                                              .productDetail.value.status ==
                                          null
                                      ? "_"
                                      : _productController.productDetail.value
                                              .status.instock
                                          ? "In stock"
                                          : "Sold out",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Model",
                                  style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 11,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  "-----------",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "SKU",
                                  style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 11,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  _productStl.productDetail.value.productId ??
                                      "",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  CustomDivider(
                    height: 30.h,
                    thickness: 30.h,
                    color: Colors.grey[200],
                  ),
                  _buildVarientProduct(),
                  CustomDivider(
                    height: 60.h,
                    thickness: 60.h,
                    color: Colors.grey[200],
                  ),
                  _buildDeliveryWidget(),
                  CustomDivider(
                    height: 5.h,
                    thickness: 5.h,
                    color: Colors.grey[200],
                  ),
                  _buildProductAndSpecsDetails(),
                  Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.w),
                              child: Text('${S.of(context).sellerInfo}'),
                            ),
                          ],
                        ),
                        if (_productStl.productDetail.value.merchantDetails !=
                            null)
                          ListTile(
                            tileColor: Colors.white,
                            title: Text(
                              "${_productStl.productDetail.value.merchantDetails.companyName}"
                                  .tr,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 13.w, fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15.w,
                            ),
                            onTap: () => Get.to(ProductsView(
                                type: _productStl.productDetail.value
                                            .merchantDetails.companyName ==
                                        null
                                    ? "_"
                                    : _productStl.productDetail.value
                                        .merchantDetails.companyName)),
                          )
                      ],
                    ),
                  ),
                  if (_productStl.productDetail.value.relatedItems != null &&
                      _productController
                          .productDetail.value.relatedItems.isNotEmpty)
                    _buildRelatedProducts(),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: <Widget>[
                  //     Padding(
                  //       padding: EdgeInsets.only(
                  //           bottom: 8.w, top: 8.w, left: 10.w, right: 10.w),
                  //       child: Text(
                  //           S.of(context).frequentlyBoughttogether.toUpperCase()),
                  //     ),
                  //     OutlinedButton(
                  //       style: OutlinedButton.styleFrom(
                  //           shape: RoundedRectangleBorder(
                  //         side: BorderSide(color: Colors.transparent),
                  //       )),
                  //       onPressed: () {},
                  //       child: Text(
                  //         S.current.viewAll,
                  //         style: Get.textTheme.bodyText1
                  //             .copyWith(color: Constants.mainColor),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // ProductsGrid(
                  //   products: products,
                  // ),
                ],
              ),
            )),
          )),
    );
  }

  // build delivery offer options
  Widget _buildDeliveryOffers(String icon, {String label}) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 10.0.w, bottom: 10.0.w),
      width: (Get.width / 2.3 - 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SvgPicture.asset(
            icon,
            width: 24.w,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w),
            child: Text(
              label,
              style: TextStyle(fontSize: 13.w),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  // build capsule list
  Widget _buildCapsuleList(List capsules, int active) {
    return Container(
      height: 30.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: capsules.length,
        itemBuilder: (BuildContext context, int i) {
          var capsule = capsules[i];
          return CapsuleWiget(
            onPressed: () {},
            text: capsule.label,
            borderColor: active == i ? Get.theme.primaryColor : null,
          );
        },
      ),
    );
  }

  // build delivery widget
  Widget _buildDeliveryWidget() {
    return new Container(
      padding: EdgeInsets.fromLTRB(20.w, 5.w, 20.w, 5.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              // Text(
              //   "${S.of(context).deliverTo}:",
              //   style: TextStyle(
              //       color: Colors.grey[400],
              //       fontSize: 11.w,
              //       fontWeight: FontWeight.normal),
              // ),
              // Container(
              //   height: 35.w,
              //   padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 5.w),
              //   margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 5.w),
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       border: Border.all(
              //           width: 1.w, color: Colors.grey.withOpacity(0.2)),
              //       borderRadius: BorderRadius.circular(5.0)),
              //   child: DropdownButtonHideUnderline(
              //     child: DropdownButton(
              //       value: _deliverto ?? "0",
              //       isDense: true,
              //       icon: Icon(Icons.keyboard_arrow_down),
              //       onChanged: _setDeliveryLocation,
              //       items: <DropdownMenuItem>[
              //         DropdownMenuItem(
              //           value: "0",
              //           child: Text(
              //             "Dubai",
              //             textAlign: TextAlign.center,
              //             style: Get.textTheme.bodyText1.copyWith(
              //                 color: Get.theme.primaryColor,
              //                 fontSize: 13.w,
              //                 fontWeight: FontWeight.bold),
              //           ),
              //         ),
              //         DropdownMenuItem(
              //           child: Text(
              //             "Ghoboar",
              //             textAlign: TextAlign.center,
              //             style: Get.textTheme.bodyText1.copyWith(
              //                 fontSize: 13.w, fontWeight: FontWeight.bold),
              //           ),
              //         ),
              //         DropdownMenuItem(
              //           child: Text(
              //             "Abu Dabi",
              //             textAlign: TextAlign.center,
              //             style: Get.textTheme.bodyText1.copyWith(
              //                 fontSize: 13.w, fontWeight: FontWeight.bold),
              //           ),
              //         ),
              //         DropdownMenuItem(
              //           child: Text(
              //             "Riyadh",
              //             textAlign: TextAlign.center,
              //             style: Get.textTheme.bodyText1.copyWith(
              //                 fontSize: 13.w, fontWeight: FontWeight.bold),
              //           ),
              //         ),
              //         DropdownMenuItem(
              //           child: Text(
              //             "Macca",
              //             textAlign: TextAlign.center,
              //             style: Get.textTheme.bodyText1.copyWith(
              //                 fontSize: 13.w, fontWeight: FontWeight.bold),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Text(
                  "Delivery in",
                  style:
                      TextStyle(fontSize: 12.w, fontWeight: FontWeight.normal),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(0.0),
                child: Text(
                  "3 - 4 days",
                  style: TextStyle(
                      color: Get.theme.primaryColor,
                      fontSize: 12.w,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
          CustomDivider(
            color: Colors.grey[500],
          ),
          Wrap(
            runSpacing: 0,
            spacing: 10,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: <Widget>[
              _buildDeliveryOffers('assets/icons/warranty.svg',
                  label: "Genuine & Warranted"),
              // _buildDeliveryOffers('assets/icons/cash-on-delivery.svg',
              //     label: "Cash On Delivery"),
              // _buildDeliveryOffers('assets/icons/truck.svg',
              //     label: "Free Shipping"),
              _buildDeliveryOffers('assets/icons/return.svg',
                  label: "Free & Easy Returns")
            ],
          ),
        ],
      ),
    );
  }

  // product details and specifications builder
  Widget _buildProductAndSpecsDetails() {
    Map<String, String> specs = {
      "Colour": "Aura Glow",
      "Display Type": "AMOLED",
      "Screen Size": "6.8 inch",
      "Internal Memory": "512 GB",
      "Product Weight": "196 g",
      "Battery Capacity": "4300 mAh",
      "RAM": "12 GB",
      "Operating System": "Android",
      "Processor Speed": "2.73 GHz",
      "SIM Count": "Single SIM",
      "Model Number": "Note10plusglow",
      "Model Name": "Note 10 Plus"
    };
    List<TableRow> rows = [];
    specs.forEach((key, value) {
      rows.add(TableRow(children: <Widget>[
        Container(
          color: Colors.grey[100],
          padding: EdgeInsets.all(8.w),
          child: Text(
            key,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey[400]),
          ),
        ),
        Container(
            padding: EdgeInsets.all(8.w),
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[400]),
            ))
      ]));
    });
    return DefaultTabController(
        length: 1,
        child: Container(
          color: Colors.white,
          constraints:
              BoxConstraints(minHeight: 100.w, maxHeight: Get.height / 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TabBar(
                indicatorColor: Get.theme.primaryColor,
                labelColor: Get.theme.primaryColor,
                unselectedLabelColor: Get.textTheme.bodyText1.color,
                tabs: <Widget>[
                  Tab(text: S.of(context).productDetails.toUpperCase()),
                  // Tab(text: S.of(context).specifications.toUpperCase())
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Html(
                              data: _productController
                                      .productDetail.value.description ??
                                  "",
                            ),
                          ],
                        ),
                      ),
                    ),
                    // SingleChildScrollView(
                    //   child: Container(
                    //     padding: EdgeInsets.all(20.w),
                    //     child: Table(
                    //       border: TableBorder.all(color: Colors.grey[400]),
                    //       children: rows,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildRelatedProducts() {
    return GetBuilder<ProductController>(builder: (_p) {
      return Container(
        child: Wrap(
          children: [
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      bottom: 8.w, top: 8.w, left: 10.w, right: 10.w),
                  alignment: Alignment.bottomLeft,
                  child: Text(S.of(context).relatedProducts.toUpperCase()),
                ),
              ],
            ),
            ProductsGrid(
              scrollDirection: Axis.horizontal,
              products: _p.productDetail.value.relatedItems,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildVarientProduct() {
    return GetBuilder<ProductController>(builder: (_p) {
      // print(_p.product.value.productId);
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.w),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Constants.boxShadow,
                blurRadius: 3.4.w,
                offset: Offset(0, 3.4.w),
              )
            ]),
        child: Wrap(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text("Variants", style: TextStyle(fontSize: 20))),
            CustomDivider(),
            if (_productController.productDetail.value.hasVariants &&
                _productController.productDetail.value.variants.length > 0)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() => _setPrice(null, 0));
                              variantImg =
                                  _productController.productDetail.value.photos;
                            },
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(_productController
                                  .productDetail.value.photos[0].sm),
                            ),
                          ),
                        ),
                        for (int x = 0;
                            x <
                                _productController
                                    .productDetail.value.variants.length;
                            x++)
                          if (_productController
                                  .productDetail.value.variants[x].images !=
                              null)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  variantID = _productController.productDetail
                                      .value.variants[x].variantId;
                                  variantImg = _productController
                                      .productDetail.value.variants[x].images;
                                });

                                _setPrice(
                                    _productController
                                        .productDetail.value.variants[x].price,
                                    x);

                                setState(() {
                                  _productController.productDetail.value
                                    .variants.forEach((element) =>element.variantSelected=false);
                                    _productController
                                        .productDetail.value.variants[x].variantSelected = true;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: _productController
                                                    .productDetail
                                                    .value
                                                    .variants[x]
                                                    .variantSelected
                                                ? Get.theme.primaryColor
                                                : Colors.transparent),
                                        shape: BoxShape.circle,
                                      ),
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage: NetworkImage(
                                            _productController
                                                .productDetail
                                                .value
                                                .variants[x]
                                                .images[0]
                                                .sm),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text("Type: ${_productController
                                        //               .productDetail.value.variants[x].variantName}"),
                                        // Text("Include", style: TextStyle(fontSize: 9),),
                                        for (var x in _productController
                                            .productDetail
                                            .value
                                            .variants[x]
                                            .variantAttributes) ...[
                                          Text(
                                            "${x.sId}: ${x.value}",
                                            style: TextStyle(fontSize: 9),
                                          ),
                                          // Text("$size"),
                                        ]
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                        // varientButton(
                        //   onTap: () {
                        //     print(x);
                        //     // _setPrice(
                        //     //     _productController
                        //     //         .productDetail.value.variants[x].price,
                        //     //     x);
                        //   },
                        //   index: x,
                        // id: _productController
                        //     .productDetail.value.variants[x].variantId,
                        //   attribute: _productController
                        //       .productDetail.value.variants[x].variantAttributes,
                        //   type: _productController
                        //       .productDetail.value.variants[x].variantName,
                        //   image:
                        //       "${_productController.productDetail.value.variants[x]}",
                        // )
                      ]),
                ),
              )
          ],
        ),
      );
    });
  }

  void _setVariant(value) {
    setState(() => variantSelected = value);
  }

  ValueChanged<String> _valueChangedHandler() {
    return (value) => setState(() => variantSelected = value);
  }

  void _setPrice(value, int x) {
    print(value);
    if (_productController.productDetail.value.hasVariants) {
      if (value == null || value == "null") {
        setState(() {
          variantAmount = _productController.productDetail.value.price;
          discountedVarianAmount = _productController
                      .productDetail.value.variants[x].discountPrice ==
                  null
              ? _productController.productDetail.value.discountPrice
              : _productController
                  .productDetail.value.variants[x].discountPrice;
          variantID ==
              _productController.productDetail.value.variants[x].variantId;
        });
        print("====$discountedVarianAmount");
      } else {
        setState(() {
          variantID =
              _productController.productDetail.value.variants[x].variantId;
          variantAmount = value;
          discountedVarianAmount = _productController
                  .productDetail.value.variants[x].hasDiscount
              ? _productController.productDetail.value.variants[x].discountPrice
              : _productController.productDetail.value.variants[x].price;
          print(discountedVarianAmount);
          // print(variantAmount);
        });
      }
    }
  }

//   Widget varientButton({
//     String type,
//     var attribute,
//     String id,
//     int index,
//     var image,
//     Function(String) onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap(type),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 7),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       CircleAvatar(
//                         radius: 40,
//                         backgroundImage: NetworkImage(_productController
//                             .productDetail.value.variants[index].images[0].sm),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           for (var x in _productController.productDetail.value
//                               .variants[index].variantAttributes) ...[
//                             Text(
//                               "${x.sId}: ${x.value}",
//                               style: TextStyle(fontSize: 9),
//                             ),
//                           ]
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                     alignment: Alignment.centerRight,
//                     child: Radio(
//                       toggleable: true,
//                       activeColor: Get.theme.primaryColor,
//                       groupValue: variantSelected,
//                       onChanged: (val) {
//                         setState(() {
//                           variantID = _productController
//                               .productDetail.value.variants[index].variantId;
//                           // print(_productController
//                           //     .productDetail.value.variants[index].price);
//                         });
//                         // ;

//                         _setPrice(
//                             _productController
//                                 .productDetail.value.variants[index].price,
//                             index);
//                       },
//                       value: id,
//                     ))
//               ],
//             ),
//           ),
//           CustomDivider()
//         ],
//       ),
//     );
//   }
}
