import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:edeybe/encryption/encryptData.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/models/deliveryModel.dart';
import 'package:edeybe/models/order.dart';
import 'package:edeybe/models/product.dart';
import 'package:edeybe/models/shippingAddress.dart';
import 'package:edeybe/models/user.dart';
import 'package:edeybe/screens/otp/otp.dart';
import 'package:edeybe/screens/otp/userVerify.dart';
import 'package:edeybe/services/server_operation.dart';
import 'package:edeybe/utils/helper.dart';

class UserOperations extends ServerOperations {
  login(Function(User) callback, {String email, String password}) {
    dynamicRequest(
        path: "/login",
        schema: jsonEncode({"email": "$email", "password": "$password"}),
        onResponse: (res) async {
          await GetStorage().write("cookie", res);
          _getUserInfo(callback);
        },
        showDialog: true);
  }

  forgotPassword(Function() callback, {String email}) {
    dynamicRequest(
        path: "/forgotpassword",
        schema: jsonEncode({"email": "$email"}),
        onResponse: (res) async {
          callback();
        },
        showDialog: true);
  }

  changePass(
    Map<String, String> data,
    Function() callback,
  ) {
    dynamicRequest(
        path: "/changepassword",
        schema: jsonEncode(data),
        onResponse: (res) async {
          callback();
        },
        showDialog: true);
  }

  anontoken() {
    dynamicRequest(
      path: "/anontoken",
      schema: "",
      onResponse: (res) async {
        await GetStorage().write("anony-cookie", res);
      },
    );
  }

  loginFromBase(Function(User) callback) {
    _getUserInfo(callback);
  }

  sendNotificationToken(String token) {
    print(token);
    dynamicRequest(
      path: '/app/m/notification/save-token',
      schema: jsonEncode({"token": "$token"}),
      onResponse: (res) {
        print(res);
      },
    );
  }

  // encryptUser() async{
  //   dynamicRequest (
  //     path: '/send',
  //     schema: jsonEncode({"accountName": await encryptData("Bismark Amo")}),
  //     onResponse: (res) {
  //      print(res);
  //     },

  //   );
  // }

  _getUserInfo(
    Function(User) callback,
  ) {
    dynamicRequest(
      path: "/user",
      schema: "",
      onResponse: (res) {
        User user = User.fromJson(res);
        callback(user);
      },
    );
  }

  getDefaultAddress(
      Function(DeliveryAddress) callback, void onError(DioError error)) {
    dynamicRequest(
      path: "/account/shippingAddress",
      schema: "",
      onError: onError,
      onResponse: (res) {
        var data =
            res != null ? DeliveryAddress.fromJson(res) : DeliveryAddress();
        callback(data);
      },
    );
  }

  getAllCartItems(
      void onResponse(List<Product> response), void onError(DioError error)) {
    dynamicRequest(
      path: "/getcart",
      schema: "",
      onError: onError,
      onResponse: (res) {
        print(res);
        if (res.containsKey("items")) {
          var data = (res["items"] as List<dynamic>)
              .map((dynamic i) => Product.fromJson(i as Map<String, dynamic>))
              // .sortedByNum((element) => element.id)
              .toList();
          onResponse(data);
        }
      },
    );
  }

  getAllAddresses(void onResponse(List<DeliveryAddress> response),
      void onError(DioError error)) {
    dynamicRequest(
      path: '/account/deliveryaddresses',
      schema: "",
      method: "GET",
      onError: onError,
      onResponse: (res) {
        // onResponse(res);
        var data = (res['success']['shippingAddress']['deliveryAddresses']
                as List<dynamic>)
            .map((dynamic i) =>
                DeliveryAddress.fromJson(i as Map<String, dynamic>))
            .toList();
        onResponse(data);
        // var data = (res['success']['shippingAddress']);
      },
    );
  }

  getUserOrders(bool completed, int page, Function(List<Order>, int) callback,
      void onError(DioError error)) {
    print(page);
    dynamicRequest(
      path: "/account/orders/get${completed ? "history" : "orders"}?skip=$page",
      schema: "",
      method: "GET",
      onError: onError,
      onResponse: (res) {
        print(res["results"]);
        var data = (res["results"] as List<dynamic>)
            .map((dynamic i) => Order.fromJson(i as Map<String, dynamic>))
            .toList();
        callback(data, res["totalPossible"] as int);
      },
    );
  }

  getRecentlyViewedProducts(Function(dynamic) callback) {
    dynamicRequest(
      path: "/account/recently_viewed/get",
      schema: "",
      method: "GET",
      onResponse: (res) {
        dynamic data = res;
        callback(data);
      },
    );
  }

  updateRecentlyViewedProducts(String id, Function(dynamic) callback) {
    dynamicRequest(
      path: "/account/recently_viewed/add",
      schema: "{'productId':$id}",
      onResponse: (res) {
        dynamic data = res;
        callback(data);
      },
    );
  }

  createUser(
      {String firstName,
      String lastName,
      String email,
      String password,
      String confirmpass}) {
    dynamicRequest(
        path: "/register",
        schema:
            '{"firstName": "$firstName" ,"lastName": "$lastName", "email": "$email" ,"password": "$password","confirmPassword":"$confirmpass"}',
        onResponse: (res) async {
          print(res);
          if (res.containsKey("success")) {
            Get.offAll(
              OtpVerification(
                phone: email,
                timer: res['success']['otpExpiresIn'],
                id: res['success']['id'],
                password: password,
              ),
            );
            // onResponse(res);
          }
        },
        showDialog: true);
  }

  resendOTP(String registrationId) {
    print(registrationId);
    dynamicRequest(
      path: "/complete-registration/otp",
      schema: jsonEncode({"registrationId": "$registrationId"}),
      onResponse: (res) {
        print(res);
        // Helper.handler("Success", res['message']);
      },
      showDialog: true,
    );
  }

  verifyOtp(
      {String otp,
      String registerID,
      String email,
      String password,
      Function(dynamic) onResponse,
      Function(User) callback}) {
    dynamicRequest(
      path: "/complete-registration",
      schema: jsonEncode({"otp": "$otp", "registrationId": "$registerID"}),
      onResponse: (res) {
        print(res);
        login(callback, email: email, password: password);
      },
      showDialog: true,
    );
  }
}
