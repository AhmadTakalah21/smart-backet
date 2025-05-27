import '../../../../core/configuration/app_configurations.dart';
import '../../../../core/data/params_model.dart';
import '../../../../core/enum.dart';

class AddToWishlistParams extends ParamsModel<AddToWishlistParamsBody> {
  AddToWishlistParams({required AddToWishlistParamsBody body})
      : super(body: body, baseUrl: AppConfigurations.BaseUrl);
  @override
  Map<String, String> get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.POST;

  @override
  String? get url => 'addWishlist';

  @override
  Map<String, String> get urlParams => {};

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class AddToWishlistParamsBody extends BaseBodyModel {
  AddToWishlistParamsBody({
    this.user_id,
    this.product_id,
  });
  final int? user_id;
  final int? product_id;

  @override
  Map<String, dynamic> toJson() => {
        'user_id': user_id,
        'product_id': product_id,
      };
}
