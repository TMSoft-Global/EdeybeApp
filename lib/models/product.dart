// import 'package:edeybe/models/AddressLocation.dart';
// import 'package:edeybe/services/server_operation.dart';

// class Product {
//   Product(
//       {this.categories,
//       this.image,
//       this.name,
//       this.sku,
//       this.brand,
//       this.onlyXLeftInStock,
//       this.stockStatus,
//       this.seller,
//       this.description,
//       this.shortDescription,
//       this.mediaGallery,
//       this.priceRange,
//       this.configurableOptions,
//       this.variants,
//       this.relatedProducts,
//       this.quantity = 1});

//   List<ProductCategory> categories;
//   List<Product> relatedProducts;
//   Image image;
//   String name;
//   String sku;
//   String brand;
//   Seller seller;
//   dynamic onlyXLeftInStock;
//   Map<String, dynamic> stockStatus;
//   Description description;
//   Description shortDescription;
//   List<Image> mediaGallery;
//   PriceRange priceRange;
//   List<ConfigurableOption> configurableOptions;
//   List<Variant> variants;
//   int quantity = 1;
//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//         categories: json["categories"] == null
//             ? null
//             : List<ProductCategory>.from(
//                 json["categories"].map((x) => ProductCategory.fromJson(x))),
//         image:
//             json["photos"] == null ? null : Image.fromJson(json["photos"][0]),
//         name: json["productName"] == null ? null : json["productName"],
//         sku: json.containsKey("_id")
//             ? json["_id"]
//             : json.containsKey("productId")
//                 ? json["productId"]
//                 : null,
//         brand: json["brand"] == null ? null : json["brand"],
//         onlyXLeftInStock: json["only_x_left_in_stock"],
//         stockStatus: json["status"] == null ? null : json["status"],
//         seller: Seller.fromJson({
//           'companyName': json['merchantDetails'] == null
//               ? null
//               : json['merchantDetails']['companyName'],
//           'merchantId': json['merchantId'],
//           'merchantLocation': json['merchantLocation'],
//           'merchantPhone': json['merchantPhone']
//         }),
//         description: json["description"] == null
//             ? null
//             : Description.fromJson(json["description"]),
//         shortDescription: json["short_description"] == null
//             ? null
//             : Description.fromJson(json["short_description"]),
//         mediaGallery: json["photos"] == null
//             ? null
//             : List<Image>.from(json["photos"].map((x) => Image.fromJson(x))),
//         priceRange: json["price"] == null
//             ? null
//             : PriceRange.fromJson({
//                 "minimum_price": {
//                   "has_discount": json["hasDiscount"] == true ? true : false,
//                   "final_price": {
//                     "value": json["hasDiscount"] == true
//                         ? json["discountPrice"]
//                         : json["price"],
//                     "currency": "GHS"
//                   },
//                   "regular_price": {"value": json["price"], "currency": "GHS"},
//                   "discount": {
//                     "percent_off": json["hasDiscount"] == true
//                         ? double.parse(json["percentageDiscount"])
//                         : 0
//                   }
//                 }
//               }),
//         configurableOptions: json["configurable_options"] == null
//             ? null
//             : List<ConfigurableOption>.from(json["configurable_options"]
//                 .map((x) => ConfigurableOption.fromJson(x))),
//         relatedProducts: json['relatedItems'] != null
//             ? List<Product>.from(
//                 json['relatedItems'].map((p) => Product.fromJson(p)))
//             : null,
//         variants: json["variants"] == null
//             ? null
//             : List<Variant>.from(
//                 json["variants"].map((x) => Variant.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "categories": categories == null
//             ? null
//             : List<dynamic>.from(categories.map((x) => x.toJson())),
//         "image": image == null ? null : image.toJson(),
//         "name": name == null ? null : name,
//         "sku": sku == null ? null : sku,
//         "brand": brand == null ? null : brand,
//         "only_x_left_in_stock": onlyXLeftInStock,
//         "stock_status": stockStatus == null ? null : stockStatus,
//         "description": description == null ? null : description.toJson(),
//         "short_description":
//             shortDescription == null ? null : shortDescription.toJson(),
//         "media_gallery": mediaGallery == null
//             ? null
//             : List<dynamic>.from(mediaGallery.map((x) => x.toJson())),
//         "price_range": priceRange == null ? null : priceRange.toJson(),
//         "configurable_options": configurableOptions == null
//             ? null
//             : List<dynamic>.from(configurableOptions.map((x) => x.toJson())),
//         "variants": variants == null
//             ? null
//             : List<dynamic>.from(variants.map((x) => x.toJson())),
//       };

