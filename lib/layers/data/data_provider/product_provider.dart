import 'package:fresh_shelf/layers/data/params/product_params.dart';
import '../../../core/data/data_provider.dart';

class ProductProvider extends RemoteDataSource {
  Future<dynamic> getProducts(ProductParams model) async {
    final res = await get(model);
    return Future.value(res);
  }
}
