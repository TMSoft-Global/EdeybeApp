import 'package:edeybe/models/product.dart';
import 'package:edeybe/models/productModel.dart';

class SlugCollection {
  SlugCollection({this.name, this.image, this.slug, this.products});

  String name;
  String slug;
  List<dynamic> image;
  List<ProductModel> products;

  factory SlugCollection.fromJson(Map<String, dynamic> json) => SlugCollection(
        name: json["name"],
        slug: json["slug"],
        image: json["banners"] != null ? json["banners"] : [],
        products: json["products"] == null
            ? null
            : List<ProductModel>.from(
                json["products"].map((p) => ProductModel.fromJson(p))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "slug": slug,
        "image": image,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
