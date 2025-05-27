import 'package:fresh_shelf/layers/data/model/cart_item.dart';
import 'package:fresh_shelf/layers/data/model/product.dart';

class Cart {
  List<CartItem> cart;
  int totalPrice;

  Cart({
    required this.cart,
    required this.totalPrice,
  });

  add(Product product, int quantity) {
    for (CartItem cartItem in cart) {
      if (cartItem.product.id == product.id) {
        cartItem.quantity += quantity;
        cartItem.calculateTotalPrice();
        calculateTotalPrice();
        return;
      }
    }
    cart.add(CartItem(product: product, quantity: quantity));
    calculateTotalPrice();
  }

  remove(Product product, int quantity) {
    for (CartItem cartItem in cart) {
      if (cartItem.product.id == product.id) {
        cartItem.quantity -= quantity;
        cartItem.calculateTotalPrice();
        calculateTotalPrice();
      }
    }
  }

  calculateTotalPrice() {
    totalPrice = 0;
    for (CartItem cartItem in cart) {
      totalPrice += cartItem.quantity * cartItem.product.price;
    }
  }

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        cart: getCarItemList(json["cart items"]),
        totalPrice: json["total price"],
      );
}
