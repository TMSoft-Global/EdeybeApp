import 'package:dio/src/dio_error.dart';
import 'package:edeybe/interface/HTTPErrorHandler.dart';
import 'package:edeybe/models/AssetFinanceBreakdownModel.dart';
import 'package:edeybe/models/AssetFinancersModel.dart';
import 'package:edeybe/services/assetFinance_operations.dart';

import '../index.dart';

class AssetFinanceController extends GetxController
    implements HTTPErrorHandler {
  var operations = AssetFinanceOperations();
  var connectionError = false.obs;
  var serverError = false.obs;
  var canceled = false.obs;
  var assetFinance = <Financers>[].obs;
  var assetFinanceBreakDown = <Breakdown>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllAssetCompanies();
  }

  getAllAssetCompanies() {
    operations.getAllAssetFinanceCompanies((response) {
      assetFinance.value = response;
      update();
    }, handleError);
  }

   getAssetBreakDown(List<Map<String, dynamic>> data,String financerID, onRes(dynamic)) {
    operations.breakdownAssetFinance(data,financerID,(response) {
      assetFinanceBreakDown.value = response;
      onRes("success");
      update();
    }, handleError);
  }



  @override
  handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.other:
        connectionError.value = true;
        break;
      case DioErrorType.connectTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
        // case DioErrorType.response:
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
