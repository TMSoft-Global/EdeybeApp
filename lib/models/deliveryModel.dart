// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

// import 'dart:convert';

// Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

// String welcomeToJson(Welcome data) => json.encode(data.toJson());

// class Welcome {
//     Welcome({
//         this.shippingAddress,
//     });

//     ShippingAddresss shippingAddress;

//     factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
//         shippingAddress: ShippingAddresss.fromJson(json["shippingAddress"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "shippingAddress": shippingAddress.toJson(),
//     };
// }

class ShippingAddress {
  ShippingAddress({
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.deliveryAddresses,
  });

  String firstName;
  String lastName;
  String phone;
  String email;
  List<DeliveryAddress> deliveryAddresses;

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        email: json["email"],
        deliveryAddresses: List<DeliveryAddress>.from(
            json["deliveryAddresses"].map((x) => DeliveryAddress.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "email": email,
        "deliveryAddresses":
            List<dynamic>.from(deliveryAddresses.map((x) => x.toJson())),
      };
  Map<String, dynamic> toShippingMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "phone": phone,
      "email": email,
    };
  }
}

class DeliveryAddress {
  DeliveryAddress(
      {this.type,
      this.id,
      this.lat,
      this.long,
      this.displayText,
      this.placeName,
      this.isSelect = false});

  String type;
  String id;
  String lat;
  String long;
  String displayText;
  String placeName;
  bool isSelect;

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) =>
      DeliveryAddress(
        type: json["type"],
        id: json["_id"],
        lat: json["lat"],
        long: json["long"],
        displayText: json["displayText"],
        placeName: json["placeName"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "_id": id,
        "lat": lat,
        "long": long,
        "displayText": displayText,
        "placeName": placeName,
        "isSelect": isSelect
      };
}
