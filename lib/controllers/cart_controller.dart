import 'package:dio/dio.dart';
import 'package:edeybe/controllers/address_controller.dart';
import 'package:edeybe/controllers/user_controller.dart';
import 'package:edeybe/controllers/wishlist_controller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/interface/HTTPErrorHandler.dart';
import 'package:edeybe/models/deliveryCost.dart';
import 'package:edeybe/models/productModel.dart';
import 'package:edeybe/models/user.dart';
import 'package:edeybe/services/cart_operation.dart';

class CartController extends GetxController implements HTTPErrorHandler {
  User user;
  var coupon = "".obs;
  var cartItems = <ProductModel>[].obs;
  var operations = CartOperation();
  var deliveryCost = DeliveryCost();
  var cartCost = ProductCost();
  var connectionError = false.obs;
  var serverError = false.obs;
  // var addressCtl = Get.find<AddressController>();
  var canceled = false.obs;
  @override
  void onInit() {
    // Future.delayed(Duration(milliseconds: 500), () {
    if (Get.find<UserController>().hasToken()) getCartITems();
    // });
    super.onInit();
  }

  addToCart(ProductModel p, Function callback, {String variantID}) {
    resetErrorState();
    print(variantID);
    Map<String, dynamic> items = {};
    var inList = cartItems.firstWhere((pp) => pp.productId == p.productId,
        orElse: () => null);
    if (inList != null) {
      cartItems.removeWhere((pp) => pp.productId == p.productId);
    } else {
      items = {
        "items": variantID == null
            ? {
                "${p.productId}": {"quantity": p.quantity}
              }
            : {
                "${p.productId}_$variantID": {"quantity": p.quantity}
              }
      };
    }
    cartItems.forEach((item) {
      items["items"][item.productId] = {"quantity": item.quantity};
    });
    operations.updateCart(items, (response) {
      cartItems.add(p);
      update();
      callback(title: inList != null ? "Item removed from cart" : inList);
    }, handleError);
  }

  getCartITems() {
    resetErrorState();
    operations.getAllCartItems(
        (response) {
          print(response.length);
          cartItems.value = response;

          update();
        },
        handleError,
        (val) {
          cartCost = val;
          update();
        });
  }

  clearCartPrice() {
    cartCost = ProductCost();
  }

  getGhanaPostAddress(String code) {
    resetErrorState();
    operations.getDigitalAddress(code, (response) {
      update();
    }, handleError);
  }

  getClosestAddress(Map<String, double> code) {
    resetErrorState();
    operations.getClossestAddress(code, (response) {
      update();
    }, handleError);
  }

  resetErrorState() {
    connectionError.value = false;
    serverError.value = false;
    canceled.value = false;
    update();
  }

  removeFromCart(int index) {
    resetErrorState();
    Map<String, dynamic> data = {"items": {}};
    var removedCopy = List<ProductModel>.from(cartItems);
    var removedItem = removedCopy.removeAt(index);
    if (removedItem != null) {
      removedCopy.forEach((item) {
        data["items"][item.productId] = {"quantity": item.quantity};
      });
      operations.updateCart(data, (response) {
        cartItems.value = removedCopy;
        update();
      }, handleError);
    }
  }

  moveToWishlist(int index, Function() callback) {
    // ignore: todo
    //TODO: Add Wishlist Constroller and item to wishlist
    var movableProduct = cartItems.removeAt(index);
    Get.find<WishlistController>().addToWishlist(movableProduct, callback);
  }

  setQuantity(int productIndex, int newQTY, String proID,{String variantID}) {
    Map<String, dynamic> items = {};

    var item = cartItems[productIndex].setQuantity(newQTY);
    cartItems[productIndex] = item;
    items = {
      "items": variantID == null
          ? {
              "${item.productId}": {"quantity": item.quantity}
            }
          : {
              "${item.productId}_${item.selectedVariant}": {
                "quantity": item.quantity
              }
            }
    };
    cartItems.forEach((item) {
      if (proID == item.productId) {
        items["items"][item.productId] = {"quantity": newQTY};
      } else {
        items["items"][item.productId] = {"quantity": item.quantity};
      }
    });
    operations.updateCart(items, (response) {
      getCartITems();
      update();
    }, handleError);
    print(items);

    update();
  }

  increaseItem({int newQTY, String proID}) {
    print("object");
    // operations.updateCart({
    //   "items": {
    //     "$proID": {"quantity": newQTY}
    //   }
    // }, (response) {
    //   cartItems.addAll(response);
    //   getCartITems();
    //   update();
    // }, handleError);
  }

  applyCoupon(String couponValue) {
    coupon.value = couponValue;
    update();
  }

  void getDeliveryCost() {
    // operations.getDeliveryCost(addressCtl.selectedAddress.deliveryAddresses.t,
    //     (cost) {
    //   deliveryCost = cost;
    //   update();
    // }, handleError);
  }

  void checkout(Map<String, dynamic> data, void callback(dynamic data)) {
    print(data);
    operations.checkoutRequest(
        schema: data, onResponse: callback, onError: callback);
  }

  void checkOrderStatus(
      Map<String, dynamic> data, void callback(Map<String, dynamic> data)) {
    operations.checkOrderStatus(data, callback, handleError);
  }

  searchCart() {}
  handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.other:
        connectionError.value = true;
        break;
      case DioErrorType.connectTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
        // case DioErrorType.response:
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
