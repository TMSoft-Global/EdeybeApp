import 'package:dio/dio.dart';
import 'package:edeybe/controllers/user_controller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/interface/HTTPErrorHandler.dart';
import 'package:edeybe/models/product.dart';
import 'package:edeybe/models/user.dart';
import 'package:edeybe/services/product_operations.dart';
import 'package:flutter/material.dart';

class ProductController extends GetxController implements HTTPErrorHandler {
  User user;
  var operations = ProductOperation();
  var product = Product().obs;
  var products = <Product>[].obs;
  var merchantProducts = <Product>[].obs;
  var loading = false.obs;
  var loadingMore = false.obs;
  var page = 1.obs;
  var merchantPage = 1.obs;
  var hasMore = true.obs;
  var connectionError = false.obs;
  var serverError = false.obs;
  var seller = Seller().obs;
  var canceled = false.obs;
  Map<String, String> queryMap = {'limit': '20'};
  var homeProducts = Map<String, List<Product>>().obs;
  writeReview(double rating, String message) {
    update();
  }

  // @override
  // void onInit() {
  //   Future.delayed(Duration(seconds: 1), () {
  //     getAllProducts();
  //   });
  // }
  Map<String, String> buildQuery() {
    queryMap['skip'] = page.value.toString();
    return queryMap;
  }

  void setNextPage({bool isMerchant = false}) {
    if (isMerchant) {
      merchantPage.value = merchantPage.value + 1;
    } else {
      page.value = page.value + 1;
    }
    loadingMore.value = true;
    update();
  }

  void resetPage() {
    page.value = 1;
    loadingMore.value = false;
    hasMore.value = true;
    update();
  }

  void getAllProducts({Map<String, String> queryOption}) {
    loading.value = true;
    resetErrorState();
    if (queryOption != null) {
      queryOption.addAll(buildQuery());
    } else {
      queryOption = buildQuery();
    }
    operations.getAllProducts(queryOption, (response) {
      if (loadingMore.value) {
        if (response.isEmpty) {
          hasMore.value = false;
        } else {
          hasMore.value = true;
        }
        products.addAll(response);
      } else {
        products.value = response;
        if (response.length < 20) hasMore.value = false;
      }
      loading.value = false;
      if (loadingMore.value) loadingMore.value = false;
      update();
    }, handleError);
  }

  getTotalPossible(
      {Map<String, String> queryOption, @required Function(int res) then}) {
    resetErrorState();
    if (queryOption != null) {
      queryOption.addAll(buildQuery());
    } else {
      queryOption = buildQuery();
    }
    operations.getTotalPossible(queryOption, (int response) {
      then(response);
    }, handleError);
  }

  void resetMerchantProducts() {
    merchantProducts.value = <Product>[];
    seller.value = Seller();
    merchantPage.value = 1;
  }

  void resetProducts() {
    products.value = <Product>[];
    page.value = 1;
    queryMap = {'limit': '20'};
    resetPage();
  }

  String sortValue() {
    return queryMap['sort'];
  }

  void getProductbyId(String id) {
    resetErrorState();
    operations.getAllProductById(id, (response) {
      product.value = response;
      increaseViewCount(id);
      update();
    }, handleError);
  }

  void getProductsByCategoryId(Map<String, String> cat) {
    loading.value = true;
    resetErrorState();
    if (cat != null) {
      cat.addAll(buildQuery());
    } else {
      cat = buildQuery();
    }
    operations.getAllProductByCategoryId(cat, (response) {
      if (loadingMore.value) {
        if (response.isEmpty) {
          hasMore.value = false;
        } else {
          hasMore.value = true;
        }
        products.addAll(response);
      } else {
        products.value = response;
        if (response.length < 20) hasMore.value = false;
      }
      loading.value = false;
      if (loadingMore.value) loadingMore.value = false;
      update();
    }, handleError);
  }

  void getProductsById(Map<String, String> cat) {
    loading.value = true;
    resetErrorState();
    if (cat != null) {
      cat.addAll(buildQuery());
    } else {
      cat = buildQuery();
    }
    operations.getAllProductsById(cat, (response) {
      homeProducts.putIfAbsent(cat["name"], () => response);
      loading.value = false;
      if (loadingMore.value) loadingMore.value = false;
      update();
    }, handleError);
  }

  void getProductsBySubcategoryId(Map<String, String> cat) {
    loading.value = true;
    resetErrorState();
    if (cat != null) {
      cat.addAll(buildQuery());
    } else {
      cat = buildQuery();
    }
    operations.getAllProductBySubcategoryId(cat, (response) {
      if (loadingMore.value) {
        if (response.isEmpty) {
          hasMore.value = false;
        } else {
          hasMore.value = true;
        }
        products.addAll(response);
      } else {
        products.value = response;
        if (response.length < 20) hasMore.value = false;
      }
      loading.value = false;
      if (loadingMore.value) loadingMore.value = false;
      update();
    }, handleError);
  }

  void getProductsByCollectionIds(collection) {
    // operations.getAllProductByCollectionId(collection, (response) {
    //   products.value = response;
    //   update();
    // });
  }
  void getMerchantProducts(String id) {
    loading.value = true;
    resetErrorState();
    operations.getMerchantProducts(id, page.value, (response, store) {
      if (loadingMore.value) {
        if (response.isEmpty) {
          hasMore.value = false;
        } else {
          hasMore.value = true;
        }
        merchantProducts.addAll(response);
      } else {
        merchantProducts.value = response;
        if (response.length < 20) hasMore.value = false;
      }
      seller.value = store;
      loading.value = false;
      if (loadingMore.value) loadingMore.value = false;
      update();
    }, handleError);
  }

  setInViewProduct(Product p) {
    product.value = p;
    update();
  }

  setQuantity(int newQTY) {
    var prod = product.value.setQuantity(newQTY);
    product.value = prod;
    // update();
  }

  void setQuery(String key, String value,
      {bool reset = false, Map<String, String> data, bool merge = false}) {
    if (reset) {
      if (data != null) {
        if (merge) {
          queryMap.addAll(data);
        } else {
          queryMap = data;
        }
      } else {
        queryMap = {};
      }
    } else {
      queryMap[key] = value;
    }
    update();
  }

  void increaseViewCount(String id) {
    resetErrorState();
    final userCtl = UserController();
    if (userCtl.isLoggedIn()) {
      userCtl.updateRecentlyViewed(id);
    } else {
      operations.increaseProductCount(id, (response) => null, handleError);
    }
  }

  resetErrorState() {
    connectionError.value = false;
    serverError.value = false;
    canceled.value = false;
    update();
  }

  selecttDeliveryLocation() {}
  setConfigurableOption() {}
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
