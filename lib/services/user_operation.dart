import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/models/deliveryModel.dart';
import 'package:edeybe/models/order.dart';
import 'package:edeybe/models/shippingAddress.dart';
import 'package:edeybe/models/user.dart';
import 'package:edeybe/services/server_operation.dart';

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
      Function(ShippingAddress) callback, void onError(DioError error)) {
    dynamicRequest(
      path: "/account/shippingAddress",
      schema: "",
      onError: onError,
      onResponse: (res) {
        var data = res["firstName"] != null
            ? ShippingAddress.fromJson(res)
            : ShippingAddress();
        callback(data);
      },
    );
  }

  getUserOrders(bool completed, int page, Function(List<Order>, int) callback,
      void onError(DioError error)) {
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
      Function(User) callback}) {
    dynamicRequest(
        path: "/register",
        schema:
            '{ "firstName": "$firstName" ,"lastName": "$lastName", "email": "$email" ,"password": "$password","confirmPassword":"$password"}',
        onResponse: (res) async {
          login(callback, email: email, password: password);
        },
        showDialog: true);
  }
}
