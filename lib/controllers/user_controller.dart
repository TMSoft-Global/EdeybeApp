import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edeybe/controllers/address_controller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/interface/HTTPErrorHandler.dart';
import 'package:edeybe/models/order.dart';
import 'package:edeybe/models/user.dart';
import 'package:edeybe/screens/checkout_screen/index.dart';
import 'package:edeybe/screens/configuration_screen/config_screen.dart';
import 'package:edeybe/screens/home_screen/index.dart';
import 'package:edeybe/services/user_operation.dart';
import 'package:edeybe/utils/helper.dart';
import 'package:flutter/material.dart';

class UserController extends GetxController implements HTTPErrorHandler {
  User user;
  List<Order> orders = <Order>[].obs;
  List<Order> ordersHistory = <Order>[].obs;
  int ordersCount = 0;
  int ordersHistoryCount = 0;
  dynamic recentlyViewed;
  var addressCtl = Get.find<AddressController>();
  UserOperations _userOperations = UserOperations();
  var connectionError = false.obs;
  var serverError = false.obs;
  var canceled = false.obs;
  var loadingMore = false.obs;
  var historyLoadingMore = false.obs;
  var page = 1.obs;
  var historyPage = 1.obs;
  var orderLoading = false.obs;
  var historyLoading = false.obs;
  var historyHasMore = true.obs;
  var orderHasMore = true.obs;
  var notificationToken = ''.obs;

  ScrollController controller = ScrollController();

  login({String username, String password}) {
    _userOperations.login(
      (user) async {
        this.user = user;
        Get.snackbar(
          S.current.welcome,
          "${user.firstname} ${user.lastname}",
          snackPosition: SnackPosition.BOTTOM,
        );
        await GetStorage().remove('anony-cookie');
        update();
        getDefaultAddress();
        _userOperations.sendNotificationToken(notificationToken.value);
        // getDefaultCart();
        Get.offAll(HomeIndex());
      },
      email: username,
      password: password,
    );
  }

  getAnnonymousToken() {
    _userOperations.anontoken();
  }

  Future<dynamic> setPushNotificationToken(String token) {
    notificationToken.value = token;
    return null;
  }

  forgotPassword({String email, Function callback}) {
    _userOperations.forgotPassword(
      () async {
        update();
        callback(DialogEnum.Success);
      },
      email: email,
    );
  }

  loginFromBase() {
    _userOperations.loginFromBase(
      (user) {
        print(user.addresses);
        this.user = user;
        Get.snackbar(
          S.current.welcome,
          "${user.firstname} ${user.lastname}",
          snackPosition: SnackPosition.BOTTOM,
        );

        getDefaultAddress();
        Get.offAll(HomeIndex());
        update();
      },
    );
  }

  register(
      {String firstName,
      String lastName,
      String email,
      String password,
      String confirmPass}) {
    if (password != confirmPass) {
      Helper.showError("Password Mis-match");
    } else {
      _userOperations.createUser(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          confirmpass: confirmPass

          // callback: (user) {
          //   this.user = user;
          //   update();
          //   // Get.offAll(HomeIndex());
          //   // Get.offAll(Otp(data: jsonEncode({"":""}), onVerify: (){}, onResend: (){}));
          // },
          );
    }
  }

  verifyUser({String otp, String regId, String email, String password}) {
    print(regId);
    _userOperations.verifyOtp(
      onResponse: (v) {
        print(regId);
      },
      otp: otp,
      registerID: regId,
      email: email,
      password: password,
      callback: (user) {
        this.user = user;
        update();
        Get.offAll(HomeIndex());
      },
    );
  }

  resendRegisterOTP(String id) {
    _userOperations.resendOTP(id);
  }

  logout() async {
    final store = GetStorage();
    store.remove("store").then((value) => store
        .remove("cookie")
        .then((value) => store.remove("local"))
        .then((value) => store.remove('anony-cookie')));
    user = null;
    update();
    Get.offAll(ConfigurationScreen());
  }

  editProfile(String email, String fullname) {
    Get.back();
  }

  changePassword(String oldpass, String newPass, String confirmPass) {
    _userOperations.changePass({
      "password": oldpass,
      "newPassword": newPass,
      "confirmPassword": confirmPass
    }, logout);
  }

