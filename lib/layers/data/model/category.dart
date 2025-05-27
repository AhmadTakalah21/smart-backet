List<Category> getCategoryList(List<dynamic> str) =>
    List<Category>.from(str.map((x) => Category.fromJson(x)));

class Category {
  int id;
  String name;
  String picture;

  Category({
    required this.id,
    required this.name,
    required this.picture,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "picture": picture,
      };
}
