// ignore_for_file: invalid_use_of_protected_member

import 'package:edeybe/controllers/cart_controller.dart';
import 'package:edeybe/controllers/user_controller.dart';
import 'package:edeybe/screens/address_screen/address_screen.dart';
import 'package:edeybe/screens/auth_screen/login_screen.dart';
import 'package:edeybe/screens/checkout_screen/checkout_screen.dart';
import 'package:edeybe/screens/finance_product_screen/assetFinancerList.dart';
import 'package:edeybe/screens/finance_product_screen/kyc_form.dart';
import 'package:edeybe/utils/helper.dart';
import 'package:edeybe/widgets/tile_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';

class BottomSheetWidget extends StatelessWidget {
  final product;

  BottomSheetWidget({Key key, this.product}) : super(key: key);

  final _userController = Get.find<UserController>();
  final _cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFF737373),
        //so you don't have to change MaterialApp canvasColor
        child: new Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(15.0),
                    topRight: const Radius.circular(15.0))),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Proceed",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TileButton(
                        title: "To Pay Now",
                        onTap: () {
                          Navigator.pop(context);
                          Get.back();
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
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TileButton(
                        title: "With Hire Purchase",
                        onTap: () {
                          Navigator.pop(context);
                          !_userController.isLoggedIn()
                              ? Helper.signInRequired(
                                  "You must sign in to checkout",
                                  () => Get.offAll(LoginScreen()),
                                )
                              : Get.to(
                                  AddressScreen(
                                      hasContinueButton: true,
                                      onContinuePressed: () {
                                        _cartController
                                            .addProductHirePurchase();
                                        _cartController
                                            .checkHirePurchaseProduct(
                                                (dynamic) {
                                          Get.to(KYCForm(
                                              email: _userController.user.email,
                                              firstName: _userController
                                                  .user.firstname,
                                              lastName:
                                                  _userController.user.lastname,
                                              type: "hire",
                                              isAssestFinance: false,
                                              products: _cartController
                                                  .productModel));
                                          //     .whenComplete(
                                          //         () {
                                          // _cartController
                                          //     .productModel
                                          //       .clear();
                                          // });
                                        });
                                      }),
                                );
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // TileButton(
                      //   title: "With Asset Finance",
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //     _cartController.addProductHirePurchase();

                      //     Get.back();
                      //     !_userController.isLoggedIn()
                      //         ? Helper.signInRequired(
                      //             "You must sign in to checkout",
                      //             () => Get.offAll(LoginScreen()),
                      //           )
                      //         : showModalBottomSheet(
                      //             context: context,
                      //             isScrollControlled: true,
                      //             isDismissible: false,
                      //             builder: (context) {
                      //               if (_cartController
                      //                   .productModel.value[0].isEmpty) {
                      //                 _cartController.productModel.removeAt(0);
                      //               }
                      //               return AssetFinancersList(
                      //                 email: _userController.user.email,
                      //                 firstName: _userController.user.firstname,
                      //                 lastName: _userController.user.lastname,
                      //                 products:
                      //                     _cartController.productModel.value,
                      //               );
                      //             });
                      //   },
                      // ),
                      SizedBox(
                        height: 10,
                      )
                    ]))));
  }
}
