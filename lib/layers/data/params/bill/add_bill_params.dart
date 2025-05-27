import 'package:fresh_shelf/core/app/state/app_state.dart';
import '../../../../core/configuration/app_configurations.dart';
import '../../../../core/data/params_model.dart';
import '../../../../core/enum.dart';
import '../../../../injection_container.dart';

class AddBillParams extends ParamsModel {
  AddBillParams({BaseBodyModel? body})
      : super(body: body, baseUrl: AppConfigurations.BaseUrl);

  @override
  Map<String, String> get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.POST;

  @override
  String? get url => 'addBill/${sl<AppState>().user!.id}';

  @override
  Map<String, String> get urlParams => {};

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}
