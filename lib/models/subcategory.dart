class SubCategory {
  SubCategory({
    this.name,
    this.id,
    this.image,
  });

  String name;
  String id;
  String image;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        name: json["subCatName"],
        id: json["subCatId"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() =>
      {"name": name, "id": id, "image": image == null ? null : image};
}
