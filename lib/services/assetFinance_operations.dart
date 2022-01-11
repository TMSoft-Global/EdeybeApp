import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edeybe/models/AssetFinanceBreakdownModel.dart';
import 'package:edeybe/models/AssetFinancersModel.dart';
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

  void breakdownAssetFinance(
      List<Map<String, dynamic>> data,
      String financerID,
      void onResponse(List<Breakdown> response),
      void onError(DioError error)) {
    dynamicRequest(
      path: "/break-down-asset-financing",
      schema: jsonEncode({"products": data, "financerId": financerID}),
      onError: onError,
      onResponse: (res) {
        print(res);
        var data = (res['data'] as List<dynamic>)
            .map((dynamic i) =>
                Breakdown.fromJson(i as Map<String, dynamic>))
            .toList();
        onResponse(data);
      },
    );
  }
}
