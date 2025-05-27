import 'dart:math';

import 'package:fresh_shelf/layers/data/model/product.dart';

List<WishProduct> getWishProductList(List<dynamic> str) =>
    List<WishProduct>.from(str.map((x) => WishProduct.fromJson(x)));

class WishProduct {
  int id;
  String name;
  String description;
  String picture;
  int price;
  int calories;

  WishProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.picture,
    required this.price,
    required this.calories,
  });

  factory WishProduct.fromJson(Map<String, dynamic> json) => WishProduct(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        picture: json["picture"],
        price: json["price"],
        calories: json["calories"],
      );

  toProduct() => Product(
        id: id,
        name: name,
        description: description,
        picture: picture,
        price: price,
        calories: calories,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "picture": picture,
        "price": price,
        "calories": calories,
      };
}
