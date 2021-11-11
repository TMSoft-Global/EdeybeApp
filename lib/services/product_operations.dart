import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/models/product.dart';
import 'package:edeybe/models/productModel.dart';
import 'package:edeybe/models/ratingModel.dart';
import 'package:edeybe/services/server_operation.dart';
import 'package:edeybe/utils/helper.dart';

class ProductOperation extends ServerOperations {
  final String productsWithFilter = '/products/withFilters?';
  getAllProducts(
      Map<String, String> query,
      void onResponse(List<ProductModel> response),
      void onError(DioError error)) {
    String strQuery = Helper.encodeMap(query);
    dynamicRequest(
      path: "$productsWithFilter$strQuery",
      schema: "",
      method: "GET",
      onError: onError,
      onResponse: (res) {
        var data = (res["results"] as List<dynamic>)
            .map(
                (dynamic i) => ProductModel.fromJson(i as Map<String, dynamic>))
            .toList();
        onResponse(data);
      },
    );
  }

  ratingAndComment(String productId, String comment, double rating,
      String transID, onResponse(Function)) {
    dynamicRequest(
      path: "/ratings-comments/$productId",
      schema: jsonEncode({
        "rating": rating,
        "comment": "$comment",
        "transactionId": "$transID"
      }),
      onResponse: (res) {
        Get.back();

        print(res);
      },
      showDialog: true,
    );
  }

  getratingAndComment(String productId, onResponse(RatingCommentModel res)) {
    dynamicRequest(
      path: "/ratings-comments/$productId",
      method: "GET",
      schema: "",
      onResponse: (onResponse) {
        var data = RatingCommentModel.fromJson(jsonDecode(onResponse));

        onResponse(data);
      },
      showDialog: false,
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

  getAllProductById(String id, void onResponse(ProductModel response),
      void onError(DioError error)) {
    dynamicRequest(
      path: "/product/$id",
      schema: "",
      showDialog: true,
      onError: onError,
      onResponse: (res) {
        var data = ProductModel.fromJson(res as Map<String, dynamic>);
        onResponse(data);
      },
    );
  }

  getMerchantProducts(
      String id,
      int page,
      void onResponse(List<ProductModel> response),
      void onError(DioError error)) {
    dynamicRequest(
      path: "/merchant/store/public/products/$id?skip=$page&limit=20",
      schema: "",
      showDialog: false,
      method: "GET",
      onError: onError,
      onResponse: (res) {
        // var seller = Seller(
        //     id: id,
        //     name: res['success']['companyName'],
        //     photo: res['success']['storeProfilePicture'],
        //     details: res['success']['storeDescription'],
        //     phone: res['success']['phone']);
        var data = (res['success']['merchantProducts']['results']
                as List<dynamic>)
            .map(
                (dynamic i) => ProductModel.fromJson(i as Map<String, dynamic>))
            .toList();
        onResponse(data);
      },
    );
  }

  getProductByID(String id, void onResponse(ProductModel product),
      void onError(DioError error)) {
    print(id);
    dynamicRequest(
        path: "/product/v/$id",
        schema: "",
        onError: onError,
        showDialog: true,
        onResponse: (res) {
          if (res != null) {
            Map<String, dynamic> jsonData = res;
            print(jsonData);
            ProductModel data = ProductModel.fromJson(jsonData);
            onResponse(data);
            // print(res['_id']);
          }
        });
  }

  increaseProductCount(String id, void onResponse(ProductModel response),
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

  getAllProductByCategoryId(
      Map<String, String> category,
      void onResponse(List<ProductModel> response),
      void onError(DioError error)) {
    String strQuery = Helper.encodeMap(category);
    dynamicRequest(
      path: "/products/bycategory/${category["id"]}?$strQuery",
      schema: "",
      onError: onError,
      onResponse: (res) {
        var data = (res['results'] as List<dynamic>)
            .map(
                (dynamic i) => ProductModel.fromJson(i as Map<String, dynamic>))
            .toList();
        onResponse(data);
      },
    );
  }

  getAllProductsById(
      Map<String, String> category,
      void onResponse(List<ProductModel> response),
      void onError(DioError error)) {
    String strQuery = Helper.encodeMap(category);
    dynamicRequest(
      path: "/category/${category["id"]}?$strQuery",
      schema: "",
      onError: onError,
      onResponse: (res) {
        // print(res);
        var data = (res as List<dynamic>)
            .map(
                (dynamic i) => ProductModel.fromJson(i as Map<String, dynamic>))
            .toList();
        onResponse(data);
      },
    );
  }

  getAllProductBySubcategoryId(
      Map<String, String> category,
      void onResponse(List<ProductModel> response),
      void onError(DioError error)) {
    String strQuery = Helper.encodeMap(category);
    dynamicRequest(
      path: "/subcategory/${category["id"]}?$strQuery",
      schema: "",
      onError: onError,
      onResponse: (res) {
        // print(res);
        var data = (res as List<dynamic>)
            .map(
                (dynamic i) => ProductModel.fromJson(i as Map<String, dynamic>))
            .toList();
        onResponse(data);
      },
    );
  }
}
