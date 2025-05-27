import '../../../../core/configuration/app_configurations.dart';
import '../../../../core/data/params_model.dart';
import '../../../../core/enum.dart';

class CreateCartParams extends ParamsModel<CreateCartParamsBody> {
  CreateCartParams({required CreateCartParamsBody body})
      : super(body: body, baseUrl: AppConfigurations.BaseUrl);
  @override
  Map<String, String> get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.POST;

  @override
  String? get url => 'createCart';

  @override
  Map<String, String> get urlParams => {};

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class CreateCartParamsBody extends BaseBodyModel {
  CreateCartParamsBody({
    this.user_id,
    this.product_id,
    this.quantities,
  });
  final int? user_id;
  final List<int>? product_id;
  final List<int>? quantities;

  @override
  Map<String, dynamic> toJson() => {
        'user_id': user_id,
        'product_ids': product_id,
        'quantities': quantities,
      };
}
