import 'dart:convert';

import 'package:edeybe/services/server_operation.dart';

class AddressOperations extends ServerOperations {
  addAddressRequest(Map data, Function(Map<String, dynamic> onResponse)) {
    dynamicRequest(
      showDialog: true,
      method: "POST",
      path: '/account/deliveryaddresses',
      schema: jsonEncode(data),
      onResponse: (val) {
        print(val);
        if (val != null) {}
        // onResponse(val);
      },
    );
  }
}
