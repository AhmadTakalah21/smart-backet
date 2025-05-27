import 'package:dartz/dartz.dart';
import 'package:fresh_shelf/layers/data/data_provider/product_provider.dart';
import 'package:fresh_shelf/layers/data/params/product_params.dart';

import '../../../core/exception/app_exception.dart';
import '../model/product.dart';

class ProductRepository {
  final ProductProvider _productProvider;

  ProductRepository(this._productProvider);

  Future<Either<AppException, List<Product>>> getProducts(
      ProductParams model) async {
    try {
      final res = await _productProvider.getProducts(model);
      if (res['success']) {
        List<Product> products = getProductList(res["result"]);
        return Right(products);
      }
      throw AppException(res["error"]);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
