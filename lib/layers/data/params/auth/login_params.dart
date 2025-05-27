import '../../../../core/configuration/app_configurations.dart';
import '../../../../core/data/params_model.dart';
import '../../../../core/enum.dart';

class LogInParams extends ParamsModel<LogInParamsBody> {
  LogInParams({LogInParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.BaseUrl);
  @override
  Map<String, String> get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.POST;

  @override
  String? get url => 'login';

  @override
  Map<String, String> get urlParams => {};

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class LogInParamsBody extends BaseBodyModel {
  LogInParamsBody({
    this.email,
    this.password,
  });
  final String? email;
  final String? password;

  @override
  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
