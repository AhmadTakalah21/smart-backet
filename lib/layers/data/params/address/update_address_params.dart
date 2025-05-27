import 'package:fresh_shelf/core/app/state/app_state.dart';

import '../../../../core/configuration/app_configurations.dart';
import '../../../../core/data/params_model.dart';
import '../../../../core/enum.dart';
import '../../../../injection_container.dart';

class UpdateAddressParams extends ParamsModel<UpdateAddressParamsBody> {
  UpdateAddressParams({required UpdateAddressParamsBody body})
      : super(body: body, baseUrl: AppConfigurations.BaseUrl);
  @override
  Map<String, String> get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.POST;

  @override
  String? get url => 'updateAddress/${sl<AppState>().user!.id}';

  @override
  Map<String, String> get urlParams => {};

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class UpdateAddressParamsBody extends BaseBodyModel {
  UpdateAddressParamsBody({
    this.city,
    this.block,
    this.street,
    this.building,
    this.buildingNumber,
  });

  String? city;
  String? block;
  String? street;
  String? building;
  int? buildingNumber;

  @override
  Map<String, dynamic> toJson() => {
        "city": city,
        "block": block,
        "street": street,
        "building": building,
        "building_number": buildingNumber,
      };
}
