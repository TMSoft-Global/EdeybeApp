import 'package:edeybe/controllers/cart_controller.dart';
import 'package:edeybe/controllers/search_controller.dart';
import 'package:edeybe/controllers/user_controller.dart';
import 'package:edeybe/controllers/wishlist_controller.dart';
import 'package:edeybe/models/productModel.dart';
import 'package:edeybe/screens/auth_screen/login_screen.dart';
import 'package:edeybe/screens/checkout_screen/checkout_screen.dart';
import 'package:edeybe/screens/finance_product_screen/assetFinancerList.dart';
import 'package:edeybe/screens/finance_product_screen/kyc_form.dart';
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
import 'package:edeybe/widgets/custom_divider.dart';
import 'package:edeybe/widgets/empty_list_widget.dart';
import 'package:edeybe/widgets/money_widget.dart';
import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';
import 'package:intl/intl.dart';

class CheckoutWithAsset_HireP extends StatefulWidget {
  CheckoutWithAsset_HireP(this.isHirePurchase, this.title);
  bool isHirePurchase;
  final String title;

  @override
  _CheckoutWithAsset_HirePState createState() =>
      _CheckoutWithAsset_HirePState();
}

class _CheckoutWithAsset_HirePState extends State<CheckoutWithAsset_HireP>
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
  String _selectedProduct;
  List items = [0, 1, 3];
  bool showSearch = false;
  bool _isChecked = false;
  Debouncer debounce = Debouncer();
  AnimationController _animationController;
  FocusNode _focus = new FocusNode();
  Animation _animation;
  AnimationController controller;
  Animation<double> animation;
  List<String> _productSelectedForcheck = [];
  void _setDeliveryLocation(text) {
    setState(() {
      _deliverto = text;
    });
  }

  @override
  void initState() {
    super.initState();
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
  }

  @override
  void dispose() {
    _animationController.dispose();
    controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _setProduct(value) {
    setState(() => _selectedProduct = value);
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
                tappable: false,
                    onCkeck: Checkbox(
                      activeColor: Get.theme.primaryColor,
                      onChanged: (v) {
                        setState(() {
                          e.selectedProduct = v;
                        });
                        if (v) {
                          _productSelectedForcheck.add(e.productId);
                          _cartController.addProductHirePurchase(
                            e,
                            e.quantity,
                          );
                        } else {
                          _productSelectedForcheck.removeWhere(
                              (element) => element.contains(e.productId));
                          _cartController.clearHirePurchaseProduct(e.productId);
                        }
                      },
                      value: e.selectedProduct,
                    ),
                    product: e,
                    type: type,
                    isCheckOut: true,
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
                        _productSelectedForcheck.removeWhere(
                            (element) => element.contains(e.productId));
                        _cartController.clearHirePurchaseProduct(e.productId);
                      },
                      cancelText: S.of(context).no,
                      confrimText: S.of(context).yes,
                    )),
                    onIncreaseQunatity: null,
                    onDecreaseQunatity: null,
                  
                    onMovePressed: type == CartItemType.Wishlist
                        ? () {
                            _wishlistController.moveToCart(
                                products.indexWhere((element) =>
                                    element.productId == e.productId),
                                ({String title}) {
                              Get.dialog(
                                CartDialog(
                                    title: title,
                                    onGoForward: () =>
                                        !_userController.isLoggedIn()
                                            ? Helper.signInRequired(
                                                "You must sign in to checkout",
                                                () => Get.offAll(LoginScreen()),
                                              )
                                            : Get.to(CheckoutScreen()),
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
                                                element.price +
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
          title: Text(widget.title),
          // ? Container(
          //     height: kToolbarHeight,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(4.w),
          //       color: Colors.white,
          //     ),
          //     child: Row(
          //       children: <Widget>[
          //         Expanded(
          //             flex: _animation.value,
          //             child: Container(
          //               margin: EdgeInsets.only(
          //                 left: 8.w,
          //               ),
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(4.w),
          //                 color: Colors.white,
          //               ),
          //               height: 40.w,
          //               child: TextField(
          //                 focusNode: _focus,
          //                 autofocus: true,
          //                 onChanged: (text) {
          //                   setState(() {});
          //                   if (text.length >= 3) {
          //                     debounce.run(() =>
          //                         searchController.searchProducts(text));
          //                   }
          //                 },
          //                 controller: _searchFieldController,
          //                 decoration: InputDecoration(
          //                     isDense: true,
          //                     border: InputBorder.none,
          //                     labelText: S.of(context).searchOnedeybe,
          //                     hintText: S.of(context).searchOnedeybe,
          //                     hintStyle: TextStyle(fontSize: 14.w),
          //                     hintMaxLines: 1,
          //                     floatingLabelBehavior:
          //                         FloatingLabelBehavior.never,
          //                     prefixIcon: Icon(
          //                       Icons.search,
          //                       color: Colors.grey,
          //                     ),
          //                     suffixIcon:
          //                         _searchFieldController.text.length > 0
          //                             ? FadeTransition(
          //                                 opacity: Tween<double>(
          //                                   begin: 0.0,
          //                                   end: 1.0,
          //                                 ).animate(_animationController),
          //                                 child: InkWell(
          //                                   child: Icon(Icons.close),
          //                                   onTap: () {
          //                                     setState(() {
          //                                       _searchFieldController
          //                                           .text = "";
          //                                       searchController.clear();
          //                                     });
          //                                   },
          //                                 ))
          //                             : null),
          //                 style: TextStyle(fontSize: 14.w),
          //               ),
          //             )),
          //         // Expanded(
          //         //   flex: 1,
          //         //   child: FadeTransition(
          //         //     opacity: animation,
          //         //     child: TextButton(
          //         //       style: TextButton.styleFrom(
          //         //         padding: EdgeInsets.all(0),
          //         //       ),
          //         //       onPressed: _cancelSearch,
          //         //       child: Text(
          //         //         S.of(context).cancel,
          //         //         style: TextStyle(fontSize: 15.w),
          //         //       ),
          //         //     ),
          //         //   ),
          //         // )
          //       ],
          //     ),
          //   )
          // : Container(
          //     height: kToolbarHeight,
          //     padding: EdgeInsets.symmetric(horizontal: 8.w),
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //     ),
          //     child: Row(
          //       children: <Widget>[
          //         SizedBox(
          //           width: 12.w,
          //         ),
          //         Expanded(
          //           child: Text(S.of(context).myCart,
          //               style: Get.textTheme.bodyText1.copyWith(
          //                   fontSize: 20.w, fontWeight: FontWeight.bold)),
          //         ),
          //         IconButton(
          //           padding: EdgeInsets.all(0),
          //           onPressed: _onFocusChange,
          //           icon: Icon(
          //             Icons.search,
          //             color: Colors.grey,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          centerTitle: true,
        ),
        bottomNavigationBar: GetBuilder<CartController>(
            builder: (c) => AnimatedContainer(
                height: _cartController.cartItems.length > 0 ? 60.w : 0,
                duration: Duration(microseconds: 500),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7),
                  child: TextButton(
                      child: Text(
                        "Continue".toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Get.theme.primaryColor,
                          textStyle: TextStyle(
                            color: Colors.white,
                          )),
                      onPressed: () {
                        widget.isHirePurchase
                            ? _productSelectedForcheck.length < 1
                                ? Get.snackbar("Required",
                                    "Please select an item to proceed")
                                : _cartController.checkHirePurchaseProduct(
                                    _productSelectedForcheck, (val) {
                                    if (val.contains("success") &&
                                        val != null &&
                                        val != "") {
                                      if (_cartController
                                          .productModel.value[0].isEmpty) {
                                        _cartController.productModel
                                            .removeAt(0);
                                        Get.to(KYCForm(
                                                email:
                                                    _userController.user.email,
                                                firstName: _userController
                                                    .user.firstname,
                                                lastName: _userController
                                                    .user.lastname,
                                                type: "hire",
                                                isAssestFinance: false,
                                                products: _cartController
                                                    .productModel.value))
                                            .whenComplete(() {
                                          _cartController.productModel.clear();
                                          _productSelectedForcheck.clear();
                                        });
                                      } else {
                                        Get.to(KYCForm(
                                                email:
                                                    _userController.user.email,
                                                firstName: _userController
                                                    .user.firstname,
                                                lastName: _userController
                                                    .user.lastname,
                                                type: "hire",
                                                isAssestFinance: false,
                                                products: _cartController
                                                    .productModel.value))
                                            .whenComplete(() {
                                          _cartController.productModel.clear();
                                          _productSelectedForcheck.clear();
                                        });
                                      }
                                    }
                                  })
                            : _productSelectedForcheck.length < 1
                                ? Get.snackbar("Required",
                                    "Please select an item to proceed")
                                : showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    isDismissible: false,
                                    builder: (context) {
                                      if (_cartController
                                          .productModel.value[0].isEmpty) {
                                        _cartController.productModel
                                            .removeAt(0);
                                      }
                                      return FractionallySizedBox(
                                        heightFactor: 0.9,
                                        child: AssetFinancersList(
                                          email: _userController.user.email,
                                          firstName:
                                              _userController.user.firstname,
                                          lastName:
                                              _userController.user.lastname,
                                          products: _cartController
                                              .productModel.value,
                                        ),
                                      );
                                    });
                      }),
                ))),
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
                        CartItemType.Checkout, _cartController.cartItems),
                    // if (_cartController.cartItems.isNotEmpty) _itemTotal,
                  ],
                )),
              ]),
            ))));
  }
}
