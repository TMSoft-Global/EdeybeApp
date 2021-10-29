import 'package:edeybe/controllers/cart_controller.dart';
import 'package:edeybe/controllers/search_controller.dart';
import 'package:edeybe/controllers/user_controller.dart';
import 'package:edeybe/controllers/wishlist_controller.dart';
import 'package:edeybe/models/productModel.dart';
import 'package:edeybe/screens/address_screen/address_screen.dart';
import 'package:edeybe/screens/auth_screen/login_screen.dart';
import 'package:edeybe/screens/checkout_screen/checkout_screen.dart';
import 'package:edeybe/screens/home_screen/cart_tab/cart_tab_bottom_bar/bottom_bar.dart';
import 'package:edeybe/screens/home_screen/index.dart';
import 'package:edeybe/screens/wishlist_screen/wishlist_screen.dart';
import 'package:edeybe/utils/Debouncer.dart';
import 'package:edeybe/utils/cart_item_type.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:edeybe/utils/helper.dart';
import 'package:edeybe/widgets/ErrorBoundary.dart';
import 'package:edeybe/widgets/Shimmer.dart';
import 'package:edeybe/widgets/cart_dialog.dart';
import 'package:edeybe/widgets/cart_item.dart';
import 'package:edeybe/widgets/custom_dialog.dart';
import 'package:edeybe/widgets/empty_list_widget.dart';
import 'package:edeybe/widgets/money_widget.dart';
import 'package:edeybe/widgets/search_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';
import 'package:intl/intl.dart';

class CartScreenTab extends StatefulWidget {
  CartScreenTab({Key key}) : super(key: key);

  @override
  _CartScreenTabState createState() => _CartScreenTabState();
}