//   Product setQuantity(int quantity) {
//     return Product(
//         categories: categories,
//         image: image,
//         name: name,
//         sku: sku,
//         brand: brand,
//         onlyXLeftInStock: onlyXLeftInStock,
//         stockStatus: stockStatus,
//         description: description,
//         shortDescription: shortDescription,
//         mediaGallery: mediaGallery,
//         priceRange: priceRange,
//         configurableOptions: configurableOptions,
//         variants: variants,
//         relatedProducts: relatedProducts,
//         quantity: quantity);
//   }
// }

// class ProductCategory {
//   ProductCategory({
//     this.name,
//     this.id,
//   });

//   String name;
//   int id;

//   factory ProductCategory.fromJson(Map<String, dynamic> json) =>
//       ProductCategory(
//         name: json["name"] == null ? null : json["name"],
//         id: json["id"] == null ? null : json["id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name == null ? null : name,
//         "id": id == null ? null : id,
//       };
// }

// class ConfigurableOption {
//   ConfigurableOption({
//     this.label,
//     this.attributeCode,
//     this.values,
//   });

//   String label;
//   String attributeCode;
//   List<Value> values;

//   factory ConfigurableOption.fromJson(Map<String, dynamic> json) =>
//       ConfigurableOption(
//         label: json["label"] == null ? null : json["label"],
//         attributeCode:
//             json["attribute_code"] == null ? null : json["attribute_code"],
//         values: json["values"] == null
//             ? null
//             : List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "label": label == null ? null : label,
//         "attribute_code": attributeCode == null ? null : attributeCode,
//         "values": values == null
//             ? null
//             : List<dynamic>.from(values.map((x) => x.toJson())),
//       };
// }

// class Value {
//   Value({
//     this.label,
//   });

//   String label;

//   factory Value.fromJson(Map<String, dynamic> json) => Value(
//         label: json["label"] == null ? null : json["label"],
//       );

//   Map<String, dynamic> toJson() => {
//         "label": label == null ? null : label,
//       };
// }

// class Description {
//   Description({
//     this.html,
//   });

//   String html;

//   factory Description.fromJson(String json) => Description(
//         html: json == null ? null : json,
//       );

//   Map<String, dynamic> toJson() => {
//         "html": html == null ? null : html,
//       };
// }

// class Image {
//   Image({
//     this.sm,
//     this.md,
//     this.lg,
//   });

//   String sm;
//   String md;
//   String lg;

//   factory Image.fromJson(Map<String, dynamic> json) => Image(
//         sm: json["sm"] == null
//             ? null
//             : "$domain/api/images/" + json["sm"],
//         md: json["md"] == null
//             ? null
//             : "$domain/api/images/" + json["md"],
//         lg: json["lg"] == null
//             ? null
//             : "$domain/api/images/" + json["lg"],
//       );

//   Map<String, dynamic> toJson() => {
//         "sm": sm == null ? null : sm,
//         "md": sm == null ? null : md,
//         "lg": sm == null ? null : lg,
//       };
// }

// class Seller {
//   Seller(
//       {this.name,
//       this.id,
//       this.phone,
//       this.location,
//       this.photo,
//       this.details});

//   String id;
//   String name;
//   String details;
//   String phone;
//   String photo;
//   AddressLocation location;

//   factory Seller.fromJson(Map<String, dynamic> json) => Seller(
//       name: json["companyName"] == null ? null : json["companyName"],
//       id: json['merchantId'],
//       details: json['storeDescription'] != null ? json['storeDescription'] : "",
//       location: json['merchantLocation'] != null
//           ? AddressLocation.fromJson(json['merchantLocation'])
//           : null,
//       photo: json['storeProfilePicture'] != null
//           ? json['storeProfilePicture']
//           : null,
//       phone: json['merchantPhone']);

