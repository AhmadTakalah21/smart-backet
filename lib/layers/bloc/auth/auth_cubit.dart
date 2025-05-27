import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fresh_shelf/layers/data/params/auth/login_params.dart';
import 'package:fresh_shelf/layers/data/params/auth/register_params.dart';
import 'package:fresh_shelf/layers/data/params/auth/update_profile_params.dart';
import 'package:meta/meta.dart';

import '../../../injection_container.dart';
import '../../data/model/user.dart';
import '../../data/repository/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  AuthRepository _authRepository = sl<AuthRepository>();

  String? email;
  String? password;

  login(String email, password) async {
    emit(AuthLoading());
    final res = await _authRepository.login(
        LogInParams(body: LogInParamsBody(email: email, password: password)));
    emit(
        res.fold((l) => AuthError(error: l.data!), (r) => AuthLoaded(user: r)));
  }

  signUp(String fName, lName, phoneNumber) async {
    emit(AuthLoading());
    final res = await _authRepository.register(RegisterParams(
        body: RegisterParamsBody(
            email: email,
            password: password,
            fName: fName,
            lName: lName,
            phoneNumber: phoneNumber)));
    emit(
        res.fold((l) => AuthError(error: l.data!), (r) => AuthLoaded(user: r)));
  }

  updateProfile(String email, fName, lName, phoneNumber) async {
    emit(AuthLoading());
    final res = await _authRepository.updateProfile(UpdateProfileParams(
        body: UpdateProfileParamsBody(
            email: email,
            fName: fName,
            lName: lName,
            phoneNumber: phoneNumber)));
    emit(res.fold((l) => AuthError(error: l.data!), (r) => ProfileUpdated()));
  }
}
