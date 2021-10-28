import 'package:dio/dio.dart';
import 'package:edeybe/controllers/cart_controller.dart';
import 'package:edeybe/controllers/home_controller.dart';
import 'package:edeybe/controllers/user_controller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/interface/HTTPErrorHandler.dart';
import 'package:edeybe/models/productModel.dart';
import 'package:edeybe/services/wishlist_operaitons.dart';
import 'package:intl/intl.dart';
import 'package:edeybe/models/product.dart';
import 'package:edeybe/models/user.dart';

// import 'package:edeybe/services/user_operation.dart';

class WishlistController extends GetxController implements HTTPErrorHandler {
  User user;
  var operations = WishlistOperation();
  final formatCurrency = new NumberFormat.simpleCurrency(name: "");
  var wishlistItems = <ProductModel>[].obs;
  var loading = false.obs;
  var connectionError = false.obs;
  var serverError = false.obs;
  var canceled = false.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(milliseconds: 500), getWishlist);
  }

  getWishlist() {
    if (Get.find<UserController>().hasToken()) {
      loading.value = true;
      operations.getSavedWishlist((response) {
        wishlistItems.value = [];
        wishlistItems.addAll(response);
        loading.value = false;
        update();
      });
    }
  }

  addToWishlist(ProductModel item, Function callback) {
    print(item.productName);
    Map<String, dynamic> items = {"items": []};
    var inList =
        wishlistItems.firstWhere((p) => p.productId == item.productId, orElse: () => null);
    if (inList != null) {
      wishlistItems.removeWhere((p) => p.productId == item.productId);
    } else {
      items["items"].add(item.productId);
    }

    wishlistItems.forEach((item) => items["items"].add(item.productId));
    operations.updateWishlist(items, (response) {
      wishlistItems.value = [];
      wishlistItems.addAll(response);
      update();
      Get.find<HomeController>().updateView();
      callback(title: inList != null ? "Item removed from wishlist" : inList);
    });
  }

  removeFromWishlist(int index) {
    Map<String, dynamic> data = {"items": []};
    var removedCopy = List<ProductModel>.from(wishlistItems);
    var removedItem = removedCopy.removeAt(index);
    if (removedItem != null) {
      removedCopy.forEach((product) => data["items"].add(product.productId));
    }
    operations.updateWishlist(data, (response) {
      wishlistItems.value = [];
      wishlistItems.addAll(removedCopy);
      update();
    });
  }

  moveToCart(int index, Function() calback) {
    Map<String, dynamic> data = {"items": []};
    var removedCopy = List<ProductModel>.from(wishlistItems);
    var removedItem = removedCopy.removeAt(index);
    if (removedItem != null) {
      removedCopy.forEach((product) => data["items"].add(product.productId));
    }
    operations.updateWishlist(data, (response) {
      wishlistItems.value = [];
      wishlistItems.addAll(removedCopy);
      Get.find<CartController>().addToCart(removedItem, calback);
      update();
    });
  }

  setQuantity(int productIndex, int newQTY) {
    var item = wishlistItems[productIndex].setQuantity(newQTY);
    wishlistItems[productIndex] = item;
    update();
  }

  searchWishlist() {}

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
}
