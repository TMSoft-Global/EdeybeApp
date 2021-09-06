class AddressLocation {
  AddressLocation({this.lat, this.long, this.address, this.type});

  double lat;
  double long;
  String address;
  String type;
  AddressLocation location;
  factory AddressLocation.fromJson(Map<String, dynamic> json) =>
      AddressLocation(
        lat: json["lat"],
        long: json["long"],
        address: json["displayText"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() =>
      {"lat": lat, "long": long, "displayText": address, "type": type};
}
