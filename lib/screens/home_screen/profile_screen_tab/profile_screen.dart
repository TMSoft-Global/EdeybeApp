import 'package:edeybe/controllers/app_controller.dart';
import 'package:edeybe/controllers/user_controller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/screens/address_screen/address_screen.dart';
import 'package:edeybe/screens/auth_screen/login_screen.dart';
import 'package:edeybe/screens/home_screen/profile_screen_tab/edit_profile_screen/edit_profile_screen.dart';
import 'package:edeybe/screens/order_history_screen/order_history_screen.dart';
import 'package:edeybe/screens/payment_method/payment_method.dart';
// import 'package:edeybe/screens/track_order_screen/track_order.dart';
import 'package:edeybe/screens/wishlist_screen/wishlist_screen.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:edeybe/utils/helper.dart';
import 'package:edeybe/widgets/action_sheet_dialog.dart';
import 'package:edeybe/widgets/custom_dialog.dart';
import 'package:edeybe/widgets/custom_web_view.dart';

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key key}) : super(key: key);
  final appController = Get.put(AppController());
  final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        elevation: 1,
        brightness: Brightness.dark,
        title: Container(
          height: kToolbarHeight,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 12.w,
              ),
              userController.isLoggedIn()
                  ? Expanded(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: kToolbarHeight.w - 10.w,
                            height: kToolbarHeight.w - 10.w,
                            child: CircleAvatar(),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10.w, right: 10.w),
                            height: kToolbarHeight,
                            child: Column(
                              textBaseline: TextBaseline.alphabetic,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                    "${S.of(context).welcome} ${userController.user.firstname}",
                                    style: Get.textTheme.bodyText1.copyWith(
                                        color: Colors.white,
                                        fontSize: 14.w,
                                        fontWeight: FontWeight.bold)),
                                Text(userController.user.email,
                                    style: Get.textTheme.bodyText1.copyWith(
                                        color: Colors.white,
                                        fontSize: 10.w,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : TextButton.icon(
                      onPressed: () => Get.offAll(LoginScreen()),
                      icon:
                          Icon(FontAwesomeIcons.signInAlt, color: Colors.white),
                      label: Text(S.current.signIn,
                          style: TextStyle(color: Colors.white))),
              if (userController.user != null)
                IconButton(
                  onPressed: () => Get.to(EditProfileScreen()),
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(
        children: <Widget>[
          ..._buildPersonalDetailsList,
          ..._buildhelpCenterActions,
        ],
      ),
    );
  }

  // biuld section header
  Widget _buildSectionHeader(String title) {
    return Container(
      child: Text(
        title,
        style: Get.textTheme.bodyText1
            .copyWith(fontSize: 15.w, fontWeight: FontWeight.bold),
      ),
      padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 20.w),
      color: Constants.themeGreyLight,
    );
  }

  // biuld section header
  List<Widget> get _buildPersonalDetailsList {
    return [
      _buildSectionHeader(S.current.personalDetails),
      ListTile(
        dense: true,
        leading: Icon(
          Icons.favorite_border,
          size: 20.w,
          color: Constants.themeGreyDark,
        ),
        title: Text(
          S.current.myWishlist,
          style: TextStyle(fontSize: 14.w),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16.w,
          color: Constants.themeGreyDark,
        ),
        onTap: () => Get.to(WishlistScreen()),
      ),
      ListTile(
        dense: true,
        leading: Icon(
          Icons.credit_card,
          size: 20.w,
          color: Constants.themeGreyDark,
        ),
        title: Text(
          S.current.paymentMethod,
          style: TextStyle(fontSize: 14.w),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16.w,
          color: Constants.themeGreyDark,
        ),
        onTap: () => Get.to(PaymentMethodScreen()),
      ),
      // ListTile(
      //   dense: true,
      //   leading: Icon(
      //     Icons.insert_comment,
      //     size: 20.w,
      //     color: Constants.themeGreyDark,
      //   ),
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: <Widget>[
      //       Text(
      //         S.current.language,
      //         style: TextStyle(fontSize: 14.w),
      //       ),
      //       Text(
      //         S.current.arabic,
      //         style: TextStyle(color: Constants.mainColor, fontSize: 14.w),
      //       ),
      //     ],
      //   ),
      //   trailing: Icon(
      //     Icons.arrow_forward_ios,
      //     size: 16.w,
      //     color: Constants.themeGreyDark,
      //   ),
      //   onTap: () => _changeLanguage(),
      // ),
      // ListTile(
      //   dense: true,
      //   leading: Icon(
      //     Icons.outlined_flag,
      //     size: 20.w,
      //     color: Constants.themeGreyDark,
      //   ),
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: <Widget>[
      //       Text(
      //         S.current.country,
      //         style: TextStyle(fontSize: 14.w),
      //       ),
      //       Obx(() => Container(
      //             child: SvgPicture.asset(
      //               'assets/icons/ic_${appController.store.value == "ae" ? "uae" : "eg"}.svg',
      //               height: 20.h,
      //               alignment: Alignment.center,
      //             ),
      //           ))
      //     ],
      //   ),
      //   trailing: Icon(
      //     Icons.arrow_forward_ios,
      //     size: 16.w,
      //     color: Constants.themeGreyDark,
      //   ),
      //   onTap: () => _changeCountry(),
      // ),
      ListTile(
        dense: true,
        leading: Icon(
          FontAwesomeIcons.mapMarkerAlt,
          size: 20.w,
          color: Constants.themeGreyDark,
        ),
        title: Text(
          S.current.deliveryAddress,
          style: TextStyle(fontSize: 14.w),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16.w,
          color: Constants.themeGreyDark,
        ),
        onTap: () => Get.to(AddressScreen()),
      ),
    ];
  }

  //build help center actions list
  List<Widget> get _buildhelpCenterActions {
    return [
      _buildSectionHeader(S.current.hlepCenter),
      ListTile(
        dense: true,
        leading: Icon(
          FontAwesomeIcons.listAlt,
          size: 20.w,
          color: Constants.themeGreyDark,
        ),
        title: Text(
          S.current.orderHistory,
          style: TextStyle(fontSize: 14.w),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16.w,
          color: Constants.themeGreyDark,
        ),
        onTap: () {
          !userController.isLoggedIn()
              ? Helper.signInRequired(
                  "You must sign in to view your orders",
                  () => Get.offAll(LoginScreen()),
                )
              : Get.to(OrderHistoryScreen());
        },
      ),
      // ListTile(
      //   dense: true,
      //   leading: Icon(
      //     FontAwesomeIcons.mapMarkedAlt,
      //     size: 20.w,
      //     color: Constants.themeGreyDark,
      //   ),
      //   title: Text(
      //     S.current.trackOrders,
      //     style: TextStyle(fontSize: 14.w),
      //   ),
      //   trailing: Icon(
      //     Icons.arrow_forward_ios,
      //     size: 16.w,
      //     color: Constants.themeGreyDark,
      //   ),
      //   onTap: () {
      //     !userController.isLoggedIn()
      //         ? Helper.signInRequired(
      //             "You must sign in to view your orders",
      //             () => Get.offAll(LoginScreen()),
      //           )
      //         : Get.to(TrackOrderScreen());
      //   },
      // ),
      // ListTile(
      //   dense: true,
      //   leading: Icon(
      //     FontAwesomeIcons.donate,
      //     size: 20.w,
      //     color: Constants.themeGreyDark,
      //   ),
      //   title: Text(
      //     S.current.currency,
      //     style: TextStyle(fontSize: 14.w),
      //   ),
      //   trailing: Icon(
      //     Icons.arrow_forward_ios,
      //     size: 16.w,
      //     color: Constants.themeGreyDark,
      //   ),
      //   onTap: () => Get.to(SetCurrencyScreen()),
      // ),
      ListTile(
        dense: true,
        leading: Icon(
          FontAwesomeIcons.exclamationCircle,
          size: 20.w,
          color: Constants.themeGreyDark,
        ),
        title: Text(
          S.current.tnc,
          style: TextStyle(fontSize: 14.w),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16.w,
          color: Constants.themeGreyDark,
        ),
        onTap: () => Get.to(CustomWebView(
          title: "Term and Conditions",
          url: 'https://edeybe.com/m/terms-conditions',
        )),
      ),
      ListTile(
        dense: true,
        leading: Icon(
          Icons.privacy_tip_outlined,
          size: 20.w,
          color: Constants.themeGreyDark,
        ),
        title: Text(
          S.current.privacyPolicy,
          style: TextStyle(fontSize: 14.w),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16.w,
          color: Constants.themeGreyDark,
        ),
        onTap: () => Get.to(CustomWebView(
          title: "Privacy Policy",
          url: 'https://edeybe.com/m/privacy-policy',
        )),
      ),
      ListTile(
        dense: true,
        leading: Icon(
          Icons.support_agent_rounded,
          size: 20.w,
          color: Constants.themeGreyDark,
        ),
        title: Text(
          S.current.help,
          style: TextStyle(fontSize: 14.w),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16.w,
          color: Constants.themeGreyDark,
        ),
        onTap: () => Get.to(CustomWebView(
          title: "Help",
          url: 'https://edeybe.com/m/faqs',
        )),
      ),
      ListTile(
        dense: true,
        leading: Icon(
          FontAwesomeIcons.questionCircle,
          size: 20.w,
          color: Constants.themeGreyDark,
        ),
        title: Text(
          S.current.gotquestion,
          style: TextStyle(fontSize: 14.w),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16.w,
          color: Constants.themeGreyDark,
        ),
        onTap: () => Get.to(CustomWebView(
          title: "Help",
          url: 'https://edeybe.com/m/faqs',
        )),
      ),
      if (userController.isLoggedIn())
        ListTile(
          dense: true,
          leading: Icon(
            FontAwesomeIcons.signOutAlt,
            size: 20.w,
            color: Constants.themeGreyDark,
          ),
          title: Text(
            S.current.logout,
            style: TextStyle(fontSize: 14.w),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.w,
            color: Constants.themeGreyDark,
          ),
          onTap: () {
            Get.dialog(CustomDialog(
              title: S.current.logout,
              content: S.current.logoutWarningMsg,
              confrimPressed: () async {
                await userController.logout();
              },
              cancelText: S.current.cancel,
              confrimText: S.current.logout,
            ));
          },
        ),
    ];
  }

  // change country dialog
  void _changeCountry() async {
    await actionSheetDialog(Material(
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              S.current.changeCountry,
              textAlign: TextAlign.center,
              style: Get.textTheme.headline6.copyWith(fontSize: 20.w),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Obx(
                  () => Container(
                    color: Colors.white,
                    child: RadioListTile(
                      dense: true,
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: "ae",
                      secondary: SvgPicture.asset(
                        'assets/icons/ic_uae.svg',
                        height: 20.h,
                        alignment: Alignment.center,
                      ),
                      title: AutoSizeText(
                        S.current.uae,
                        maxLines: 1,
                        style: Get.textTheme.subtitle1.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      activeColor: Get.theme.primaryColor,
                      groupValue: appController.store.value,
                      onChanged: (value) {
                        appController.setStore(value);
                        Get.back();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Obx(
                  () => Container(
                    color: Colors.white,
                    child: RadioListTile(
                      dense: true,
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: "eg",
                      secondary: SvgPicture.asset(
                        'assets/icons/ic_eg.svg',
                        height: 20.h,
                        alignment: Alignment.center,
                      ),
                      title: AutoSizeText(
                        S.current.egypt,
                        maxLines: 1,
                        style: Get.textTheme.subtitle1.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      activeColor: Get.theme.primaryColor,
                      groupValue: appController.store.value,
                      onChanged: (value) {
                        appController.setStore(value);
                        Get.back();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: Get.width,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Constants.themeGreyLight,
              ),
              onPressed: () {
                Get.back();
              },
              child: Text(
                S.current.cancel,
              ),
            ),
          ),
        ],
      ),
    ));
  }

  // change country dialog
  void _changeLanguage() async {
    await actionSheetDialog(
      Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(S.current.changeLanguage,
                textAlign: TextAlign.center,
                style: Get.textTheme.headline6.copyWith(fontSize: 20.w)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: Get.width,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                      backgroundColor: Get.theme.primaryColor,
                    ),
                    onPressed: () {
                      appController.setLocal("en");
                      Get.back();
                    },
                    child: Text(
                      S.current.english,
                    ),
                  ),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Container(
                  width: Get.width,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      appController.setLocal("ar");
                      Get.back();
                    },
                    child: Text(
                      S.current.arabic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: Get.width,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Constants.themeGreyLight,
              ),
              onPressed: () {
                Get.back();
              },
              child: Text(
                S.current.cancel,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
