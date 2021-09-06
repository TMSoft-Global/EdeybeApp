import 'package:dio/dio.dart';
import 'package:edeybe/controllers/cart_controller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/interface/HTTPErrorHandler.dart';
import 'package:edeybe/models/shippingAddress.dart';
import 'package:edeybe/services/cart_operation.dart';

class AddressController extends GetxController implements HTTPErrorHandler {
  var addresses = <ShippingAddress>[].obs;
  ShippingAddress selectedAddress;
  var operations = CartOperation();
  var connectionError = false.obs;
  var serverError = false.obs;
  var canceled = false.obs;

  addAddress(ShippingAddress address) {
    addresses.add(address);
    update();
  }

  deleteAddress(ShippingAddress address) {
    addresses.removeWhere((ad) =>
        ad.location.lat == address.location.lat &&
        ad.location.long == address.location.long);
    if (selectedAddress.location.lat == address.location.lat &&
        selectedAddress.location.long == address.location.long) {
      selectedAddress = ShippingAddress();
    }
    update();
  }

  setDeliveryAddress(ShippingAddress address, {getCost: true}) {
    selectedAddress = addresses.firstWhere(
        (ad) =>
            ad.location.lat == address.location.lat &&
            ad.location.long == address.location.long,
        orElse: () => ShippingAddress());
    update();
    if (getCost) {
      var _cartController = Get.find<CartController>();
      _cartController.getDeliveryCost();
    }
  }

  updateAddress(ShippingAddress address) {
    var editableAddress = addresses.indexWhere(
      (ad) =>
          ad.location.lat == address.location.lat &&
          ad.location.long == address.location.long,
    );
    if (editableAddress != -1) {
      addresses[editableAddress] = address;
      update();
    }
  }

  resetErrorState() {
    connectionError.value = false;
    serverError.value = false;
    canceled.value = false;
    update();
  }

  getGhanaPostAddress(String code,
      {Function(Map<String, dynamic> data) callback}) {
    resetErrorState();
    operations.getDigitalAddress(code, (response) {
      if (callback != null) callback(response);
      update();
    }, handleError);
  }

  getClosestAddress(Map<String, double> code,
      {Function(Map<String, dynamic> data) callback}) {
    resetErrorState();
    operations.getClossestAddress(code, (response) {
      if (callback != null) callback(response);
      update();
    }, handleError);
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
