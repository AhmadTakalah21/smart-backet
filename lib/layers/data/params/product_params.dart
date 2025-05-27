import '../../../core/configuration/app_configurations.dart';
import '../../../core/data/params_model.dart';
import '../../../core/enum.dart';

class ProductParams extends ParamsModel {
  ProductParams({BaseBodyModel? body, required this.subCategoryId, this.name})
      : super(body: body, baseUrl: AppConfigurations.BaseUrl);
  final int subCategoryId;
  final String? name;

  @override
  Map<String, String> get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.GET;

  @override
  String? get url => 'getProduct/${subCategoryId}';

  @override
  Map<String, String> get urlParams => {"search": name ?? ""};

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}
