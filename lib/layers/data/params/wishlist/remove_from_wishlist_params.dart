import '../../../../core/configuration/app_configurations.dart';
import '../../../../core/data/params_model.dart';
import '../../../../core/enum.dart';

class RemoveFromWishlistParams
    extends ParamsModel<RemoveFromWishlistParamsBody> {
  RemoveFromWishlistParams({required RemoveFromWishlistParamsBody body})
      : super(body: body, baseUrl: AppConfigurations.BaseUrl);
  @override
  Map<String, String> get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.POST;

  @override
  String? get url => 'removeWishlist';

  @override
  Map<String, String> get urlParams => {};

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class RemoveFromWishlistParamsBody extends BaseBodyModel {
  RemoveFromWishlistParamsBody({
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
