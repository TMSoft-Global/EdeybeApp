import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edeybe/models/product.dart';
import 'package:edeybe/services/server_operation.dart';

class SearchOperation extends ServerOperations {
  searchProducts(String query, void onResponse(List<Product> response),
      void onError(DioError error)) {
    dynamicRequest(
      path: "/search",
      schema: jsonEncode({"searchword": query}),
      onError: onError,
      onResponse: (res) {
        var data = (res as List<dynamic>)
            .map((dynamic i) => Product.fromJson(i as Map<String, dynamic>))
            // .sortedByNum((element) => element.id)
            .toList();
        onResponse(data);
      },
    );
  }
}
