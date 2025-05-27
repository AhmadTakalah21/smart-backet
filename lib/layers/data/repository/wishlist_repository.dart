import 'package:dartz/dartz.dart';
import 'package:fresh_shelf/layers/data/data_provider/wishlist_provider.dart';
import 'package:fresh_shelf/layers/data/model/wish_product.dart';
import 'package:fresh_shelf/layers/data/params/wishlist/get_wishlist_params.dart';
import 'package:fresh_shelf/layers/data/params/wishlist/remove_from_wishlist_params.dart';
import '../../../core/exception/app_exception.dart';
import '../params/wishlist/add_to_wishlist_params.dart';

class WishListRepository {
  final WishListProvider _wishlistProvider;

  WishListRepository(this._wishlistProvider);

  Future<Either<AppException, List<WishProduct>>> getWishlist(
      GetWishListParams model) async {
    try {
      final res = await _wishlistProvider.getWishList(model);
      if (res['success']) {
        List<WishProduct> wishProduct = getWishProductList(res["result"]);
        return Right(wishProduct);
      }
      throw AppException(res["error"]);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  Future<Either<AppException, bool>> addToWishList(
      AddToWishlistParams model) async {
    try {
      final res = await _wishlistProvider.addToWishList(model);
      if (res['success']) {
        return Right(true);
      }
      throw AppException(res["error"]);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  Future<Either<AppException, bool>> removeFromWishList(
      RemoveFromWishlistParams model) async {
    try {
      final res = await _wishlistProvider.removeFromWishList(model);
      if (res['success']) {
        return Right(true);
      }
      throw AppException(res["error"]);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
