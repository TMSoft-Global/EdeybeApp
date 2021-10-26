import 'package:edeybe/controllers/product_controller.dart';
import 'package:edeybe/controllers/search_controller.dart';
import 'package:edeybe/controllers/wishlist_controller.dart';
import 'package:edeybe/screens/checkout_screen/index.dart';
import 'package:edeybe/screens/product_details_screen/product_details_screen.dart';
import 'package:edeybe/screens/wishlist_screen/wishlist_screen.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:edeybe/utils/helper.dart';
import 'package:edeybe/widgets/Shimmer.dart';
import 'package:edeybe/widgets/cart_dialog.dart';
import 'package:edeybe/widgets/empty_list_widget.dart';
import 'package:edeybe/widgets/product_card_landscape.dart';
import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';

class SearchResultWidget extends StatefulWidget {
  final Widget child;
  final Function closeSearch;
  SearchResultWidget({Key key, this.child, this.closeSearch}) : super(key: key);

  @override
  _SearchResultWidgetState createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animation;
  final _searchController = Get.find<SearchController>();
  final _productController = Get.find<ProductController>();
  var wishlistController = Get.find<WishlistController>();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  Animation<Offset> offset;
  final formatCurrency = new NumberFormat.simpleCurrency(name: "");
  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    offset = Tween<Offset>(
      begin: Offset(0.0, 2.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animation,
      curve: Curves.easeIn,
    ));
    _animation.forward();
    // .5.tweenTo(1.0).curved(Curves.easeInOut).animate(_animation),
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _searchController.setListkey(_listKey);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animation.reverse();
    _animation.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Shimmer(
        linearGradient: Constants.shimmerGradient,
        child: Align(
          alignment: Alignment.topCenter,
          child: SlideTransition(
              position: offset,
              child: Container(
                width: Get.width,
                height: (Get.height),
                color: Constants.themeGreyLight,
                child:
                    // Column(children: [
                    AnimatedList(
                        key: _listKey,
                        initialItemCount: _searchController.products != null &&
                                _searchController.products.length > 0
                            ? _searchController.products.length - 1
                            : 1,
                        itemBuilder: (context, index, animation) {
                          if (_searchController.products.isBlank &&
                              _searchController.products.isEmpty &&
                              _searchController.searching.value) {
                            return _loader(animation);
                          } else if (_searchController.queryTxt.value.length >
                                  1 &&
                              _searchController.products != null &&
                              _searchController.products.length < 1 &&
                              !_searchController.searching.value) {
                            if (index == 0)
                              return ListEmptyWidget(
                                  message: S.of(context).productsEmpty,
                                  child: SizedBox.shrink());
                            else
                              return null;
                          } else if (_searchController.queryTxt.value.length <
                                  1 &&
                              _searchController.queryTxt.value.length < 1 &&
                              _searchController.products != null &&
                              _searchController.products.length < 1)
                            return (index == 0)
                                ? Column(
                                    children: <Widget>[
                                      Container(
                                        color: Constants.themeGreyDark
                                            .withOpacity(0.4),
                                        child: ListTile(
                                          dense: true,
                                          title: Text("Browse"),
                                        ),
                                      ),
                                      Divider(
                                        height: 1.w,
                                      ),
                                      Container(
                                        color: Colors.white,
                                        child: ListTile(
                                          dense: true,
                                          title: Text("Women's Collection"),
                                        ),
                                      ),
                                      Divider(
                                        height: 1.w,
                                      ),
                                      Container(
                                        color: Colors.white,
                                        child: ListTile(
                                          dense: true,
                                          title: Text("Top Deals"),
                                        ),
                                      ),
                                      Divider(
                                        height: 1.w,
                                      ),
                                      Container(
                                        color: Colors.white,
                                        child: ListTile(
                                          dense: true,
                                          title: Text("Top New Releases"),
                                        ),
                                      ),
                                      Divider(
                                        height: 1.w,
                                      ),
                                      Container(
                                        color: Colors.white,
                                        child: ListTile(
                                          dense: true,
                                          title: Text("Recommendations"),
                                        ),
                                      ),
                                      Divider(
                                        height: 1.w,
                                      ),
                                    ],
                                  )
                                : null;
                          else {
                            if (index <=
                                (_searchController.products.length - 1)) {
                              var p = _searchController.products[index];
                              return SlideTransition(
                                position: Tween<Offset>(
                                        begin: Offset(
                                            double.parse("${21 + index}"), 0),
                                        end: Offset(0, 0))
                                    .animate(CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.bounceIn,
                                        reverseCurve: Curves.bounceOut)),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 5.w),
                                  child: ProductCardLandscape(
                                    title: p.productName,
                                    image: p.photos[0],
                                    discount: p.discountPrice,
                                    price: p.price,
                                    oldPrice: p.price,
                                    onAddToWishList: () =>
                                        wishlistController.addToWishlist(
                                            p,
                                            ({String title}) => Get.dialog(
                                                  CartDialog(
                                                      title: title,
                                                      type:
                                                          CartItemType.Wishlist,
                                                      onGoForward: () => Get.to(
                                                          WishlistScreen()),
                                                      productTitle:
                                                          _productController
                                                              .productDetail
                                                              .value
                                                              .productName,
                                                      cartTotal: formatCurrency.format(
                                                          wishlistController.wishlistItems.fold(
                                                              0,
                                                              (previousValue,
                                                                      element) =>
                                                                  element
                                                                      .price +
                                                                  previousValue))),
                                                  barrierDismissible: true,
                                                )),
                                    onViewDetails: () {
                                      _productController.setInViewProduct(p);
                                      if (widget.closeSearch != null)
                                        widget.closeSearch();
                                      Get.to(ProductDetailsScreen());
                                    },
                                    isFav: Helper.isFavourite(
                                        p.productId, wishlistController),
                                    rating: 5.0,
                                    raters: 23,
                                  ),
                                ),
                              );
                            }
                          }
                          return null;
                        }),
                //   _searchController.products != null &&
                //           _searchController.products.length > 0
                //       ? ListEmptyWidget(
                //           message: S.of(context).productsEmpty,
                //           child: SizedBox.shrink())
                //       : ListView(
                //           children: <Widget>[
                //             Container(
                //               color: Constants.themeGreyDark.withOpacity(0.4),
                //               child: ListTile(
                //                 dense: true,
                //                 title: Text("Browse"),
                //               ),
                //             ),
                //             Divider(
                //               height: 1.w,
                //             ),
                //             Container(
                //               color: Colors.white,
                //               child: ListTile(
                //                 dense: true,
                //                 title: Text("Women's Collection"),
                //               ),
                //             ),
                //             Divider(
                //               height: 1.w,
                //             ),
                //             Container(
                //               color: Colors.white,
                //               child: ListTile(
                //                 dense: true,
                //                 title: Text("Top Deals"),
                //               ),
                //             ),
                //             Divider(
                //               height: 1.w,
                //             ),
                //             Container(
                //               color: Colors.white,
                //               child: ListTile(
                //                 dense: true,
                //                 title: Text("Top New Releases"),
                //               ),
                //             ),
                //             Divider(
                //               height: 1.w,
                //             ),
                //             Container(
                //               color: Colors.white,
                //               child: ListTile(
                //                 dense: true,
                //                 title: Text("Recommendations"),
                //               ),
                //             ),
                //             Divider(
                //               height: 1.w,
                //             ),
                //           ],
                //         ),
                // ])
              )),
        )));
  }

  Widget _loader(animation) {
    return Column(
      children: List.generate(
          10,
          (index) => SlideTransition(
                position: Tween<Offset>(
                        begin: Offset(double.parse("${21 + index}"), 0),
                        end: Offset(0, 0))
                    .animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.bounceIn,
                        reverseCurve: Curves.bounceOut)),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5.w),
                  child: ProductCardLandscape(
                    isLoading: true,
                    title: '',
                    image: null,
                    discount: 0,
                    price: 0,
                    oldPrice: 0,
                    onAddToWishList: null,
                    onViewDetails: null,
                    isFav: false,
                    rating: 0.0,
                    raters: 0,
                  ),
                ),
              )),
    );
  }
}
