//upgrade required modal
import 'package:edeybe/services/app_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:version/version.dart';
import '../index.dart';

class Siren {
  PackageInfo packageInfo;
  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    print(info.version);
    packageInfo = info;

    await AppInfo().updateVersion(packageInfo.version, packageInfo.buildNumber, (dynamic) => null);
  }

  Siren() {
    _initPackageInfo();
  }
  Future<dynamic> getAppInfo(callback(dynamic)) async {
    return await AppInfo().getInfo((val){
        callback(val);
    });
  }

  updateAvailable(String latest) {
    Version currentVersion = Version.parse(packageInfo.version);
    Version latestVersion = Version.parse(latest);

    return latestVersion > currentVersion;
  }

  Future<void> forceUpdateAlert(BuildContext context) async {
    await Get.dialog<bool>(
      WillPopScope(
          onWillPop: () => Future.value(false),
          child: AlertDialog(
            title: Container(
              padding: EdgeInsets.all(5),
              child: Row(children: <Widget>[
                Icon(Icons.info),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text("App Version Update", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                )
              ]),
            ),
            content: Text(
                "For better performance and experience, we require that you use the latest version of this App."),
            actions: <Widget>[
              TextButton(
                child: Text("Get Update"),
                onPressed: () {
                  Get.back(result: true);
                  StoreRedirect.redirect(
                      androidAppId: packageInfo.packageName,
                      iOSAppId: packageInfo.packageName);
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
              )
            ],
          )),
      barrierDismissible: false,
    );
  }
}
