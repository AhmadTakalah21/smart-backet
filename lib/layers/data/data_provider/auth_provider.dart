import 'package:fresh_shelf/core/data/data_provider.dart';
import 'package:fresh_shelf/layers/data/params/auth/login_params.dart';
import 'package:fresh_shelf/layers/data/params/auth/register_params.dart';
import 'package:fresh_shelf/layers/data/params/auth/update_profile_params.dart';
import 'package:fresh_shelf/layers/view/screens/settings/update_profile.dart';

class AuthProvider extends RemoteDataSource {
  Future<dynamic> register(RegisterParams model) async {
    final res = await post(model);
    return Future.value(res);
  }

  Future<dynamic> logIn(LogInParams model) async {
    final res = await post(model);
    return Future.value(res);
  }

  Future<dynamic> updateProfile(UpdateProfileParams model) async {
    print(model.body.toString());
    final res = await post(model);
    return Future.value(res);
  }
}
