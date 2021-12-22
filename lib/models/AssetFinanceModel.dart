class AssetFinanceModel {
  Data data;

  AssetFinanceModel({this.data});

  AssetFinanceModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<Financers> financers;

  Data({this.financers});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['financers'] != null) {
      financers = <Financers>[];
      json['financers'].forEach((v) {
        financers.add(new Financers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (financers != null) {
      data['financers'] = financers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Financers {
  String sId;
  UserDetails userDetails;

  Financers({this.sId, this.userDetails});

  Financers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userDetails = json['userDetails'] != null
        ? new UserDetails.fromJson(json['userDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = sId;
    if (userDetails != null) {
      data['userDetails'] = userDetails.toJson();
    }
    return data;
  }
}

class UserDetails {
  String firstName;
  String lastName;
  String email;
  String companyName;
  String storeDescription;
  String phone;

  UserDetails(
      {this.firstName,
      this.lastName,
      this.email,
      this.companyName,
      this.storeDescription,
      this.phone});

  UserDetails.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    companyName = json['companyName'];
    storeDescription = json['storeDescription'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['companyName'] = companyName;
    data['storeDescription'] = storeDescription;
    data['phone'] = phone;
    return data;
  }
}
