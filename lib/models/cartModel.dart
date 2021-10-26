class CartModel {
  List<Items> items;
  String total;
  int numberOfItems;

  CartModel({this.items, this.total, this.numberOfItems});

  CartModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    total = json['total'];
    numberOfItems = json['numberOfItems'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['numberOfItems'] = this.numberOfItems;
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
    hasVariants = json['hasVariants'];
    quantity = json['quantity'];
    productTotal = json['productTotal'];
    isVariant = json['isVariant'];
    selectedVariant = json['selectedVariant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['subCategoryId'] = this.subCategoryId;
    data['productName'] = this.productName;
    data['brand'] = this.brand;
    data['price'] = this.price;
    data['description'] = this.description;
    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    data['merchantId'] = this.merchantId;
    data['productId'] = this.productId;
    data['time'] = this.time;
    data['categoryName'] = this.categoryName;
    data['subCategoryName'] = this.subCategoryName;
    if (this.merchantLocation != null) {
      data['merchantLocation'] = this.merchantLocation.toJson();
    }
    data['merchantPhone'] = this.merchantPhone;
    data['weight'] = this.weight;
    data['hasDiscount'] = this.hasDiscount;
    data['viewCount'] = this.viewCount;
    data['purchase_count'] = this.purchaseCount;
    data['moderatorId'] = this.moderatorId;
    data['discountPrice'] = this.discountPrice;
    data['percentageDiscount'] = this.percentageDiscount;
    data['updatedAt'] = this.updatedAt;
    if (this.variants != null) {
      data['variants'] = this.variants.map((v) => v.toJson()).toList();
    }
    data['hasVariants'] = this.hasVariants;
    data['quantity'] = this.quantity;
    data['productTotal'] = this.productTotal;
    data['isVariant'] = this.isVariant;
    data['selectedVariant'] = this.selectedVariant;
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
    data['sm'] = this.sm;
    data['md'] = this.md;
    data['lg'] = this.lg;
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
    data['instock'] = this.instock;
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
    data['type'] = this.type;
    data['displayText'] = this.displayText;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['digitalAddress'] = this.digitalAddress;
    return data;
  }
}

class Variants {
  String variantName;
  List<VariantAttributes> variantAttributes;
  bool isDefaultPrice;
  int price;
  List<Photos> images;
  bool hasDiscount;
  double discountPrice;
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
    if (json['images'] != null) {
      images = new List<Photos>();
      json['images'].forEach((v) {
        images.add(new Photos.fromJson(v));
      });
    }
    hasDiscount = json['hasDiscount'];
    discountPrice = json['discountPrice'];
    variantId = json['variantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variantName'] = this.variantName;
    if (this.variantAttributes != null) {
      data['variantAttributes'] =
          this.variantAttributes.map((v) => v.toJson()).toList();
    }
    data['isDefaultPrice'] = this.isDefaultPrice;
    data['price'] = this.price;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['hasDiscount'] = this.hasDiscount;
    data['discountPrice'] = this.discountPrice;
    data['variantId'] = this.variantId;
    return data;
  }
}

class VariantAttributes {
  String sId;
  String value;

  VariantAttributes({this.sId, this.value});

  VariantAttributes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['value'] = this.value;
    return data;
  }
}
