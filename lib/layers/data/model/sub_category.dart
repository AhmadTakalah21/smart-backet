List<SubCategory> getSubCategoryList(List<dynamic> str) =>
    List<SubCategory>.from(str.map((x) => SubCategory.fromJson(x)));

class SubCategory {
  int id;
  String name;
  String picture;
  int categoryId;

  SubCategory({
    required this.id,
    required this.name,
    required this.picture,
    required this.categoryId,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        name: json["name"],
        picture: json["picture"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "picture": picture,
        "category_id": categoryId,
      };
}
