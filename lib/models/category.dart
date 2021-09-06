import 'package:edeybe/models/subcategory.dart';

class Category {
  Category({
    this.name,
    this.id,
    this.image,
    this.children,
  });

  String name;
  String id;
  String image;
  List<SubCategory> children;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["cName"],
        id: json["_id"],
        image: json["svg"] == null ? null : json["svg"],
        children: List<SubCategory>.from(
            json["subCats"].map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "image": image == null ? null : image,
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
      };
}
