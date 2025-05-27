import 'package:dartz/dartz.dart';
import 'package:fresh_shelf/layers/data/data_provider/auth_provider.dart';
import 'package:fresh_shelf/layers/data/params/auth/login_params.dart';
import 'package:fresh_shelf/layers/data/params/auth/register_params.dart';
import 'package:fresh_shelf/layers/data/params/auth/update_profile_params.dart';

import '../../../core/exception/app_exception.dart';
import '../model/user.dart';

class AuthRepository {
  final AuthProvider _authProvider;

  AuthRepository(this._authProvider);

  Future<Either<AppException, User>> login(LogInParams model) async {
    try {
      final res = await _authProvider.logIn(model);
      if (res['success']) {
        User user = User.fromJson(res["result"]);
        return Right(user);
      }
      throw AppException(res["error"]);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  Future<Either<AppException, User>> register(RegisterParams model) async {
    try {
      final res = await _authProvider.register(model);
      if (res['success']) {
        User user = User.fromJson(res["result"]);
        return Right(user);
      }
      throw AppException(res["error"]);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  Future<Either<AppException, bool>> updateProfile(
      UpdateProfileParams model) async {
    try {
      final res = await _authProvider.updateProfile(model);
      if (res['success']) {
        return Right(true);
      }
      throw AppException(res["error"]);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
