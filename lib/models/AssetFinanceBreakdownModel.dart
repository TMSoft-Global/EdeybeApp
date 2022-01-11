class AssetsFinanceBreakdown {
  List<Breakdown> data;

  AssetsFinanceBreakdown({this.data});

  AssetsFinanceBreakdown.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Breakdown>[];
      json['data'].forEach((v) {
        data.add(new Breakdown.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Breakdown {
  String interest;
  String paymentWithInterest;
  String productName;
  String productId;
  String productImage;
  dynamic variantName;

  Breakdown(
      {this.interest,
      this.paymentWithInterest,
      this.productName,
      this.productId,
      this.productImage,
      this.variantName});

  Breakdown.fromJson(Map<String, dynamic> json) {
    interest = json['interest'];
    paymentWithInterest = json['paymentWithInterest'];
    productName = json['productName'];
    productId = json['productId'];
    productImage = json['productImage'];
    variantName = json['variantName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['interest'] = interest;
    data['paymentWithInterest'] = paymentWithInterest;
    data['productName'] = productName;
    data['productId'] = productId;
    data['productImage'] = productImage;
    data['variantName'] = variantName;
    return data;
  }
}
