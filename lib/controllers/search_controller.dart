import 'package:dio/dio.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/interface/HTTPErrorHandler.dart';
import 'package:edeybe/models/product.dart';
import 'package:edeybe/services/search_operation.dart';
import 'package:edeybe/widgets/product_card_landscape.dart';
import 'package:flutter/material.dart';

class SearchController extends GetxController implements HTTPErrorHandler {
  var operations = SearchOperation();
  var products = <Product>[].obs;
  var queryTxt = "".obs;
  var searching = false.obs;
  var connectionError = false.obs;
  var serverError = false.obs;
  var canceled = false.obs;

  GlobalKey<AnimatedListState> listKey = GlobalKey();
  void searchProducts(String query) {
    queryTxt.value = query;
    searching.value = true;
    products.value = [];
    operations.searchProducts(query, (response) {
      searching.value = false;
      update();
      if (response.isEmpty) products.value = response;
      for (var i = 0; i < response.length; i++) {
        Future(() {}).then((_) {
          return Future.delayed(Duration(milliseconds: 100), () {
            products.add(response[i]);
            listKey.currentState.insertItem(i);
            update();
          });
        });
      }
    }, handleError);
  }

  void setListkey(GlobalKey<AnimatedListState> key) => listKey = key;
  void cancel() {
    clearText();
    products.value = <Product>[].obs;
    update();
  }

  void clearText() => queryTxt.value = "";
  void clear({bool clearSearchText = true}) {
    if (clearSearchText) clearText();
    for (var i = products.length - 1; i >= 0; i--) {
      Future(() {}).then((_) {
        var p = products[i];
        double off = double.parse("${21 + i}");
        return Future.delayed(Duration(milliseconds: 500), () {
          listKey.currentState.removeItem(
              i,
              (context, animation) => SlideTransition(
                    position:
                        Tween<Offset>(begin: Offset(off, 0), end: Offset(0, 0))
                            .animate(CurvedAnimation(
                                parent: animation,
                                curve: Curves.bounceIn,
                                reverseCurve: Curves.bounceOut)),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5.w),
                      child: ProductCardLandscape(
                        title: p.name,
                        image: p.image,
                        discount: p.priceRange.minimumPrice.discount.percentOff,
                        price: p.priceRange.minimumPrice.finalPrice.value,
                        oldPrice: p.priceRange.minimumPrice.regularPrice.value,
                        onAddToWishList: () => null,
                        onViewDetails: null,
                        isFav: false,
                        rating: 5.0,
                        raters: 23,
                      ),
                    ),
                  ));
          products.removeAt(i);
          update();
        });
      });
    }
    // products.value = List<Product>().obs;
    // update();
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
}
