import 'package:edeybe/models/productModel.dart';

class CartModel {
  List<Items> items;
  String total;
  int numberOfItems;

  CartModel({this.items, this.total, this.numberOfItems});

  CartModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    total = json['total'];
    numberOfItems = json['numberOfItems'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (items != null) {
      data['items'] = items.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['numberOfItems'] = numberOfItems;
    return data;
  }
}

class Items {
  String categoryId;
  String subCategoryId;
  String productName;
  String brand;
  int price;
  String description;
  List<Photos> photos;
  Status status;
  String merchantId;
  String productId;
  int time;
  String categoryName;
  String subCategoryName;
  MerchantLocation merchantLocation;
  String merchantPhone;
  String weight;
  bool hasDiscount;
  int viewCount;
  int purchaseCount;
  String moderatorId;
  int discountPrice;
  String percentageDiscount;
  String updatedAt;
  List<Variants> variants;
  bool hasVariants;
  int quantity;
  String productTotal;
  bool isVariant;
  String selectedVariant;

  Items(
      {this.categoryId,
      this.subCategoryId,
      this.productName,
      this.brand,
      this.price,
      this.description,
      this.photos,
      this.status,
      this.merchantId,
      this.productId,
      this.time,
      this.categoryName,
      this.subCategoryName,
      this.merchantLocation,
      this.merchantPhone,
      this.weight,
      this.hasDiscount,
      this.viewCount,
      this.purchaseCount,
      this.moderatorId,
      this.discountPrice,
      this.percentageDiscount,
      this.updatedAt,
      this.variants,
      this.hasVariants,
      this.quantity,
      this.productTotal,
      this.isVariant,
      this.selectedVariant});

  Items.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    subCategoryId = json['subCategoryId'];
    productName = json['productName'];
    brand = json['brand'];
    price = json['price'];
    description = json['description'];
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos.add(new Photos.fromJson(v));
      });
    }
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    merchantId = json['merchantId'];
    productId = json['productId'];
    time = json['time'];
    categoryName = json['categoryName'];
    subCategoryName = json['subCategoryName'];
    merchantLocation = json['merchantLocation'] != null
        ? new MerchantLocation.fromJson(json['merchantLocation'])
        : null;
    merchantPhone = json['merchantPhone'];
    weight = json['weight'];
    hasDiscount = json['hasDiscount'];
    viewCount = json['viewCount'];
    purchaseCount = json['purchase_count'];
    moderatorId = json['moderatorId'];
    discountPrice = json['discountPrice'];
    percentageDiscount = json['percentageDiscount'];
    updatedAt = json['updatedAt'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants.add(new Variants.fromJson(v));
      });
    }
    hasVariants = json['hasVariants'];
    quantity = json['quantity'];
    productTotal = json['productTotal'];
    isVariant = json['isVariant'];
    selectedVariant = json['selectedVariant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = categoryId;
    data['subCategoryId'] = subCategoryId;
    data['productName'] = productName;
    data['brand'] = brand;
    data['price'] = price;
    data['description'] = description;
    if (photos != null) {
      data['photos'] = photos.map((v) => v.toJson()).toList();
    }
    if (status != null) {
      data['status'] = status.toJson();
    }
    data['merchantId'] = merchantId;
    data['productId'] = productId;
    data['time'] = time;
    data['categoryName'] = categoryName;
    data['subCategoryName'] = subCategoryName;
    if (merchantLocation != null) {
      data['merchantLocation'] = merchantLocation.toJson();
    }
    data['merchantPhone'] = merchantPhone;
    data['weight'] = weight;
    data['hasDiscount'] = hasDiscount;
    data['viewCount'] = viewCount;
    data['purchase_count'] = purchaseCount;
    data['moderatorId'] = moderatorId;
    data['discountPrice'] = discountPrice;
    data['percentageDiscount'] = percentageDiscount;
    data['updatedAt'] = updatedAt;
    if (variants != null) {
      data['variants'] = variants.map((v) => v.toJson()).toList();
    }
    data['hasVariants'] = hasVariants;
    data['quantity'] = quantity;
    data['productTotal'] = productTotal;
    data['isVariant'] = isVariant;
    data['selectedVariant'] = selectedVariant;
    return data;
  }
}
class Status {
  bool instock;

  Status({this.instock});

  Status.fromJson(Map<String, dynamic> json) {
    instock = json['instock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['instock'] = instock;
    return data;
  }
}

class MerchantLocation {
  String type;
  String displayText;
  double lat;
  double long;
  String digitalAddress;

  MerchantLocation(
      {this.type, this.displayText, this.lat, this.long, this.digitalAddress});

  MerchantLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    displayText = json['displayText'];
    lat = json['lat'];
    long = json['long'];
    digitalAddress = json['digitalAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = type;
    data['displayText'] = displayText;
    data['lat'] = lat;
    data['long'] = long;
    data['digitalAddress'] = digitalAddress;
    return data;
  }
}
