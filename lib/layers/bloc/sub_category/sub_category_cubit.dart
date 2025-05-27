import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fresh_shelf/layers/bloc/product/product_cubit.dart';
import 'package:fresh_shelf/layers/data/model/sub_category.dart';
import 'package:fresh_shelf/layers/data/params/category/sub_category_params.dart';
import 'package:meta/meta.dart';
import '../../../injection_container.dart';
import '../../data/repository/category_repository.dart';

part 'sub_category_state.dart';

class SubCategoryCubit extends Cubit<SubCategoryState> {
  SubCategoryCubit() : super(SubCategoryInitial());

  CategoryRepository _categoryRepository = sl<CategoryRepository>();

  void getSubCategories(int categoryId) async {
    emit(SubCategoryLoading());
    final res = await _categoryRepository
        .getSubCategories(SubCategoryParams(categoryId: categoryId));
    emit(res.fold((l) => SubCategoryError(error: l.data!), (r) {
      if (r.isNotEmpty) {
        sl<ProductCubit>().getProducts(r.first.id);
      }
      return SubCategoryLoaded(subCategories: r);
    }));
  }
}
