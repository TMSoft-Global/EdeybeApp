class AddressLocation {
  AddressLocation({this.lat, this.long, this.address, this.type});

  String lat;
  String long;
  String address;
  String type;
  AddressLocation location;
  factory AddressLocation.fromJson(Map<String, dynamic> json) =>
      AddressLocation(
        lat: json["lat"].toString(),
        long: json["long"].toString(),
        address: json["displayText"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() =>
      {"lat": lat, "long": long, "displayText": address, "type": type};
}
