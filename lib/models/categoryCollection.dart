import 'package:edeybe/models/product.dart';
import 'package:edeybe/models/subcategory.dart';

class CatergoryCollection {
  CatergoryCollection(
      {this.name,
      this.id,
      this.image,
      this.children,
      this.bestSeller,
      this.newArrival,
      this.recommended});

  String name;
  String id;
  List<dynamic> image;
  List<SubCategory> children;
  List<Product> recommended;
  List<Product> newArrival;
  List<Product> bestSeller;

  factory CatergoryCollection.fromJson(Map<String, dynamic> json) =>
      CatergoryCollection(
        name: json["name"],
        id: json["cateogoryId"],
        image: json["banners"] == null ? [] : json["banners"],
        newArrival: json["newArrivals"] == null
            ? null
            : List<Product>.from(
                json["newArrivals"].map((p) => Product.fromJson(p))),
        recommended: json["recommendedProducts"] == null
            ? null
            : List<Product>.from(
                json["recommendedProducts"].map((p) => Product.fromJson(p))),
        bestSeller: json["bestSellers"] == null
            ? null
            : List<Product>.from(
                json["bestSellers"].map((p) => Product.fromJson(p))),
        children: List<SubCategory>.from(
            json["subCategories"].map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "image": image == null ? null : image,
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
      };
}
