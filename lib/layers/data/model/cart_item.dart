import 'package:fresh_shelf/layers/data/model/product.dart';

List<CartItem> getCarItemList(List<dynamic> str) =>
    List<CartItem>.from(str.map((x) => CartItem.fromJson(x)));

class CartItem {
  final Product product;
  int quantity;
  int? totalPrice;

  CartItem({
    required this.product,
    required this.quantity,
  }) {
    calculateTotalPrice();
  }

  calculateTotalPrice() {
    this.totalPrice = this.product.price * this.quantity;
  }

  Map<String, dynamic> toMap() {
    return {
      'product': this.product,
      'quantity': this.quantity,
      'totalPrice': this.totalPrice,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> map) {
    return CartItem(
      product: Product.fromJson(map),
      quantity: map['quantity'],
    );
  }
}
