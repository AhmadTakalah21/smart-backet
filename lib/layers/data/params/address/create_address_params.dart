import 'package:fresh_shelf/core/app/state/app_state.dart';

import '../../../../core/configuration/app_configurations.dart';
import '../../../../core/data/params_model.dart';
import '../../../../core/enum.dart';
import '../../../../injection_container.dart';

class CreateAddressParams extends ParamsModel<CreateAddressParamsBody> {
  CreateAddressParams({required CreateAddressParamsBody body})
      : super(body: body, baseUrl: AppConfigurations.BaseUrl);
  @override
  Map<String, String> get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.POST;

  @override
  String? get url => 'createAddress';

  @override
  Map<String, String> get urlParams => {};

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class CreateAddressParamsBody extends BaseBodyModel {
  CreateAddressParamsBody({
    this.city,
    this.block,
    this.street,
    this.building,
    this.buildingNumber,
    this.userId,
  });

  String? city;
  String? block;
  String? street;
  String? building;
  int? buildingNumber;
  int? userId;

  @override
  Map<String, dynamic> toJson() => {
        "city": city,
        "block": block,
        "street": street,
        "building": building,
        "building_number": buildingNumber,
        "user_id": sl<AppState>().user!.id
      };
}
