import '../../../../core/configuration/app_configurations.dart';
import '../../../../core/data/params_model.dart';
import '../../../../core/enum.dart';

class SubCategoryParams extends ParamsModel {
  SubCategoryParams({BaseBodyModel? body, required this.categoryId})
      : super(body: body, baseUrl: AppConfigurations.BaseUrl);
  final int categoryId;

  @override
  Map<String, String> get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.GET;

  @override
  String? get url => 'getSubCategory/${categoryId}';

  @override
  Map<String, String> get urlParams => {};

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}
