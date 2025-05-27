import 'package:dartz/dartz.dart';
import 'package:fresh_shelf/layers/data/data_provider/cart_provider.dart';
import 'package:fresh_shelf/layers/data/data_provider/wishlist_provider.dart';
import 'package:fresh_shelf/layers/data/model/cart.dart';
import 'package:fresh_shelf/layers/data/model/wish_product.dart';
import 'package:fresh_shelf/layers/data/params/cart/create_cart_params.dart';
import 'package:fresh_shelf/layers/data/params/cart/get_cart_params.dart';
import 'package:fresh_shelf/layers/data/params/wishlist/get_wishlist_params.dart';
import 'package:fresh_shelf/layers/data/params/wishlist/remove_from_wishlist_params.dart';
import '../../../core/exception/app_exception.dart';
import '../params/wishlist/add_to_wishlist_params.dart';

class CartRepository {
  final CartProvider _cartProvider;

  CartRepository(this._cartProvider);

  Future<Either<AppException, Cart>> getCart(GetCartParams model) async {
    try {
      final res = await _cartProvider.getCart(model);
      if (res['success']) {
        Cart cart = Cart.fromJson(res["result"]);
        return Right(cart);
      }
      throw AppException(res["error"]);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  Future<Either<AppException, bool>> createCart(CreateCartParams model) async {
    try {
      final res = await _cartProvider.createCart(model);
      if (res['success']) {
        return Right(true);
      }
      throw AppException(res["error"]);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
