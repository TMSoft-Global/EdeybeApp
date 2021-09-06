import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edeybe/models/product.dart';
import 'package:edeybe/services/server_operation.dart';
import 'package:edeybe/utils/helper.dart';

class ProductOperation extends ServerOperations {
  final String productsWithFilter = '/products/withFilters?';
  getAllProducts(Map<String, String> query,
      void onResponse(List<Product> response), void onError(DioError error)) {
    String strQuery = Helper.encodeMap(query);
    dynamicRequest(
      path: "$productsWithFilter$strQuery",
      schema: "",
      method: "GET",
      onError: onError,
      onResponse: (res) {
        var data = (res["results"] as List<dynamic>)
            .map((dynamic i) => Product.fromJson(i as Map<String, dynamic>))
            .toList();
        onResponse(data);
      },
    );
  }

  getTotalPossible(Map<String, String> query, void onResponse(int response),
      void onError(DioError error)) {
    String strQuery = Helper.encodeMap(query);
    dynamicRequest(
      path: "$productsWithFilter$strQuery",
      schema: "",
      method: "GET",
      onError: onError,
      onResponse: (res) {
        onResponse(res['totalPossible'] as int);
      },
    );
  }

  getAllProductById(String id, void onResponse(Product response),
      void onError(DioError error)) {
    dynamicRequest(
      path: "/product/$id",
      schema: "",
      showDialog: true,
      onError: onError,
      onResponse: (res) {
        var data = Product.fromJson(res as Map<String, dynamic>);
        onResponse(data);
      },
    );
  }

  getMerchantProducts(
      String id,
      int page,
      void onResponse(List<Product> response, Seller seller),
      void onError(DioError error)) {
    dynamicRequest(
      path: "/merchant/store/public/products/$id?skip=$page&limit=20",
      schema: "",
      showDialog: false,
      method: "GET",
      onError: onError,
      onResponse: (res) {
        var seller = Seller(
            id: id,
            name: res['success']['companyName'],
            photo: res['success']['storeProfilePicture'],
            details: res['success']['storeDescription'],
            phone: res['success']['phone']);
        var data =
            (res['success']['merchantProducts']['results'] as List<dynamic>)
                .map((dynamic i) => Product.fromJson(i as Map<String, dynamic>))
                .toList();
        onResponse(data, seller);
      },
    );
  }

  increaseProductCount(String id, void onResponse(Product response),
      void onError(DioError error)) {
    dynamicRequest(
      path: "/products/viewcount/inc",
      schema: jsonEncode({"productId": id}),
      onError: onError,
      onResponse: (res) {
        // var data = Product.fromJson(res as Map<String, dynamic>);
        // // .sortedByNum((element) => element.id)
        // onResponse(data);
      },
    );
  }

  getAllProductByCategoryId(Map<String, String> category,
      void onResponse(List<Product> response), void onError(DioError error)) {
    String strQuery = Helper.encodeMap(category);
    dynamicRequest(
      path: "/products/bycategory/${category["id"]}?$strQuery",
      schema: "",
      onError: onError,
      onResponse: (res) {
        var data = (res['results'] as List<dynamic>)
            .map((dynamic i) => Product.fromJson(i as Map<String, dynamic>))
            .toList();
        onResponse(data);
      },
    );
  }

  getAllProductsById(Map<String, String> category,
      void onResponse(List<Product> response), void onError(DioError error)) {
    String strQuery = Helper.encodeMap(category);
    dynamicRequest(
      path: "/category/${category["id"]}?$strQuery",
      schema: "",
      onError: onError,
      onResponse: (res) {
        // print(res);
        var data = (res as List<dynamic>)
            .map((dynamic i) => Product.fromJson(i as Map<String, dynamic>))
            .toList();
        onResponse(data);
      },
    );
  }

  getAllProductBySubcategoryId(Map<String, String> category,
      void onResponse(List<Product> response), void onError(DioError error)) {
    String strQuery = Helper.encodeMap(category);
    dynamicRequest(
      path: "/subcategory/${category["id"]}?$strQuery",
      schema: "",
      onError: onError,
      onResponse: (res) {
        // print(res);
        var data = (res as List<dynamic>)
            .map((dynamic i) => Product.fromJson(i as Map<String, dynamic>))
            .toList();
        onResponse(data);
      },
    );
  }
}
