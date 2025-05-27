import '../../../../core/configuration/app_configurations.dart';
import '../../../../core/data/params_model.dart';
import '../../../../core/enum.dart';

class RegisterParams extends ParamsModel<RegisterParamsBody> {
  RegisterParams({RegisterParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.BaseUrl);
  @override
  Map<String, String> get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.POST;

  @override
  String? get url => 'signUp';

  @override
  Map<String, String> get urlParams => {};

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class RegisterParamsBody extends BaseBodyModel {
  RegisterParamsBody(
      {this.email, this.password, this.fName, this.lName, this.phoneNumber});
  final String? email;
  final String? password;
  final String? fName;
  final String? lName;
  final String? phoneNumber;

  @override
  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'first_name': fName,
        'last_name': lName,
        'phone_number': phoneNumber,
      };
}
