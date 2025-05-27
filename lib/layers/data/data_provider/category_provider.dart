import 'package:fresh_shelf/layers/data/params/category/category_params.dart';
import 'package:fresh_shelf/layers/data/params/category/sub_category_params.dart';
import '../../../core/data/data_provider.dart';

class CategoryProvider extends RemoteDataSource {
  Future<dynamic> getCategories(CategoryParams model) async {
    final res = await get(model);
    return Future.value(res);
  }

  Future<dynamic> getSubCategories(SubCategoryParams model) async {
    final res = await get(model);
    return Future.value(res);
  }
}
