import 'package:dio/dio.dart';
import 'package:edeybe/controllers/cart_controller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/interface/HTTPErrorHandler.dart';
import 'package:edeybe/models/deliveryModel.dart';
import 'package:edeybe/models/shippingAddress.dart';
import 'package:edeybe/services/address_operations.dart';
import 'package:edeybe/services/cart_operation.dart';

class AddressController extends GetxController implements HTTPErrorHandler {
  var addresses = <ShippingAddress>[].obs;
  var delivery = <DeliveryAddress>[].obs;
  DeliveryAddress selectedAddress;
  var operations = CartOperation();
  var addressoperations = AddressOperations();

  var connectionError = false.obs;
  var serverError = false.obs;
  var canceled = false.obs;

    @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 1), () {
      addressoperations.getAllAddresses((response) {
        print(response);
        delivery.value = response;
        update();
      }, (error) {});
    });
  }


  addAddress(Map<String, dynamic> bodyData) {
addressoperations.addAddressRequest(bodyData, (address) => print(address.deliveryAddresses));
    

    update();
  }

  deleteAddress(DeliveryAddress address) {
    if(address !=null){
      delivery.removeWhere((element) => element.id == address.id);
      update();
    }

    update();
  }

  getAllDeliveryAddresses(){

  }

  setDeliveryAddress(DeliveryAddress address, {getCost: true}) {
    selectedAddress = delivery.firstWhere(
        (ad) =>
            ad.lat == address.lat &&
            ad.long == address.long,
        orElse: () => DeliveryAddress());
    update();
    if (getCost) {
      var _cartController = Get.find<CartController>();
      _cartController.getDeliveryCost();
    }
  }

  updateAddress(ShippingAddress address) {
    // var editableAddress = addresses.indexWhere(
    //   (ad) =>
    //       ad.location.lat == address.location.lat &&
    //       ad.location.long == address.location.long,
    // );
    // if (editableAddress != -1) {
    //   addresses[editableAddress] = address;
    //   update();
    // }
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
