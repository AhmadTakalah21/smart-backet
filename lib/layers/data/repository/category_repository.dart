import 'package:dartz/dartz.dart';
import 'package:fresh_shelf/layers/data/data_provider/category_provider.dart';
import 'package:fresh_shelf/layers/data/model/category.dart';
import 'package:fresh_shelf/layers/data/model/sub_category.dart';
import 'package:fresh_shelf/layers/data/params/category/category_params.dart';

import '../../../core/exception/app_exception.dart';
import '../params/category/sub_category_params.dart';

class CategoryRepository {
  final CategoryProvider _categoryProvider;

  CategoryRepository(this._categoryProvider);

  Future<Either<AppException, List<Category>>> getCategories(
      CategoryParams model) async {
    try {
      final res = await _categoryProvider.getCategories(model);
      if (res['success']) {
        List<Category> categories = getCategoryList(res["result"]);
        return Right(categories);
      }
      throw AppException(res["error"]);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  Future<Either<AppException, List<SubCategory>>> getSubCategories(
      SubCategoryParams model) async {
    try {
      final res = await _categoryProvider.getSubCategories(model);
      if (res['success']) {
        List<SubCategory> subCategories = getSubCategoryList(res["result"]);
        return Right(subCategories);
      }
      throw AppException(res["error"]);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
