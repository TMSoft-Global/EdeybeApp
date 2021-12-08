import 'package:dio/dio.dart';
import 'package:edeybe/models/AssetFinanceModel.dart';
import 'package:edeybe/services/server_operation.dart';

class AssetFinanceOperations extends ServerOperations {
  getAllAssetFinanceCompanies(
      void onResponse(List<Financers> response), void onError(DioError error)) {
    dynamicRequest(
      path: "/get-all-asset-financers",
      schema: "",
      method: "GET",
      onError: onError,
      onResponse: (res) {
        print(res);
        var data = (res['data']['financers'] as List<dynamic>)
            .map((dynamic i) => Financers.fromJson(i as Map<String, dynamic>))
            .toList();
        onResponse(data);
      },
    );
  }
}
