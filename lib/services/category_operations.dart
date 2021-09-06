import 'package:dio/dio.dart';
import 'package:edeybe/models/category.dart';
import 'package:edeybe/services/server_operation.dart';

class CategoryOperation extends ServerOperations {
  getAllCategories(
      void onResponse(List<Category> response), void onError(DioError error)) {
    dynamicRequest(
      path: "/categories",
      schema: "",
      onError: onError,
      onResponse: (res) {
        var data = (res as List<dynamic>)
            .map((dynamic i) => Category.fromJson(i as Map<String, dynamic>))
            // .sortedByNum((element) => element.id)
            .toList();
        onResponse(data);
      },
    );
  }

  getAllCategoryById(int id, void onResponse(List<Category> response),
      void onError(DioError error)) {
    dynamicRequest(
      path: "/categories/$id",
      schema: "",
      onError: onError,
      onResponse: (res) {
        var data = (res as List<dynamic>)
            .map((dynamic i) => Category.fromJson(i as Map<String, dynamic>))
            // .sortedByNum((element) => element.id)
            .toList();
        onResponse(data);
      },
    );
  }
}
