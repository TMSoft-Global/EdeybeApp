import 'package:edeybe/services/server_operation.dart';

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
  int discountPrice = 0;
  dynamic percentageDiscount;
  String updatedAt;
  List<Variants> variants;
  bool hasVariants;
  MerchantDetails merchantDetails;
  List<ProductModel> relatedItems;
  int quantity = 1;
  String selectedVariant;
  bool isVariant = false;
  bool selectedProduct = false;
  bool availableForHirePurchasing = false;

  // ProductCost productCost;

  ProductModel({
    this.sId,
    this.categoryId,
    this.subCategoryId,
    this.productName,
    this.brand,
    this.price = 0,
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
    this.discountPrice = 0,
    this.percentageDiscount,
    this.updatedAt,
    this.variants,
    this.hasVariants,
    this.merchantDetails,
    this.relatedItems,
    this.quantity =1,
    this.selectedVariant,
    this.isVariant =  false,
    this.selectedProduct = false,
    this.availableForHirePurchasing = false,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    print(json['availableForHirePurchasing']);
    sId = json['_id'];
    categoryId = json['categoryId'];
    subCategoryId = json['subCategoryId'];
    productName = json['productName'];
    brand = json['brand'];
    price = json['price'];
    description = json['description'];
    isVariant = json['isVariant'];
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos.add(new Photos.fromJson(v));
      });
    }
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    merchantId = json['merchantId'];
    productId = json.containsKey("_id")
        ? json["_id"]
        : json.containsKey("productId")
            ? json["productId"]
            : null;

    time = json['time'];
    categoryName = json['categoryName'];
    subCategoryName = json['subCategoryName'];
    merchantLocation = json['merchantLocation'] != null
        ? new MerchantLocation.fromJson(json['merchantLocation'])
        : null;
    merchantPhone = json['merchantPhone'];
    weight = json['weight'];
    viewCount = json['viewCount'];
    purchaseCount = json['purchase_count'];
    moderatorId = json['moderatorId'];
    discountPrice = json['discountPrice'];
    percentageDiscount = json['percentageDiscount'];
    updatedAt = json['updatedAt'];
    hasDiscount = json['hasDiscount'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants.add(new Variants.fromJson(v));
      });
    }
    hasVariants = json['hasVariants'];
    merchantDetails = json['merchantDetails'] != null
        ? new MerchantDetails.fromJson(json['merchantDetails'])
        : null;
    if (json['relatedItems'] != null) {
      relatedItems = <ProductModel>[];
      json['relatedItems'].forEach((v) {
        relatedItems.add(new ProductModel.fromJson(v));
      });
    }
    selectedVariant = json['selectedVariant'];
    availableForHirePurchasing = json['availableForHirePurchasing'] == null ? false : json['availableForHirePurchasing'];
    quantity = json['quantity']== null ? 1 : json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['selected_variantID'] = selectedVariantID;
    data['_id'] = sId;
    data['categoryId'] = categoryId;
    data['subCategoryId'] = subCategoryId;
    data['productName'] = productName;
    data['brand'] = brand;
    data['price'] = price;
    data['quantity']= quantity;
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
    data['isVariant']= isVariant;
    data['merchantPhone'] = merchantPhone;
    data['weight'] = weight;
    data['hasDiscount'] = hasDiscount;
    data['viewCount'] = viewCount;
    data['purchase_count'] = purchaseCount;
    data['moderatorId'] = moderatorId;
    data['discountPrice'] = discountPrice;
    data['percentageDiscount'] = percentageDiscount;
    data['selectedVariant'] = selectedVariant;
    data['updatedAt'] = updatedAt;
    data['availableForHirePurchasing'] = availableForHirePurchasing;
    if (variants != null) {
      data['variants'] = variants.map((v) => v.toJson()).toList();
    }
    data['hasVariants'] = hasVariants;
    if (merchantDetails != null) {
      data['merchantDetails'] = merchantDetails.toJson();
    }
    if (relatedItems != null) {
      data['relatedItems'] = relatedItems.map((v) => v.toJson()).toList();
    }
    return data;
  }

  ProductModel setQuantity(int quantity) {
    return ProductModel(
        sId: sId,
        brand: brand,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
        subCategoryName: subCategoryName,
        price: price,
        productId: productId,
        productName: productName,
        percentageDiscount: percentageDiscount,
        photos: photos,
        purchaseCount: purchaseCount,
        discountPrice: discountPrice,
        merchantPhone: merchantPhone,
        merchantDetails: merchantDetails,
        merchantId: merchantId,
        merchantLocation: merchantLocation,
        moderatorId: moderatorId,
        relatedItems: relatedItems,
        hasDiscount: hasDiscount,
        hasVariants: hasVariants,
        status: status,
        updatedAt: updatedAt,
        weight: weight,
        categoryName: categoryName,
        viewCount: viewCount,
        time: time,
        description: description,
        variants: variants,
        selectedVariant: selectedVariant,
        // selectedVariantID: selectedVariantID,
        quantity: quantity);
  }
}

