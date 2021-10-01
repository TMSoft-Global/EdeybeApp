import 'package:edeybe/controllers/address_controller.dart';
import 'package:edeybe/controllers/cart_controller.dart';
import 'package:edeybe/controllers/user_controller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/screens/splash_screen/splash_screen.dart';
import 'package:edeybe/services/simpleWeb.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 812),
        allowFontScaling: true,
        builder: () => GetMaterialApp(
            darkTheme: AppTheme.themeLight,
            theme: AppTheme.themeLight,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            home: SplashScreen(),
            // home: SimpleWebview(),
            supportedLocales: S.delegate.supportedLocales,
            // locale: DevicePreview.of(context).locale, // <--- Add the locale
            // builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false));
  }
}
