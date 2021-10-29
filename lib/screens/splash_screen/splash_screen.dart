import 'package:edeybe/controllers/search_controller.dart';
import 'package:edeybe/controllers/user_controller.dart';
import 'package:edeybe/encryption/encryptData.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/screens/configuration_screen/config_screen.dart';
import 'package:edeybe/screens/home_screen/index.dart';
import 'package:edeybe/services/firebase_notification.dart';
import 'package:edeybe/services/siren.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:keyboard_actions/external/platform_check/platform_check.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animation;
  final _userController = Get.find<UserController>();
  final searchController = Get.put(SearchController());
// Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;
  // String name = "Bismark";

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setFirebase(
          onPressed: (str) {
            return null;
          },
          dispatchService: _userController.setPushNotificationToken,
          noti: (val) {});

      var _cookie = GetStorage().read("cookie");
      if (_cookie != null) {
        // print(_cookie);
        _userController.loginFromBase();
      } else {
        var token = await GetStorage().read("anony-cookie");
        if (token == null) {
          _userController.getAnnonymousToken();
        }
        Get.offAll(HomeIndex());
        // Get.off(ConfigurationScreen());
      }
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    // MyEncryptionDecryption.encryptData();
    // MyEncryptionDecryption.decryptAES(MyEncryptionDecryption.encryptAES(name));
    _animation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      var siren = new Siren();
      var info = await siren.getAppInfo();
      if (info.containsKey("success")) {
        var data = info["success"] as Map;
        var forceUpdate = siren.updateAvailable(
            PlatformCheck.isIOS ? data["iosVersion"] : data["androidVersion"]);
        if (forceUpdate) {
          siren.forceUpdateAlert(context);
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: .5.tweenTo(1.0).curved(Curves.easeInOut).animate(_animation),
          child: Image.asset(
            'assets/images/Logo.png',
            height: 150.w,
            alignment: Alignment.center,
            width: 150.w,
          ),
        ),
      ),
    );
  }
}
