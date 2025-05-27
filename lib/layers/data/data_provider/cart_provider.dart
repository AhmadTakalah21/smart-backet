import 'package:fresh_shelf/layers/data/params/cart/create_cart_params.dart';
import 'package:fresh_shelf/layers/data/params/cart/get_cart_params.dart';
import '../../../core/data/data_provider.dart';

class CartProvider extends RemoteDataSource {
  Future<dynamic> getCart(GetCartParams model) async {
    final res = await get(model);
    return Future.value(res);
  }

  Future<dynamic> createCart(CreateCartParams model) async {
    final res = await post(model);
    return Future.value(res);
  }
}
