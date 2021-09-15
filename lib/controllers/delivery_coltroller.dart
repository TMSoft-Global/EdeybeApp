// import 'package:dio/dio.dart';
// import 'package:edeybe/controllers/cart_controller.dart';
// import 'package:edeybe/index.dart';
// import 'package:edeybe/interface/HTTPErrorHandler.dart';
// import 'package:edeybe/models/deliveryModel.dart';
// import 'package:edeybe/services/cart_operation.dart';

// class AddresssController extends GetxController implements HTTPErrorHandler {
//   var addresses = <ShippingAddress>[].obs;
//   ShippingAddress selectedAddress;
//   var operations = CartOperation();
//   var connectionError = false.obs;
//   var serverError = false.obs;
//   var canceled = false.obs;

//   addnewAddress(ShippingAddress address) {
//     addresses.add(address);
//     update();
//   }

//   deleteoldAddress(ShippingAddress address) {
//     addresses.removeWhere((ad) => address.deliveryAddresses[0].id == 
//     ad.deliveryAddresses[0].id);
        
//     update();
//   }

//   setDeliveryAddress(ShippingAddress address, {getCost: true}) {
//     selectedAddress = addresses.firstWhere((val){
//       return val==address;
//     });
        
//     update();
//     if (getCost) {
//       var _cartController = Get.find<CartController>();
//       _cartController.getDeliveryCost();
//     }
//   }

//   updateAddress(ShippingAddress address,int index ) {
//     // var editableAddress = addresses.indexWhere(
//     //   (ad) =>
//     //       ad.deliveryAddresses[index].lat == address.deliveryAddresses[index].lat &&
//     //       ad.deliveryAddresses[index].long == address.deliveryAddresses[index].long,
//     // );
//     // if (editableAddress != -1) {
//     //   addresses[editableAddress] = address;
//     //   update();
//     // }
//   }

//   resetErrorState() {
//     connectionError.value = false;
//     serverError.value = false;
//     canceled.value = false;
//     update();
//   }

//   getGhanaPostAddresss(String code,
//       {Function(Map<String, dynamic> data) callback}) {
//     resetErrorState();
//     operations.getDigitalAddress(code, (response) {
//       if (callback != null) callback(response);
//       // print("=================$response====================");
//       update();
//     }, handleError);
//   }

//   getClosestAddress(Map<String, double> code,
//       {Function(Map<String, dynamic> data) callback}) {
//     resetErrorState();
//     operations.getClossestAddress(code, (response) {
//       if (callback != null) callback(response);
//       update();
//     }, handleError);
//   }

//   handleError(DioError error) {
//     switch (error.type) {
//       case DioErrorType.other:
//         connectionError.value = true;
//         break;
//       case DioErrorType.connectTimeout:
//       case DioErrorType.receiveTimeout:
//       case DioErrorType.sendTimeout:
//       case DioErrorType.response:
//         serverError.value = true;
//         break;
//       case DioErrorType.cancel:
//         canceled.value = true;
//         break;
//       default:
//     }
//     update();
//   }
// }
