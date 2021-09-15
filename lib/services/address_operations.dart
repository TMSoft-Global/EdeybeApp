import 'package:edeybe/services/server_operation.dart';

class AddressOperations extends ServerOperations{
  addAddressRequest(Map data, Function(Map<String , dynamic> onResponse)){
    dynamicRequest(
        showDialog: true,
        method: "POST",
        path: '/airtime/buy/ot',
        schema:"data",
        onResponse: ((val){}));
  }
}