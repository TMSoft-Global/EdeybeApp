// ignore_for_file: avoid_classes_with_only_static_members

import 'package:edeybe/controllers/cart_controller.dart';
import 'package:edeybe/controllers/wishlist_controller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/models/productModel.dart';
import 'package:edeybe/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';

class Helper {
  static showError(message) {
    Get.snackbar(
      "error",
      "$message",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static bool isFavourite(String id, WishlistController _wishlistController) {
    var inFav = _wishlistController.wishlistItems
        .firstWhere((product) => product.productId == id, orElse: () => ProductModel());
    return inFav.productId != null;
  }

   static bool isIncart(String id, CartController _cartController) {
    var inFav = _cartController.cartItems
        .firstWhere((product) => product.productId == id, orElse: () => ProductModel());
    return inFav.productId != null;
  }

  static Future<bool> signInRequired(String message, Function() onSign) {
    return Get.dialog<bool>(CustomDialog(
      title: S.current.signIn,
      content: message,
      confrimPressed: () {
        Get.back(result: true);
        if (onSign != null) onSign();
      },
      cancelText: S.current.cancel,
      confrimText: S.current.signIn,
    ));
  }

  static Widget get textPlaceholder {
    return Container(
      height: 15.w,
      width: 100.w,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  static String encodeMap(
    data, {
    bool encode = true,
    Function(String key, Object value) handler = handler,
  }) {
    var urlData = StringBuffer('');
    var first = true;
    var leftBracket = encode ? '%5B' : '[';
    var rightBracket = encode ? '%5D' : ']';
    var encodeComponent = encode ? Uri.encodeQueryComponent : (e) => e;
    void urlEncode(dynamic sub, String path) {
      if (sub is List) {
        for (var i = 0; i < sub.length; i++) {
          urlEncode(sub[i],
              '$path$leftBracket${(sub[i] is Map || sub[i] is List) ? i : ''}$rightBracket');
        }
      } else if (sub is Map) {
        sub.forEach((k, v) {
          if (path == '') {
            urlEncode(v, '${encodeComponent(k)}');
          } else {
            urlEncode(v, '$path$leftBracket${encodeComponent(k)}$rightBracket');
          }
        });
      } else {
        var str = handler(path, sub);
        var isNotEmpty = str != null && str.trim().isNotEmpty;
        if (!first && isNotEmpty) {
          urlData.write('&');
        }
        first = false;
        if (isNotEmpty) {
          urlData.write(str);
        }
      }
    }

    urlEncode(data, '');
    return urlData.toString();
  }

  static String handler(String key, Object value) {
    if (value == null) return '';
    return '$key=${Uri.encodeQueryComponent(value.toString())}';
  }

  static String validateEmail(String text) {
    final emailRegex = new RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
    if (text.isEmpty) {
      return "Email Field is required";
    } else if (emailRegex.hasMatch(text)) {
      return null;
    } else {
      return "Email is not valid";
    }
  }

  static String validateMobileNumber(String text) {
    final mobileNumberRegex = new RegExp(r'^(?:[25][0-9])?[0-9]{9}$');
    if (text.isEmpty) {
      return "Mobile number Field is required";
    } else if (mobileNumberRegex.hasMatch(text)) {
      return null;
    } else {
      return "Mobile number is not valid";
    }
  }

  static String validateMobileNumberStrict(String text) {
    final mobileNumberRegex = new RegExp(r'^(?:[+0][25])?[0-9]{10}$');
    if (text.isEmpty) {
      return "Mobile number Field is required";
    } else if (mobileNumberRegex.hasMatch(text)) {
      return null;
    } else {
      return "Mobile number must be 10 digits";
    }
  }
}
