import 'package:edeybe/controllers/address_controller.dart';
import 'package:edeybe/controllers/cart_controller.dart';
import 'package:edeybe/controllers/user_controller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/screens/splash_screen/splash_screen.dart';
import 'package:edeybe/utils/AppTheme.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  runApp(EdeybeApp());
}

class EdeybeApp extends StatefulWidget {
  @override
  _EdeybeAppState createState() => _EdeybeAppState();
}

class _EdeybeAppState extends State<EdeybeApp> {
  final addressController = Get.put(AddressController());

  final userController = Get.put(UserController());

  final cartControler = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    cartControler.getCartITems();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ScreenUtilInit(
          designSize: Size(375, 812),
          // allowFontScaling: true,
          builder: (context, widget) => GetMaterialApp(
              darkTheme: AppTheme.themeLight,
              theme: AppTheme.themeLight,
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              home: SplashScreen(),
              supportedLocales: S.delegate.supportedLocales,
              debugShowCheckedModeBanner: false)),
    );
  }
}
/**
 * Find a way to add variantID to the product selected in local, 
 * when adding a new state of cart, it will not overwrite the one 
 * with the variantID on the server.
 * 
 */