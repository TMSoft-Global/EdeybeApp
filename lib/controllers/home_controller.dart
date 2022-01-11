import 'package:dio/dio.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/interface/HTTPErrorHandler.dart';
import 'package:edeybe/models/categoryCollection.dart';
import 'package:edeybe/models/productCollection.dart';
import 'package:edeybe/models/productModel.dart';
import 'package:edeybe/models/user.dart';
import 'package:edeybe/services/home_operation.dart';

class HomeController extends GetxController implements HTTPErrorHandler {
  User user;
  var operations = HomeOperation();
  var slugs = <String>[].obs;
  var cats = <String>[].obs;
  var products = <ProductModel>[].obs;
  var loadingSlugs = false.obs;
  var loadingCategorySlugsProducts = false.obs;
  var loadingCollections = false.obs;
  var categoryProducts = <CatergoryCollection>[].obs;
  var productCollection = <SlugCollection>[].obs;
  var connectionError = false.obs;
  var serverError = false.obs;
  var canceled = false.obs;

  writeReview(double rating, String message) {
    update();
  }

  @override
  void onInit() {
    super.onInit();
    // Future.delayed(Duration(seconds: 1), () {
    getAvailableSlugs();
    getAvailableCatsCollection();
    // });
  }

  updateView() {
    categoryProducts = categoryProducts;
    productCollection = productCollection;
    products = products;
    update();
  }
  void getPromotions() {
    resetErrorState();
    operations.getPromotions((response) {
      products.value = response;
      update();
    }, handleError);
  }

  void resetProducts() {
    products.value = <ProductModel>[];
  }

  void getAvailableSlugs() {
    resetErrorState();
    loadingSlugs.value = true;
    operations.getAvailableSlugs((response) {
      slugs.value = response;
      loadingSlugs.value = false;
      getProductsByCollectionIds();
    }, handleError);
  }

  void getAvailableCatsCollection() {
    resetErrorState();
    loadingCollections.value = true;
    operations.getAvailableCategoryCollection((response) {
      cats.value = response;
      loadingCollections.value = false;
      getProductsByCategorySlug();
    }, handleError);
  }

  void getProductsByCategorySlug() {
    resetErrorState();
    loadingCategorySlugsProducts.value = true;
    operations.getAllProductByCategoryIds(cats, (response) {
      categoryProducts.value = response;
      loadingCategorySlugsProducts.value = false;
      update();
    }, handleError);
  }

  void getProductsByCollectionIds() {
    resetErrorState();
    operations.getAllProductBySlugId(slugs, (response) {
      productCollection.value = response;
      update();
    }, handleError);
  }

  resetErrorState() {
    connectionError.value = false;
    serverError.value = false;
    canceled.value = false;
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
