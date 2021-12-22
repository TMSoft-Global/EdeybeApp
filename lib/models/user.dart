class User {
  User({
    this.firstname,
    this.lastname,
    this.defaultShipping,
    this.defaultBilling,
    this.email,
    this.addresses,
    this.kycIDCard,
  });

  String firstname;
  String lastname;
  Map<String, dynamic> defaultShipping;
  Map<String, dynamic> defaultBilling;
  String email;
  List<Address> addresses;
  String kycIDCard;

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstname: json["userDetails"]["firstName"],
        lastname: json["userDetails"]["lastName"],
        defaultShipping: json["shippingAddress"],
        defaultBilling: json["default_billing"],
        email: json["email"],
        kycIDCard: json['kycIDCard'] != null ? json['kycIDCard']['lg'] : "",
        addresses: json.containsKey("addresses")
            ? List<Address>.from(
                json["addresses"].map((x) => Address.fromJson(x)))
            : <Address>[],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "default_shipping": defaultShipping,
        "default_billing": defaultBilling,
        "email": email,
        "kycIDCard": kycIDCard,
        "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
      };
}

class Address {
  Address({
    this.firstname,
    this.lastname,
    this.street,
    this.city,
    this.region,
    this.postcode,
    this.countryCode,
    this.telephone,
  });

  String firstname;
  String lastname;
  List<String> street;
  String city;
  Region region;
  String postcode;
  String countryCode;
  String telephone;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        firstname: json["firstname"],
        lastname: json["lastname"],
        street: List<String>.from(json["street"].map((x) => x)),
        city: json["city"],
        region: Region.fromJson(json["region"]),
        postcode: json["postcode"],
        countryCode: json["country_code"],
        telephone: json["telephone"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "street": List<dynamic>.from(street.map((x) => x)),
        "city": city,
        "region": region.toJson(),
        "postcode": postcode,
        "country_code": countryCode,
        "telephone": telephone,
      };
}

class Region {
  Region({
    this.regionCode,
    this.region,
  });

  String regionCode;
  String region;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        regionCode: json["region_code"],
        region: json["region"],
      );

  Map<String, dynamic> toJson() => {
        "region_code": regionCode,
        "region": region,
      };
}