class Photos {
  String sm;
  String md;
  String lg;

  Photos({this.sm, this.md, this.lg});

  Photos.fromJson(Map<String, dynamic> json) {
    sm = json["sm"] == null ? null : "$domain/api/images/" + json["sm"];
    md = json["md"] == null ? null : "$domain/api/images/" + json["md"];
    lg = json["lg"] == null ? null : "$domain/api/images/" + json["lg"];
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
  bool instock = false;

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
  List<Photos> images;
  bool hasDiscount;
  dynamic discountPrice;
  String variantId;
  bool variantSelected = false;

  Variants(
      {this.variantName,
      this.variantAttributes,
      this.isDefaultPrice,
      this.price,
      this.images,
      this.hasDiscount,
      this.discountPrice,
      this.variantId,
      bool variantSelected});

  Variants.fromJson(Map<String, dynamic> json) {
    variantName = json['variantName'];
    if (json['variantAttributes'] != null) {
      variantAttributes = <VariantAttributes>[];
      json['variantAttributes'].forEach((v) {
        variantAttributes.add(new VariantAttributes.fromJson(v));
      });
    }
    isDefaultPrice = json['isDefaultPrice'];
    price = json['price'];
    if (json['images'] != null) {
      images = <Photos>[];
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
    data['variantName'] = variantName;
    if (variantAttributes != null) {
      data['variantAttributes'] =
          variantAttributes.map((v) => v.toJson()).toList();
    }
    data['isDefaultPrice'] = isDefaultPrice;
    data['price'] = price;
    if (images != null) {
      data['images'] = images.map((v) => v.toJson()).toList();
    }
    data['hasDiscount'] = hasDiscount;
    data['discountPrice'] = discountPrice;
    data['variantId'] = variantId;
    return data;
  }
}

class VariantAttributes {
  String sId;
  dynamic value;

  VariantAttributes({this.sId, this.value});

  VariantAttributes.fromJson(Map<String, dynamic> json) {
    sId = json['variantType'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variantType'] = sId;
    data['value'] = value;
    return data;
  }
}

class Images {
  String sm;
  String md;
  String lg;

  Images({this.sm, this.md, this.lg});

  Images.fromJson(Map<String, dynamic> json) {
    sm = json["sm"] == null ? null : "$domain/api/images/" + json["sm"];
    md = json["md"] == null ? null : "$domain/api/images/" + json["md"];
    lg = json["lg"] == null ? null : "$domain/api/images/" + json["lg"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sm'] = sm;
    data['md'] = md;
    data['lg'] = lg;
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
  bool hasVariants;
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
      this.hasVariants,
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
    hasVariants = json['hasVariants'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants.add(new Variants.fromJson(v));
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
    data['hasVariants'] = hasVariants;
    if (variants != null) {
      data['variants'] = variants.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductCost {
  dynamic total;
  int numberOfItems;

  ProductCost({this.total, this.numberOfItems});

  ProductCost.fromJson(Map<String, dynamic> json) {
    total = double.parse(json['total']);
    numberOfItems = json['totalPossible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = total;
    data['totalPossible'] = numberOfItems;
    return data;
  }
}
