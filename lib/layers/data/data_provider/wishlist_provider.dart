import 'package:fresh_shelf/layers/data/params/wishlist/get_wishlist_params.dart';
import 'package:fresh_shelf/layers/data/params/wishlist/remove_from_wishlist_params.dart';

import '../../../core/data/data_provider.dart';
import '../params/wishlist/add_to_wishlist_params.dart';

class WishListProvider extends RemoteDataSource {
  Future<dynamic> getWishList(GetWishListParams model) async {
    final res = await get(model);
    return Future.value(res);
  }

  Future<dynamic> addToWishList(AddToWishlistParams model) async {
    final res = await post(model);
    return Future.value(res);
  }

  Future<dynamic> removeFromWishList(RemoveFromWishlistParams model) async {
    final res = await post(model);
    return Future.value(res);
  }
}
