import 'package:edeybe/models/AddressLocation.dart';

class ShippingAddress {
  ShippingAddress({
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.location,
  });

  String firstName;
  String lastName;
  String phone;
  String email;
  AddressLocation location;
  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
          firstName: json["firstName"],
          lastName: json["lastName"],
          email: json["email"],
          phone: json["phone"],
          location: AddressLocation.fromJson(json["location"]));

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "location": location.toJson(),
        "phone": phone
      };
}
