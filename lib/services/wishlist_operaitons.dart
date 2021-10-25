import 'dart:convert';

import 'package:edeybe/models/product.dart';
import 'package:edeybe/models/productModel.dart';
import 'package:edeybe/services/server_operation.dart';

class WishlistOperation extends ServerOperations {
  getSavedWishlist(void onResponse(List<ProductModel> response)) {
    dynamicRequest(
      path: "/favourites/get",
      schema: '{"id":"434"}',
      method: "POST",
      onResponse: (res) {
        if (res != null) {
          var data = (res as List<dynamic>)
              .map((dynamic i) => ProductModel.fromJson(i as Map<String, dynamic>))
              // .sortedByNum((element) => element.id)
              .toList();
          onResponse(data);
        }
      },
    );
  }

  updateWishlist(
      Map<String, dynamic> data, void onResponse(List<ProductModel> response)) {
    dynamicRequest(
      path: "/favourites/update",
      schema: jsonEncode(data),
      method: "POST",
      showDialog: true,
      onResponse: (res) {
        getSavedWishlist((rs) {
          onResponse(rs);
        });
      },
    );
  }
}