class _CartScreenTabState extends State<CartScreenTab>
    with TickerProviderStateMixin {
  // variables
  TextEditingController _couponCtrl = TextEditingController();
  final formatCurrency = new NumberFormat.simpleCurrency(name: "");
  final _wishlistController = Get.put(WishlistController());
  final _cartController = Get.put(CartController());
  final searchController = Get.find<SearchController>();
  final _userController = Get.find<UserController>();

  final _searchFieldController = TextEditingController();
  String _deliverto;
  List items = [0, 1, 3];
  bool showSearch = false;
  Debouncer debounce = Debouncer();
  AnimationController _animationController;
  FocusNode _focus = new FocusNode();
  Animation _animation;
  AnimationController controller;
  Animation<double> animation;
// state functions
  void _setDeliveryLocation(text) {
    setState(() {
      _deliverto = text;
    });
  }

  @override
  void initState() {
    super.initState();
    // _userController.getDefaultCart();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   _cartController.getCartITems();
    //   _wishlistController.getWishlist();
    // });
    _animationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _animation = IntTween(begin: 5, end: 3).animate(_animationController);
    controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(controller);
    _animation.addListener(() => setState(() {}));
    // _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _animationController.dispose();
    controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  // build card items i.e. wishlist , selected items
  Widget _buildCartItem(CartItemType type, List<ProductModel> products) {
    return Column(
        children: <Widget>[
      if (type == CartItemType.Wishlist)
        Container(
            width: Get.width,
            child: Container(
                child: Text(S.of(context).myWishlist,
                    style: Get.textTheme.bodyText1.copyWith(
                        fontSize: 18.w, fontWeight: FontWeight.bold))),
            padding: EdgeInsets.fromLTRB(20.w, 10.w, 20.w, 10.w),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.grey.withOpacity(.1.w), width: 5.w),
                    top: BorderSide(
                        color: Colors.grey.withOpacity(.1.w), width: 5.w))))
    ]
          ..addAll(products // <-- should be a list of user selected items
              .map<Widget>((e) => CartItem(
                    // index: e.variants[0].,
                    // variantId:e.discountPrice
                    product: e,
                    type: type,
                    onRemovePressed: () => Get.dialog(CustomDialog(
                      title: S.of(context).removeItem,
                      content: S.of(context).removeItemMessage,
                      confrimPressed: () {
                        type == CartItemType.Wishlist
                            ? _wishlistController.removeFromWishlist(
                                products.indexWhere((element) =>
                                    element.productId == e.productId),
                              )
                            : _cartController.removeFromCart(
                                products.indexWhere((element) =>
                                    element.productId == e.productId),
                              );
                        Get.back();
                      },
                      cancelText: S.of(context).no,
                      confrimText: S.of(context).yes,
                    )),
                    onDecreaseQunatity: e.quantity > 1
                        ? () => type == CartItemType.Wishlist
                            ? _wishlistController.setQuantity(
                                products.indexWhere((element) =>
                                    element.productId == e.productId),
                                -1 + (e.quantity ?? 1))
                            : _cartController.setQuantity(
                                products.indexWhere((element) =>
                                    element.productId == e.productId),
                                -1 + (e.quantity ?? 1),
                                e.productId,
                                variantID: e.selectedVariant)
                        : () {},
                    onIncreaseQunatity: () => type == CartItemType.Wishlist
                        ? _wishlistController.setQuantity(
                            products.indexWhere(
                                (element) => element.productId == e.productId),
                            1 + (e.quantity ?? 1))
                        : _cartController.setQuantity(
                            products.indexWhere(
                                (element) => element.productId == e.productId),
                            1 + (e.quantity ?? 1),
                            e.productId,
                            variantID: e.selectedVariant,
                          ),
                    onMovePressed: type == CartItemType.Wishlist
                        ? () {
                            _wishlistController.moveToCart(
                                products.indexWhere((element) =>
                                    element.productId == e.productId),
                                ({String title}) {
                              Get.dialog(
                                CartDialog(
                                    title: title,
                                    onGoForward: () => Get.to(CheckoutScreen()),
                                    productTitle: e.productName,
                                    cartTotal: formatCurrency.format(
                                        _cartController.cartItems.fold(
                                            0,
                                            (previousValue, element) =>
                                                element.price +
                                                previousValue))),
                                barrierDismissible: true,
                              );
                            });
                          }
                        : () {
                            _cartController.moveToWishlist(
                                products.indexWhere((element) =>
                                    element.productName == e.productName),
                                ({String title}) => Get.dialog(CartDialog(
                                    title: title,
                                    type: CartItemType.Wishlist,
                                    onGoForward: () => (navigator.canPop())
                                        ? Get.off(WishlistScreen())
                                        : Get.to(WishlistScreen()),
                                    productTitle: e.productName,
                                    cartTotal: formatCurrency.format(
                                        _wishlistController.wishlistItems.fold(
                                            0,
                                            (previousValue, element) =>
                                                element.variants[0].price +
                                                previousValue)))));
                            Get.dialog(
                              CartDialog(
                                  type: CartItemType.Wishlist,
                                  onGoForward: () => Get.to(WishlistScreen()),
                                  productTitle: e.productName,
                                  cartTotal: formatCurrency.format(
                                      _wishlistController.wishlistItems.fold(
                                          0,
                                          (previousValue, element) =>
                                              element.price + previousValue))),
                              barrierDismissible: true,
                            );
                          },
                  ))
              .toList())
          ..add(products != null && products.length < 1
              ? Center(
                  child: ListEmptyWidget(
                      message: type == CartItemType.Wishlist
                          ? S.of(context).wishlistEmpty
                          : S.of(context).cartEmpty,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Get.theme.primaryColor),
                              borderRadius: BorderRadius.circular(4.w)),
                        ),
                        child: Text(
                          "${S.of(context).letsGoShopping}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: Get.theme.primaryColor, fontSize: 15.w),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeIndex(
                                        indexPage: 0,
                                      )));
                        },
                      )),
                )
              : SizedBox.shrink()));
  }

  // build cart item total widget
  Widget get _itemTotal {
    return Container(
      decoration: BoxDecoration(
          color: Get.theme.primaryColor.withOpacity(.2.w),
          border: Border(
              bottom:
                  BorderSide(width: 1, color: Colors.grey.withOpacity(.2.w)))),
      child: Column(
        children: <Widget>[
          // Container(
          //   height: 47.w,
          //   margin: EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 5.0.w),
          //   decoration: BoxDecoration(
          //       color: Colors.white,
          //       border: Border.all(
          //           width: 1.w, color: Colors.grey.withOpacity(.2.w))),
          //   child: Center(
          //     child: TextField(
          //       style: TextStyle(fontSize: 14.w),
          //       decoration: InputDecoration(
          //           hintText: S.of(context).enterCouponOrGiftCard,
          //           floatingLabelBehavior: FloatingLabelBehavior.never,
          //           border: InputBorder.none,
          //           suffixIcon: Container(
          //             padding: EdgeInsets.symmetric(
          //                 vertical: 11.w, horizontal: 10.w),
          //             color: Get.theme.primaryColor.withOpacity(0.2),
          //             child: InkWell(
          //                 onTap: _couponCtrl.text.length > 4
          //                     ? () {
          //                         _cartController.applyCoupon(_couponCtrl.text);
          //                       }
          //                     : null,
          //                 splashColor: Get.theme.primaryColor.withOpacity(0.2),
          //                 child: Text(
          //                   S.of(context).apply.toUpperCase(),
          //                   textAlign: TextAlign.center,
          //                   style: Get.textTheme.bodyText1.copyWith(
          //                       color: Get.theme.primaryColor,
          //                       fontSize: 14.w,
          //                       fontWeight: FontWeight.bold),
          //                 )),
          //           ),
          //           contentPadding: EdgeInsets.all(10.w)),
          //       controller: _couponCtrl,
          //     ),
          //   ),
          // ),
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        S.of(context).subtotal,
                        style: Get.textTheme.bodyText1.copyWith(
                            fontSize: 11.w, fontWeight: FontWeight.bold),
                      ),
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    ),
                    Text(
                      "${_cartController.cartItems.length} " +
                          S.of(context).items,
                      style: Get.textTheme.bodyText1.copyWith(
                          fontSize: 11.w, fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
              Container(
                child: MoneyWidget(
                  offset: Offset(3, 0),
                  scalefactor: 0.8,
                  fontSize: 11.w,
                  fontWeight: FontWeight.w800,
                  children: [
                    TextSpan(
                      text:
                          // ignore: lines_longer_than_80_chars
                          "${formatCurrency.format(_cartController.cartItems.fold(0, (previousValue, element) => previousValue + (element.hasDiscount ? element.discountPrice : element.price) * (element.quantity ?? 1.00)))}",
                      style: Get.textTheme.bodyText1.copyWith(
                          fontSize: 11.w,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                    ),
                  ],
                ),
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
              ),
            ],
          ),
          Padding(
            padding:
                EdgeInsets.only(left: 20.w, right: 20.w, bottom: 2.w, top: 5.w),
            child: Divider(
              thickness: 2.w,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              bottom: 10.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(S.of(context).total,
                      style: Get.textTheme.bodyText1.copyWith(
                          fontSize: 17.w, fontWeight: FontWeight.bold)),
                ),
                Container(
                    child: MoneyWidget(
                  offset: Offset(3, 3),
                  scalefactor: 1,
                  fontWeight: FontWeight.w800,
                  children: [
                    TextSpan(
                      text:
                          // ignore: lines_longer_than_80_chars
                          "${formatCurrency.format(_cartController.cartItems.fold(0, (previousValue, element) => previousValue + (double.parse(_cartController.cartCost.total)) * (element.quantity ?? 1.00)))}",
                      style: Get.textTheme.bodyText1.copyWith(
                          fontSize: 17.w,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                    ),
                  ],
                ))
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          elevation: 1,
          brightness: Brightness.dark,
          title: showSearch
              ? Container(
                  height: kToolbarHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.w),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: _animation.value,
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 8.w,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.w),
                              color: Colors.white,
                            ),
                            height: 40.w,
                            child: TextField(
                              focusNode: _focus,
                              autofocus: true,
                              onChanged: (text) {
                                setState(() {});
                                if (text.length >= 3) {
                                  debounce.run(() =>
                                      searchController.searchProducts(text));
                                }
                              },
                              controller: _searchFieldController,
                              decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  labelText: S.of(context).searchOnedeybe,
                                  hintText: S.of(context).searchOnedeybe,
                                  hintStyle: TextStyle(fontSize: 14.w),
                                  hintMaxLines: 1,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  suffixIcon:
                                      _searchFieldController.text.length > 0
                                          ? FadeTransition(
                                              opacity: Tween<double>(
                                                begin: 0.0,
                                                end: 1.0,
                                              ).animate(_animationController),
                                              child: InkWell(
                                                child: Icon(Icons.close),
                                                onTap: () {
                                                  setState(() {
                                                    _searchFieldController
                                                        .text = "";
                                                    searchController.clear();
                                                  });
                                                },
                                              ))
                                          : null),
                              style: TextStyle(fontSize: 14.w),
                            ),
                          )),
                      Expanded(
                        flex: 1,
                        child: FadeTransition(
                          opacity: animation,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.all(0),
                            ),
                            onPressed: _cancelSearch,
                            child: Text(
                              S.of(context).cancel,
                              style: TextStyle(fontSize: 15.w),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Container(
                  height: kToolbarHeight,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 12.w,
                      ),
                      Expanded(
                        child: Text(S.of(context).myCart,
                            style: Get.textTheme.bodyText1.copyWith(
                                fontSize: 20.w, fontWeight: FontWeight.bold)),
                      ),
                      IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: _onFocusChange,
                        icon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
          centerTitle: false,
        ),
        bottomNavigationBar: GetBuilder<CartController>(
            builder: (c) => AnimatedContainer(
                  height: _cartController.cartItems.length > 0 ? 66.w : 0,
                  duration: Duration(microseconds: 500),
                  child: _cartController.cartItems.length > 0
                      ? CartBottomBar(
                          currency: "GHS",
                          totalAmount:
                              _cartController.cartCost.total.toString(),
                          // formatCurrency.format(

                          // _cartController.cartItems?.fold(
                          //     0,
                          //     (previousValue, element) =>
                          //         previousValue +
                          //         (element.hasDiscount? element.discountPrice: element.price) *
                          //             (element.quantity ?? 1.00))
                          // ),
                          quantity: _cartController.cartCost.numberOfItems,
                          onGoToCheckout: () {
                            !_userController.isLoggedIn()
                                ? Helper.signInRequired(
                                    "You must sign in to checkout",
                                    () => Get.offAll(LoginScreen()),
                                  )
                                : Get.to(AddressScreen(
                                    hasContinueButton: true,
                                    onContinuePressed: () =>
                                        Get.off(CheckoutScreen()),
                                  ));
                          },
                        )
                      : null,
                )),
        body: Obx(() => ErrorBoundary(
            canceled: _cartController.canceled.value,
            serverError: _cartController.serverError.value,
            connectionError: _cartController.connectionError.value,
            onRetry: _cartController.onInit,
            child: Shimmer(
              linearGradient: Constants.shimmerGradient,
              child: Stack(children: <Widget>[
                SingleChildScrollView(
                    child: Column(
                  children: [
                    // Text("${_cartController.cartCost.total}"),
                    _buildCartItem(
                        CartItemType.Cart, _cartController.cartItems),
                    // if (_cartController.cartItems.isNotEmpty) _itemTotal,
                  ],
                )),
                if (showSearch) SearchResultWidget(closeSearch: _cancelSearch)
              ]),
            ))));
  }

  void _showSearch() {
    setState(() {
      showSearch = true;
      controller.forward();
      _animationController.forward();
    });
  }

  void _cancelSearch() {
    // FocusScope.of(context).requestFocus(new FocusNode());
    searchController.cancel();
    setState(() {
      showSearch = false;
    });
    _animationController.reverse();
    controller.reverse();
    _searchFieldController.text = "";
  }

  void _onFocusChange() {
    _showSearch();
  }
}
