import 'package:dio/src/dio_error.dart';
import 'package:edeybe/interface/HTTPErrorHandler.dart';
import 'package:edeybe/models/AssetFinanceModel.dart';
import 'package:edeybe/services/assetFinance_operations.dart';

import '../index.dart';

class AssetFinanceController extends GetxController
    implements HTTPErrorHandler {
  var operations = AssetFinanceOperations();
  var connectionError = false.obs;
  var serverError = false.obs;
  var canceled = false.obs;
  var assetFinance = <Financers>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllAssetCompanies();
    // getCartITems();
  }

  // void getAllAssetCompanies() {
  //   operations.getAllAssetFinanceCompanies((data) {
  //     assetFinance.addAll(data);
  //     update();
  //   }, handleError);
  // }

  getAllAssetCompanies() {
    operations.getAllAssetFinanceCompanies((response) {
      // print(response.length);
      assetFinance.value = response;

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
