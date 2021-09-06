import 'package:edeybe/index.dart';
import 'package:flutter/material.dart';

class AppController extends GetxController {
  var local = "ar".obs;
  var store = "ae".obs;

  setLocal(String local) async {
    this.local.value = local;
    Get.updateLocale(Locale(local));
    update();
    await GetStorage().write('local', local);
  }

  setStore(String store) async {
    this.store.value = store;
    await GetStorage().write('store', store);
  }

  getStore() async {
    return await GetStorage().read('store');
  }
}
