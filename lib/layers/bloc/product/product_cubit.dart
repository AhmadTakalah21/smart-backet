import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fresh_shelf/layers/data/params/product_params.dart';
import 'package:fresh_shelf/layers/data/repository/product_repository.dart';
import 'package:meta/meta.dart';

import '../../../injection_container.dart';
import '../../data/model/product.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  ProductRepository _productRepository = sl<ProductRepository>();

  void getProducts(int subCategoryId, {String? name}) async {
    emit(ProductLoading());
    final res = await _productRepository
        .getProducts(ProductParams(subCategoryId: subCategoryId, name: name));
    emit(res.fold((l) => ProductError(error: l.data!),
        (r) => ProductLoaded(products: r)));
  }
}
