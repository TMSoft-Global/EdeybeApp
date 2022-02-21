import 'dart:async';

import 'package:edeybe/controllers/address_controller.dart';
import 'package:edeybe/controllers/cart_controller.dart';
import 'package:edeybe/controllers/category_controller.dart';
import 'package:edeybe/controllers/payment_method_controller.dart';
import 'package:edeybe/controllers/product_controller.dart';
import 'package:edeybe/controllers/user_controller.dart';
import 'package:edeybe/controllers/wishlist_controller.dart';
import 'package:edeybe/screens/home_screen/cart_tab/cart_tab_screen.dart';
import 'package:edeybe/screens/home_screen/home_tab/home_tab_screen.dart';
import 'package:edeybe/screens/home_screen/profile_screen_tab/profile_screen.dart';
import 'package:edeybe/screens/promoBanner.dart';
import 'package:edeybe/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';

import 'category_tab/category_tab_screen.dart';

class HomeIndex extends StatefulWidget {
  final int indexPage;
  HomeIndex({this.indexPage = 0});
  @override
  _HomeIndexState createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> {
  int current = 0;
  var productController = Get.put(ProductController());
  var cartController = Get.put(CartController());
  var wishlistController = Get.put(WishlistController());
  var addressController = Get.put(AddressController());
  var paymentMethodController = Get.put(PaymentMethodController());
  var _userCtrl = Get.find<UserController>();
  var categoryContoller = Get.put(CategoryController());
  List<Widget> children = [];
  bool hasBanner = true;
  PageController pageController = PageController();
  @override
  void initState() {
    super.initState();
    current = widget.indexPage;
    if (hasBanner) _showDiscountBanner();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void getCart() {
    cartController.getCartITems();
  }

  void clearPageNo() {
    _userCtrl.historyPage.value = 1;
    _userCtrl.ordersHistory.clear();
    _userCtrl.ordersHistoryCount = 0;
    _userCtrl.page.value = 1;
  }

  _showDiscountBanner() {
    Timer(Duration(seconds: 10), () {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Get.dialog(
          PromoBanner(),
          barrierDismissible: false,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Get.dialog(CustomDialog(
        title: 'Confirmation',
        confrimText: 'Yes',
        content: 'Do you want to exit the app?',
        confrimPressed: () {
          Navigator.of(context).pop(true);
          return true;
        },
        cancelPressed: () => Navigator.pop(context),
      )),
      child: Scaffold(
        body: PageView(
          onPageChanged: (i) => setState(() {
            current = i;
          }),
          controller: pageController,
          children: <Widget>[
            HomeScreenTab(),
            CategoryTabScreen(),
            CartScreenTab(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (i) {
            getCart();
            clearPageNo();
            setState(() {
              current = i;
              pageController.jumpToPage(
                current,
              );
            });
          },
          selectedItemColor: Colors.black,
          currentIndex: current,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/ic_home.svg'),
              label: S.of(context).home,
              activeIcon: SvgPicture.asset(
                'assets/icons/ic_home.svg',
                color: Colors.black,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/ic_category.svg'),
              label: S.of(context).category,
              activeIcon: SvgPicture.asset(
                'assets/icons/ic_category.svg',
                color: Colors.black,
              ),
            ),
            // BottomNavigationBarItem(
            //   icon: SvgPicture.asset('assets/icons/ic_offer.svg'),
            //   label: Text(S.of(context).offer),
            //   activeIcon: SvgPicture.asset(
            //     'assets/icons/ic_offer.svg',
            //     color: Get.theme.primaryColor,
            //   ),
            // ),
            BottomNavigationBarItem(
              icon: GetBuilder<CartController>(
                  builder: (_) => Stack(
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/icons/ic_cart.svg',
                          ),
                          if (cartController.cartItems.length > 0)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                height: 16,
                                width: 16,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                child: Center(
                                  child: Text(
                                    cartController.cartItems.length.toString(),
                                    style: Get.textTheme.caption.copyWith(
                                      color: Colors.white,
                                      fontSize: 8.sp,
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ],
                      )),
              label: S.of(context).cart,
              activeIcon: GetBuilder<CartController>(
                  builder: (_) => Stack(
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/icons/ic_cart.svg',
                            color: Colors.black,
                          ),
                          if (cartController.cartItems.length > 0)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                height: 16,
                                width: 16,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                child: Center(
                                  child: Text(
                                    cartController.cartItems.length.toString(),
                                    style: Get.textTheme.caption.copyWith(
                                      color: Colors.white,
                                      fontSize: 8.sp,
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ],
                      )),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/ic_profile.svg'),
              label: S.of(context).profile,
              activeIcon: SvgPicture.asset(
                'assets/icons/ic_profile.svg',
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
