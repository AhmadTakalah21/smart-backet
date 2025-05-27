List<Product> getProductList(List<dynamic> str) =>
    List<Product>.from(str.map((x) => Product.fromJson(x)));

class Product {
  int id;
  String name;
  String description;
  String picture;
  int price;
  int? calories;
  int? subCategoryId;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.picture,
    required this.price,
    this.calories,
    this.subCategoryId,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        picture: json["picture"],
        price: json["price"],
        calories: json.containsKey("calories") ? json["calories"] : null,
        subCategoryId: json.containsKey("sub_category_id")
            ? json["sub_category_id"]
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "picture": picture,
        "price": price,
        "calories": calories,
        "sub_category_id": subCategoryId,
      };
}
