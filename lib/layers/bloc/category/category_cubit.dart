import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fresh_shelf/layers/data/params/category/category_params.dart';
import 'package:fresh_shelf/layers/data/repository/category_repository.dart';
import 'package:meta/meta.dart';

import '../../../injection_container.dart';
import '../../data/model/category.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  CategoryRepository _categoryRepository = sl<CategoryRepository>();

  void getCategories() async {
    emit(CategoryLoading());
    final res = await _categoryRepository.getCategories(CategoryParams());
    emit(res.fold((l) => CategoryError(error: l.data!),
        (r) => CategoryLoaded(categories: r)));
  }
}
