import 'package:dio/dio.dart';
import 'package:edeybe/controllers/cart_controller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/interface/HTTPErrorHandler.dart';
import 'package:edeybe/models/deliveryModel.dart';
import 'package:edeybe/models/shippingAddress.dart';
import 'package:edeybe/services/address_operations.dart';
import 'package:edeybe/services/cart_operation.dart';
import 'package:edeybe/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';

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
    getAllDeliveryAddresses();
  }

  addAddress(Map<String, dynamic> bodyData) {
    final deliverMap = DeliveryAddress(
        id: bodyData[''],
        type: bodyData["type"],
        isSelect: false,
        lat: bodyData["lat"],
        long: bodyData["long"],
        placeName: bodyData["placeName"],
        displayText: bodyData["displayText"]);
    addressoperations.addAddressRequest(bodyData, (address) {
      if (address.containsKey("success")) {
        getAllDeliveryAddresses();
        // getAllDeliveryAddresses();
        Get.dialog(CustomDialog(
          title: 'Success',
          content: address['success'],
        ));
        delivery.add(deliverMap);
        update();
      } else {
        Get.dialog(CustomDialog(
          title: 'Failed',
          content: address['error'],
        ));
      }
    });
  }

  deleteAddress(DeliveryAddress address) {
    if (address != null) {
      addressoperations.deleteAddress(address.id, (response) {
        if (response['success'] != null) {
          delivery.removeWhere((element) => element.id == address.id);
          Get.dialog(CustomDialog(
            title: S.current.addCard,
            content: response['success'],
          ));
        } else {
          Get.dialog(CustomDialog(
            title: 'Delete Address',
            content: response['error'],
          ));
        }
      }, handleError);

      // update();
    }
    update();
  }

  getAllDeliveryAddresses() {
    addressoperations.getAllAddresses((response) {
      print(response);
      delivery.value = response;
      update();
    }, (data) {
      // print(data);
      addresses.add(data);
      update();
    }, handleError);
  }

  setDeliveryAddress(DeliveryAddress address, {getCost: true}) {
    selectedAddress = delivery.firstWhere(
        (ad) => ad.id == address.id && ad.isSelect == true,
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
