import 'package:edeybe/controllers/cart_controller.dart';
import 'package:edeybe/controllers/wishlist_controller.dart';
import 'package:edeybe/screens/checkout_screen/index.dart';
import 'package:edeybe/utils/cart_item_type.dart';
import 'package:edeybe/widgets/Shimmer.dart';
import 'package:edeybe/widgets/cart_dialog.dart';
import 'package:edeybe/widgets/cart_item.dart';
import 'package:edeybe/widgets/custom_dialog.dart';
import 'package:edeybe/widgets/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';
import 'package:intl/intl.dart';

class WishlistScreen extends StatefulWidget {
  WishlistScreen({Key key}) : super(key: key);

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  // build card items i.e. wishlist , selected items
  final formatCurrency = new NumberFormat.simpleCurrency(name: "");
  final _wishlistController = Get.find<WishlistController>();
  final _cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _wishlistController.getWishlist();
    });
  }

  List<Widget> _buildWishList(WishlistController wishCtl, CartItemType type) {
    var list = wishCtl.wishlistItems;
    if (wishCtl.loading.value) {
      return List.generate(
          5,
          (index) => CartItem(
                isLoading: true,
                product: null,
                type: type,
                onRemovePressed: () => null,
                onDecreaseQunatity: () {},
                onIncreaseQunatity: () => null,
                onMovePressed: () {},
              ));
    } else if (list.isNotEmpty) {
      return list
          .map<Widget>((e) => CartItem(
                product: e,
                type: type,
                onRemovePressed: () => Get.dialog(CustomDialog(
                  title: S.of(context).removeItem,
                  content: S.of(context).removeItemMessage,
                  confrimPressed: () {
                    type == CartItemType.Wishlist
                        ? _wishlistController.removeFromWishlist(
                            list.indexWhere(
                                (element) => element.name == e.name),
                          )
                        : _cartController.removeFromCart(
                            list.indexWhere(
                                (element) => element.name == e.name),
                          );
                    Get.back();
                  },
                  cancelText: S.of(context).no,
                  confrimText: S.of(context).yes,
                )),
                onDecreaseQunatity: e.quantity > 1
                    ? _wishlistController.setQuantity(
                        list.indexWhere((element) => element.name == e.name),
                        -1 + (e.quantity ?? 1))
                    : () {},
                onIncreaseQunatity: () => _wishlistController.setQuantity(
                    list.indexWhere((element) => element == e),
                    1 + (e.quantity ?? 1)),
                onMovePressed: () {
                  _wishlistController.moveToCart(
                      _wishlistController.wishlistItems
                          .indexWhere((element) => element.name == e.name),
                      ({String title}) {
                    Get.dialog(
                      CartDialog(
                          title: title,
                          productTitle: e.name,
                          cartTotal: formatCurrency.format(list.fold(
                              0,
                              (previousValue, element) =>
                                  element.priceRange.minimumPrice.finalPrice
                                      .value +
                                  previousValue))),
                      barrierDismissible: true,
                    );
                  });
                },
              ))
          .toList();
    } else
      return [
        ListEmptyWidget(
            message: S.of(context).cartEmpty,
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
                style: TextStyle(color: Get.theme.primaryColor, fontSize: 15.w),
              ),
              onPressed: () {
                navigator.pop();
              },
            ))
      ];
  }

  Widget _buildCartItem(CartItemType type) {
    return GetBuilder<WishlistController>(builder: (_favController) {
      return Shimmer(
          linearGradient: Constants.shimmerGradient,
          child: Wrap(children: _buildWishList(_favController, type)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        titleSpacing: 0.0,
        elevation: 1,
        brightness: Brightness.dark,
        title: Container(
          height: kToolbarHeight,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(S.of(context).myWishlist,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.bodyText1.copyWith(
                        color: Colors.white,
                        fontSize: 20.0.w,
                        fontWeight: FontWeight.bold)),
              ),
              Icon(
                Icons.search,
                color: Colors.white,
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.w),
          child: _buildCartItem(CartItemType.Wishlist),
        ),
      ),
    );
  }
}
