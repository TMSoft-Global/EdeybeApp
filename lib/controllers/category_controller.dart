import 'package:dio/dio.dart';
import 'package:edeybe/controllers/product_controller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/interface/HTTPErrorHandler.dart';
import 'package:edeybe/models/category.dart';
import 'package:edeybe/models/subcategory.dart';
import 'package:edeybe/services/category_operations.dart';

class CategoryController extends GetxController implements HTTPErrorHandler {
  var operations = CategoryOperation();
  final productController = Get.find<ProductController>();
  var categories = <Category>[].obs;
  String selectedParent = "";
  String selectedChild = "";
  var loading = false.obs;
  var subCategories = <SubCategory>[].obs;
  var connectionError = false.obs;
  var serverError = false.obs;
  var canceled = false.obs;

  @override
  void onInit() {
    // Future.delayed(Duration(seconds: 1), () {
    getAllCategory();
    // });
    super.onInit();
  }

  void getAllCategory() {
    loading.value = true;
    operations.getAllCategories((response) {
      categories.value = response;
      loading.value = false;
    }, handleError);
  }

  void getSubCategories(String id) {
    selectedParent = id;
    subCategories.value =
        categories.firstWhere((element) => element.id == id).children;
  }

  void setSubCategory(String id) {
    selectedChild = id;
    update();
  }

  handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.other:
        connectionError.value = true;
        break;
      case DioErrorType.connectTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.response:
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