//   Map<String, dynamic> toJson() =>
//       {"name": name, "id": id, "location": location.toJson(), "phone": phone};
// }

// class PriceRange {
//   PriceRange({
//     this.minimumPrice,
//   });

//   MinimumPrice minimumPrice;

//   factory PriceRange.fromJson(Map<String, dynamic> json) => PriceRange(
//         minimumPrice: json["minimum_price"] == null
//             ? null
//             : MinimumPrice.fromJson(json["minimum_price"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "minimum_price": minimumPrice == null ? null : minimumPrice.toJson(),
//       };
// }

// class MinimumPrice {
//   MinimumPrice({
//     this.hasDiscount,
//     this.regularPrice,
//     this.finalPrice,
//     this.discount,
//   });
//   bool hasDiscount;
//   Price regularPrice;
//   Price finalPrice;
//   Discount discount;

//   factory MinimumPrice.fromJson(Map<String, dynamic> json) => MinimumPrice(
//       regularPrice: json["regular_price"] == null
//           ? null
//           : Price.fromJson(json["regular_price"]),
//       finalPrice: json["final_price"] == null
//           ? null
//           : Price.fromJson(json["final_price"]),
//       discount:
//           json["discount"] == null ? null : Discount.fromJson(json["discount"]),
//       hasDiscount: json["has_discount"]);

//   Map<String, dynamic> toJson() => {
//         "regular_price": regularPrice == null ? null : regularPrice.toJson(),
//         "final_price": finalPrice == null ? null : finalPrice.toJson(),
//         "discount": discount == null ? null : discount.toJson(),
//       };
// }

// class Discount {
//   Discount({
//     this.percentOff,
//   });

//   dynamic percentOff;

//   factory Discount.fromJson(Map<String, dynamic> json) => Discount(
//         percentOff: json["percent_off"] == null ? null : json["percent_off"],
//       );

//   Map<String, dynamic> toJson() => {
//         "percent_off": percentOff == null ? null : percentOff,
//       };
// }

// class Price {
//   Price({
//     this.value,
//     this.currency,
//   });

//   num value;
//   String currency;

//   factory Price.fromJson(Map<String, dynamic> json) => Price(
//         value: json["value"] == null ? null : json["value"],
//         currency: json["currency"] == null ? null : json["currency"],
//       );

//   Map<String, dynamic> toJson() => {
//         "value": value == null ? null : value,
//         "currency": currency == null ? null : currency,
//       };
// }

// class Variant {
//   Variant({
//     this.product,
//     this.attributes,
//   });

//   ProductClass product;
//   List<Value> attributes;

//   factory Variant.fromJson(Map<String, dynamic> json) => Variant(
//         product: json["product"] == null
//             ? null
//             : ProductClass.fromJson(json["product"]),
//         attributes: json["attributes"] == null
//             ? null
//             : List<Value>.from(
//                 json["attributes"].map((x) => Value.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "product": product == null ? null : product.toJson(),
//         "attributes": attributes == null
//             ? null
//             : List<dynamic>.from(attributes.map((x) => x.toJson())),
//       };
// }

// class ProductClass {
//   ProductClass({
//     this.name,
//     this.sku,
//     this.mediaGallery,
//     this.priceRange,
//   });

//   String name;
//   String sku;
//   List<Image> mediaGallery;
//   PriceRange priceRange;

//   factory ProductClass.fromJson(Map<String, dynamic> json) => ProductClass(
//         name: json["name"] == null ? null : json["name"],
//         sku: json["sku"] == null ? null : json["sku"],
//         mediaGallery: json["media_gallery"] == null
//             ? null
//             : List<Image>.from(
//                 json["media_gallery"].map((x) => Image.fromJson(x))),
//         priceRange: json["price_range"] == null
//             ? null
//             : PriceRange.fromJson(json["price_range"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name == null ? null : name,
//         "sku": sku == null ? null : sku,
//         "media_gallery": mediaGallery == null
//             ? null
//             : List<dynamic>.from(mediaGallery.map((x) => x.toJson())),
//         "price_range": priceRange == null ? null : priceRange.toJson(),
//       };
// }
