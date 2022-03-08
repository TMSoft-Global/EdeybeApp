import 'package:dio/dio.dart';
import 'package:edeybe/models/bannerModel.dart';
import 'package:edeybe/models/categoryCollection.dart';
import 'package:edeybe/models/productCollection.dart';
import 'package:edeybe/models/productModel.dart';
import 'package:edeybe/services/server_operation.dart';

class HomeOperation extends ServerOperations {
  getPromotions(void onResponse(List<ProductModel> response),
      void onError(DioError error)) {
    dynamicRequest(
      path: "/products",
      schema: "",
      onError: onError,
      onResponse: (res) {
        var data = (res as List<dynamic>)
            .map(
                (dynamic i) => ProductModel.fromJson(i as Map<String, dynamic>))
            // .sortedByNum((element) => element.id)
            .toList();
        onResponse(data);
      },
    );
  }

  getAvailableSlugs(
      void onResponse(List<String> response), void onError(DioError error)) {
    dynamicRequest(
      path: "/collections/available",
      method: "GET",
      schema: "",
      onError: onError,
      onResponse: (res) {
        var data =
            (res as List<dynamic>).map((dynamic i) => i as String).toList();
        onResponse(data);
      },
    );
  }

  getHomeBanner(
      void onResponse(BannerModel response), void onError(DioError error)) {
    dynamicRequest(
      path: '/banners',
      schema: "",
      method: 'GET',
      onResponse: (res) {
        if (res != null) {
          onResponse(BannerModel.fromJson(res));
        }
      },
    );
  }

  getAvailableCategoryCollection(
      void onResponse(List<String> response), void onError(DioError error)) {
    dynamicRequest(
      path: "/product-categories/available",
      method: "GET",
      schema: "",
      onError: onError,
      onResponse: (res) {
        var data =
            (res as List<dynamic>).map((dynamic i) => i as String).toList();
        onResponse(data);
      },
    );
  }

  getAllProductByCategoryIds(
      List<String> category,
      void onResponse(List<CatergoryCollection> response),
      void onError(DioError error)) {
    var str = category.fold(
        "",
        (previousValue, element) =>
            previousValue +
            "${previousValue.length > 0 ? "&" : ""}slug_in=" +
            element +
            "&");
    dynamicRequest(
      path: "/product-categories?$str",
      schema: "",
      method: "GET",
      onError: onError,
      onResponse: (res) {
        var data = (res as List<dynamic>)
            .map((dynamic i) =>
                CatergoryCollection.fromJson(i as Map<String, dynamic>))
            .toList();
        onResponse(data);
      },
    );
  }

  getAllProductBySlugId(
      List<String> category,
      void onResponse(List<SlugCollection> response),
      void onError(DioError error)) {
    var str = category.fold(
        "",
        (previousValue, element) =>
            previousValue +
            "${previousValue.length > 0 ? "&" : ""}slug_in=" +
            element +
            "&");

    dynamicRequest(
      path: "/collections?$str",
      schema: "",
      method: "GET",
      onError: onError,
      onResponse: (res) {
        // print(res);
        var data = (res as List<dynamic>)
            .map((dynamic i) =>
                SlugCollection.fromJson(i as Map<String, dynamic>))
            .toList();
        onResponse(data);
      },
    );
  }
}
