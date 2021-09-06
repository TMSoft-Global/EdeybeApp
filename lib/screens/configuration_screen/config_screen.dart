import 'package:edeybe/controllers/app_controller.dart';
import 'package:edeybe/controllers/user_controller.dart';
import 'package:edeybe/index.dart';

import 'package:edeybe/screens/auth_screen/login_screen.dart';
import 'package:edeybe/screens/home_screen/index.dart';
import 'package:flutter/material.dart';

class ConfigurationScreen extends StatelessWidget {
  final appController = Get.put(AppController());
  final _userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Spacer(),
          Image.asset(
            'assets/images/Logo.png',
            width: 0.7.w,
          ),
          SizedBox(
            height: 40.h,
          ),
          // Text(
          //   S.of(context).selectLanguage,
          //   textAlign: TextAlign.center,
          //   style: Get.textTheme.headline6,
          // ),
          // SizedBox(
          //   height: 12.h,
          // ),
          // Container(
          //   height: 50.h,
          //   padding: EdgeInsets.symmetric(horizontal: 36.w),
          //   child: Row(
          //     children: <Widget>[
          //       Expanded(
          //         child: TextButton(
          //           textColor: Colors.white,
          //           color: Get.theme.primaryColor,
          //           onPressed: () {
          //             appController.setLocal("en");
          //           },
          //           child: Text(
          //             S.of(context).english,
          //           ),
          //         ),
          //       ),
          //       SizedBox(
          //         width: 12.w,
          //       ),
          //       Expanded(
          //         child: TextButton(
          //           color: Colors.white,
          //           onPressed: () {
          //             appController.setLocal("ar");
          //           },
          //           child: Text(
          //             S.of(context).arabic,
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 30.h,
          // ),
          // Text(
          //   S.of(context).selectCountry,
          //   style: Get.textTheme.headline6,
          //   textAlign: TextAlign.center,
          // ),
          // Text(
          //   S.of(context).pleaseSelectYourShippingDestination,
          //   style: Get.textTheme.caption,
          //   textAlign: TextAlign.center,
          // ),
          // SizedBox(
          //   height: 30.h,
          // ),
          // Obx(
          //   () => Container(
          //     color: Colors.white,
          //     margin: EdgeInsets.symmetric(horizontal: 20.w),
          //     child: RadioListTile(
          //       dense: true,
          //       controlAffinity: ListTileControlAffinity.trailing,
          //       value: "ae",
          //       secondary: SvgPicture.asset(
          //         'assets/icons/ic_uae.svg',
          //         height: 20.h,
          //         alignment: Alignment.center,
          //       ),
          //       title: AutoSizeText(
          //         S.of(context).uae,
          //         maxLines: 1,
          //         style: Get.textTheme.subtitle1.copyWith(
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //       activeColor: Get.theme.primaryColor,
          //       groupValue: appController.store.value,
          //       onChanged: (value) {
          //         appController.setStore(value);
          //       },
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 12.h,
          // ),
          // Obx(
          //   () => Container(
          //     color: Colors.white,
          //     margin: EdgeInsets.symmetric(horizontal: 20.w),
          //     child: RadioListTile(
          //       dense: true,
          //       controlAffinity: ListTileControlAffinity.trailing,
          //       value: "eg",
          //       secondary: SvgPicture.asset(
          //         'assets/icons/ic_eg.svg',
          //         height: 20.h,
          //         alignment: Alignment.center,
          //       ),
          //       title: AutoSizeText(
          //         S.of(context).egypt,
          //         maxLines: 1,
          //         style: Get.textTheme.subtitle1.copyWith(
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //       activeColor: Get.theme.primaryColor,
          //       groupValue: appController.store.value,
          //       onChanged: (value) {
          //         appController.setStore(value);
          //       },
          //     ),
          //   ),
          // ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextButton(
              onPressed: () async {
                var token = await GetStorage().read("anony-cookie");
                if (token == null) {
                  _userController.getAnnonymousToken();
                }
                Get.offAll(HomeIndex());
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: Text(
                S.of(context).startShopping,
              ),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextButton(
              onPressed: () {
                Get.to(LoginScreen());
              },
              style: TextButton.styleFrom(
                textStyle: TextStyle(color: Colors.white),
                backgroundColor: Get.theme.primaryColor,
              ),
              child: Text(
                S.of(context).signIn,
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
