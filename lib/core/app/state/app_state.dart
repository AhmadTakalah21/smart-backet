import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:fresh_shelf/core/shared_preferences/shared_preferences_instance.dart';
import 'package:fresh_shelf/core/shared_preferences/shared_preferences_key.dart';
import 'package:fresh_shelf/core/utils.dart';
import 'package:fresh_shelf/layers/data/model/address.dart';
import 'package:fresh_shelf/layers/data/model/cart.dart';
import 'package:fresh_shelf/layers/data/model/cart_item.dart';
import 'package:fresh_shelf/layers/data/model/product.dart';
import 'package:fresh_shelf/layers/data/model/wish_product.dart';
import 'package:fresh_shelf/layers/data/params/address/get_address_params.dart';
import 'package:fresh_shelf/layers/data/params/cart/create_cart_params.dart';
import 'package:fresh_shelf/layers/data/params/cart/get_cart_params.dart';
import 'package:fresh_shelf/layers/data/params/wishlist/get_wishlist_params.dart';
import 'package:fresh_shelf/layers/data/params/wishlist/remove_from_wishlist_params.dart';
import 'package:fresh_shelf/layers/data/repository/address_repository.dart';
import 'package:fresh_shelf/layers/data/repository/cart_repository.dart';
import 'package:fresh_shelf/layers/data/repository/wishlist_repository.dart';
import '../../../injection_container.dart';
import '../../../layers/data/model/user.dart';
import '../../../layers/data/params/wishlist/add_to_wishlist_params.dart';

class AppState extends ChangeNotifier {
  User? _user;
  List<WishProduct> _wishProducts = [];
  Cart? _cart;
  Address? _address;
  bool _isAdding = false;
  bool _isRemoving = false;

  User? get user => _user;
  Cart? get cart => _cart;
  Address? get address => _address;
  List<WishProduct> get wishProducts => _wishProducts;

  Future init() async {
    await getUser();
    await Future.wait([getWishlist(), getCart(), getUserAddress()]);
  }

  Future createCart() async {
    await sl<CartRepository>().createCart(CreateCartParams(
        body: CreateCartParamsBody(
      user_id: _user!.id,
      product_id: _cart!.cart.map((e) => e.product.id).toList(),
      quantities: _cart!.cart.map((e) => e.quantity).toList(),
    )));
  }

  Future getCart() async {
    final res = await sl<CartRepository>().getCart(GetCartParams());
    res.fold((l) {}, (r) {
      _cart = r;
      notifyListeners();
    });
  }

  addToCart(Product product, int quantity) {
    cart!.add(product, quantity);
    notifyListeners();
  }

  removeFromCart(Product product, int quantity) {
    for (CartItem cartItem in _cart!.cart) {
      if (cartItem.product.id == product.id) {
        if (cartItem.quantity - quantity <= 0) {
          _cart!.cart.removeWhere(
              (element) => element.product.id == cartItem.product.id);
          notifyListeners();
          return;
        }
        cart!.remove(product, quantity);
        notifyListeners();
        return;
      }
    }
  }

  Future getWishlist({BuildContext? context, String? msg}) async {
    final res = await sl<WishListRepository>().getWishlist(GetWishListParams());
    res.fold((l) {}, (r) {
      if (context != null && msg != null) {
        Utils.showSnackBar(context, msg);
      }
      _wishProducts = List.from(r);
      notifyListeners();
    });
  }

  Future addToWishlist(int productId, BuildContext context) async {
    if (!_isAdding) {
      _isAdding = true;
      final res = await sl<WishListRepository>().addToWishList(
          AddToWishlistParams(
              body: AddToWishlistParamsBody(
                  user_id: _user!.id, product_id: productId)));
      res.fold((l) {
        Utils.showSnackBar(context, l.data);
      }, (r) {
        getWishlist(
            context: context, msg: "Product has been added to wish list");
      });
      _isAdding = false;
    }
  }

  Future removeFromWishlist(int productId, BuildContext context) async {
    if (!_isRemoving) {
      _isRemoving = true;
      final res = await sl<WishListRepository>().removeFromWishList(
          RemoveFromWishlistParams(
              body: RemoveFromWishlistParamsBody(
                  user_id: _user!.id, product_id: productId)));
      res.fold((l) {
        Utils.showSnackBar(context, l.data);
      }, (r) {
        getWishlist(
            context: context, msg: "Product has been removed from wish list");
      });
      _isRemoving = false;
    }
  }

  Future setUser(User user) async {
    await Future.wait([
      SharedPreferencesInstance.pref
          .setInt(SharedPreferencesKeys.USER_ID, user.id),
      SharedPreferencesInstance.pref
          .setString(SharedPreferencesKeys.FIRST_NAME, user.firstName),
      SharedPreferencesInstance.pref
          .setString(SharedPreferencesKeys.LAST_NAME, user.lastName),
      SharedPreferencesInstance.pref
          .setString(SharedPreferencesKeys.EMAIL, user.email),
      SharedPreferencesInstance.pref
          .setString(SharedPreferencesKeys.PHONE_NUMBER, user.phoneNumber)
    ]);
    getUser();
  }

  Future updateUser(User user) async {
    await Future.wait([
      SharedPreferencesInstance.pref
          .setString(SharedPreferencesKeys.FIRST_NAME, user.firstName),
      SharedPreferencesInstance.pref
          .setString(SharedPreferencesKeys.LAST_NAME, user.lastName),
      SharedPreferencesInstance.pref
          .setString(SharedPreferencesKeys.EMAIL, user.email),
      SharedPreferencesInstance.pref
          .setString(SharedPreferencesKeys.PHONE_NUMBER, user.phoneNumber)
    ]);
    getUser();
  }

  Future getUser() async {
    final userId =
        SharedPreferencesInstance.pref.getInt(SharedPreferencesKeys.USER_ID);
    final firstName = SharedPreferencesInstance.pref
        .getString(SharedPreferencesKeys.FIRST_NAME);
    final lastName = SharedPreferencesInstance.pref
        .getString(SharedPreferencesKeys.LAST_NAME);
    final email =
        SharedPreferencesInstance.pref.getString(SharedPreferencesKeys.EMAIL);
    final phoneNumber = SharedPreferencesInstance.pref
        .getString(SharedPreferencesKeys.PHONE_NUMBER);

    _user = User(
        id: userId!,
        firstName: firstName!,
        lastName: lastName!,
        email: email!,
        phoneNumber: phoneNumber!);
    notifyListeners();
  }

  Future removeUser() async {
    await Future.wait([
      SharedPreferencesInstance.pref.remove(SharedPreferencesKeys.USER_ID),
      SharedPreferencesInstance.pref.remove(SharedPreferencesKeys.FIRST_NAME),
      SharedPreferencesInstance.pref.remove(SharedPreferencesKeys.LAST_NAME),
      SharedPreferencesInstance.pref.remove(SharedPreferencesKeys.EMAIL),
      SharedPreferencesInstance.pref.remove(SharedPreferencesKeys.PHONE_NUMBER)
    ]);
  }

  Future getUserAddress() async {
    final res = await sl<AddressRepository>().getAddress(GetAddressParams());
    res.fold((l) {}, (r) {
      _address = r;
      notifyListeners();
    });
  }
}