  void getUserOrders({bool completed = false}) {
    resetErrorState();
    if (completed) {
      historyLoading.value = true;
    } else {
      orderLoading.value = true;
    }
    _userOperations
        .getUserOrders(completed, completed ? historyPage.value : page.value,
            (List<Order> data, int count) {
      if (completed) {
        setHistory(data, count);
      } else {
        setOrders(data, count);
      }
      update();
    }, handleError);
  }

  void setOrders(List<Order> data, int count) {
    if (loadingMore.value) {
      if (data.isEmpty) {
        orderHasMore.value = false;
      } else {
        orderHasMore.value = true;
      }
      orders.addAll(data);
    } else {
      orders = data;
      ordersCount = count;
      if (data.length < 20) orderHasMore.value = false;
    }
    if (loadingMore.value) loadingMore.value = false;
    orderLoading.value = false;
  }

  addItems({completed = false}) async {
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        // for (int i = 1; i < 2; i++) {
        historyPage++;
        loadingMore.value = true;
        // listLength++;
        // list.add(Model(name: (listLength).toString()));
        // print(historyPage);
        _userOperations.getUserOrders(
            completed, completed ? historyPage.value : historyPage.value,
            (List<Order> data, int count) {
          if (completed) {
            setHistory(data, count);
          } else {
            if (data.isEmpty) {
              // historyPage.value = 0;
              loadingMore.value = false;
            } else {
              setOrders(data, count);
              print(count);
            }
          }
          update();
        }, handleError);

        update();
        // }
      }
    });
  }

  setHistory(List<Order> data, int count) {
    if (historyLoadingMore.value) {
      if (data.isEmpty) {
        historyHasMore.value = false;
      } else {
        historyHasMore.value = true;
      }
      ordersHistory.addAll(data);
    } else {
      ordersHistory = data;
      ordersHistoryCount = count;
      if (data.length < 20) historyHasMore.value = false;
    }
    if (historyLoadingMore.value) historyLoadingMore.value = false;
    historyLoading.value = false;
  }

  void getRecentlyViewProducts() {
    _userOperations.getRecentlyViewedProducts(
      (data) {
        recentlyViewed = data;
        update();
      },
    );
  }

  void updateRecentlyViewed(String id) {
    _userOperations.updateRecentlyViewedProducts(id, (res) => null);
  }

  bool isLoggedIn() {
    return GetStorage().read("cookie") != null && user != null;
  }

  bool hasToken() {
    return GetStorage().read("cookie") != null ||
        GetStorage().read("anony-cookie") != null;
  }

  askQuestion(String question) {
    // API call goes here
    Get.back();
  }

  // void getDefaultCart() {
  //   resetErrorState();
  //   _userOperations.getAllCartItems((response) {
  //     cartItem.cartItems = response;
  //     update();
  //   }, handleError);
  // }

  void getDefaultAddress() {
    // getAllDeliveryAddresses(){
    _userOperations.getAllAddresses((response) {
      addressCtl.delivery.value = response;
      update();
    }, handleError);
    // }

    // _userOperations.getDefaultAddress((address) {
    //   if (address.id != null) {
    //     // addressCtl.addAddress(address);
    //     // addressCtl.setDeliveryAddress(address, getCost: false);
    //     update();
    //   }
    // }, handleError);
  }

  handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.other:
        connectionError.value = true;
        break;
      case DioErrorType.connectTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.response:
        serverError.value = true;
        break;
      case DioErrorType.cancel:
        canceled.value = true;
        break;
      default:
    }
    update();
  }

  void setNextPage({bool order = true}) {
    if (order) {
      page.value = page.value + 1;
      loadingMore.value = true;
    } else {
      historyPage.value = historyPage.value + 1;
      historyLoadingMore.value = true;
    }
    update();
  }

  void resetPage({int order = 3}) {
    switch (order) {
      case 3:
        resetAll();
        break;
      case 2:
        resetHistory();
        break;
      case 1:
        resetOrder();
        break;
      default:
    }
    update();
  }

  resetHistory() {
    historyPage.value = 1;
    historyLoadingMore.value = false;
    historyHasMore.value = true;
  }

  resetOrder() {
    page.value = 1;
    loadingMore.value = false;
    orderHasMore.value = true;
  }

  resetAll() {
    page.value = 1;
    loadingMore.value = false;
    orderHasMore.value = true;
    historyPage.value = 1;
    historyLoadingMore.value = false;
    historyHasMore.value = true;
  }

  resetErrorState() {
    connectionError.value = false;
    serverError.value = false;
    canceled.value = false;
    update();
  }
}
