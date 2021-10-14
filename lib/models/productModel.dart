class ProductModel {
  String sId;
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
  MerchantDetails merchantDetails;
  List<RelatedItems> relatedItems;

  ProductModel(
      {this.sId,
      this.categoryId,
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
      this.merchantDetails,
      this.relatedItems});

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryId = json['categoryId'];
    subCategoryId = json['subCategoryId'];
    productName = json['productName'];
    brand = json['brand'];
    price = json['price'];
    description = json['description'];
    if (json['photos'] != null) {
      photos = new List<Photos>();
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
      variants = new List<Variants>();
      json['variants'].forEach((v) {
        variants.add(new Variants.fromJson(v));
      });
    }
    merchantDetails = json['merchantDetails'] != null
        ? new MerchantDetails.fromJson(json['merchantDetails'])
        : null;
    if (json['relatedItems'] != null) {
      relatedItems = new List<RelatedItems>();
      json['relatedItems'].forEach((v) {
        relatedItems.add(new RelatedItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = sId;
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
    if (merchantDetails != null) {
      data['merchantDetails'] = merchantDetails.toJson();
    }
    if (relatedItems != null) {
      data['relatedItems'] = relatedItems.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Photos {
  String sm;
  String md;
  String lg;

  Photos({this.sm, this.md, this.lg});

  Photos.fromJson(Map<String, dynamic> json) {
    sm = json['sm'];
    md = json['md'];
    lg = json['lg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sm'] = sm;
    data['md'] = md;
    data['lg'] = lg;
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
  String lat;
  String long;
  String digitalAddress;

  MerchantLocation(
      {this.type, this.displayText, this.lat, this.long, this.digitalAddress});

  MerchantLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    displayText = json['displayText'];
    lat = json['lat'].toString();
    long = json['long'].toString();
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

class Variants {
  String variantName;
  List<VariantAttributes> variantAttributes;
  bool isDefaultPrice;
  int price;
  dynamic images;
  bool hasDiscount;
  String discountPrice;
  String variantId;

  Variants(
      {this.variantName,
      this.variantAttributes,
      this.isDefaultPrice,
      this.price,
      this.images,
      this.hasDiscount,
      this.discountPrice,
      this.variantId});

  Variants.fromJson(Map<String, dynamic> json) {
    variantName = json['variantName'];
    if (json['variantAttributes'] != null) {
      variantAttributes = new List<VariantAttributes>();
      json['variantAttributes'].forEach((v) {
        variantAttributes.add(new VariantAttributes.fromJson(v));
      });
    }
    isDefaultPrice = json['isDefaultPrice'];
    price = json['price'];
    images = json['images'];
    hasDiscount = json['hasDiscount'];
    discountPrice = json['discountPrice'];
    variantId = json['variantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variantName'] = variantName;
    if (variantAttributes != null) {
      data['variantAttributes'] =
          variantAttributes.map((v) => v.toJson()).toList();
    }
    data['isDefaultPrice'] = isDefaultPrice;
    data['price'] = price;
    data['images'] = images;
    data['hasDiscount'] = hasDiscount;
    data['discountPrice'] = discountPrice;
    data['variantId'] = variantId;
    return data;
  }
}

class VariantAttributes {
  String value;
  String variantType;

  VariantAttributes({this.value, this.variantType});

  VariantAttributes.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    variantType = json['variantType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = value;
    data['variantType'] = variantType;
    return data;
  }
}

class MerchantDetails {
  String companyName;

  MerchantDetails({this.companyName});

  MerchantDetails.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyName'] = companyName;
    return data;
  }
}

class RelatedItems {
  String sId;
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
  String weight;
  bool hasDiscount;
  int viewCount;
  int purchaseCount;
  String moderatorId;
  List<Variants> variants;

  RelatedItems(
      {this.sId,
      this.categoryId,
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
      this.weight,
      this.hasDiscount,
      this.viewCount,
      this.purchaseCount,
      this.moderatorId,
      this.variants});

  RelatedItems.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
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
    weight = json['weight'];
    hasDiscount = json['hasDiscount'];
    viewCount = json['viewCount'];
    purchaseCount = json['purchase_count'];
    moderatorId = json['moderatorId'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants.add(Variants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = sId;
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
    data['weight'] = weight;
    data['hasDiscount'] = hasDiscount;
    data['viewCount'] = viewCount;
    data['purchase_count'] = purchaseCount;
    data['moderatorId'] = moderatorId;
    if (variants != null) {
      data['variants'] = variants.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
