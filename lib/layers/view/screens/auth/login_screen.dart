import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_shelf/layers/view/screens/auth/widgets/animated_background.dart';
import 'package:fresh_shelf/layers/view/screens/auth/widgets/gradient_button.dart';
import 'package:provider/provider.dart';

import '../../../../core/app/state/app_state.dart';
import '../../../../core/configuration/styles.dart';
import '../../../../core/loaders/loading_overlay.dart';
import '../../../../core/routing/route_path.dart';
import '../../../../core/utils.dart';
import '../../../../core/validators/validators.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../bloc/auth/auth_cubit.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _password = TextEditingController();

  final _authCubit = sl<AuthCubit>();
  GlobalKey<FormState> formKey = GlobalKey();

  logIn() {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      _authCubit.login(_emailController.text.trim(), _password.text);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        bloc: _authCubit,
        listener: (context, state) async {
          if (state is AuthLoading) {
            LoadingOverlay.of(context).show();
          } else if (state is AuthLoaded) {
            await Provider.of<AppState>(context, listen: false)
                .setUser(state.user!);
            await Provider.of<AppState>(context, listen: false).init();
            LoadingOverlay.of(context).hide();
            Navigator.of(context)
                .pushNamedAndRemoveUntil(RoutePaths.Home, (route) => false);
          } else if (state is AuthError) {
            LoadingOverlay.of(context).hide();
            Utils.showSnackBar(context, state.error);
          }
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              AnimatedBackground(),
              Positioned.fill(
                  child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: FadeInDown(
                    duration: Duration(milliseconds: 1500),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).login,
                          style: TextStyle(
                              color: Styles.colorPrimary,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        CommonSizes.vBiggestSpace,
                        Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (text) {
                                    if (text != null) {
                                      if (!Validators.isNotEmptyString(text)) {
                                        return S.of(context).fill_all_fields;
                                      }
                                    }
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: TextStyle(fontSize: 16),
                                  decoration: InputDecoration(
                                      hintText: S.of(context).email,
                                      prefixIcon: Icon(Icons.email)),
                                ),
                                CommonSizes.vSmallSpace,
                                TextFormField(
                                  controller: _password,
                                  keyboardType: TextInputType.text,
                                  validator: (text) {
                                    if (text != null) {
                                      if (!Validators.isNotEmptyString(text)) {
                                        return S.of(context).fill_all_fields;
                                      }
                                    }
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: TextStyle(fontSize: 16),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: S.of(context).password,
                                      prefixIcon: Icon(Icons.lock)),
                                ),
                              ],
                            )),
                        CommonSizes.vLargeSpace,
                        GestureDetector(
                          onTap: () => logIn(),
                          child: GradientButton(
                            title: S.of(context).login,
                          ),
                        ),
                        CommonSizes.vSmallSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S.of(context).no_account,
                              style: TextStyle(fontSize: 17),
                            ),
                            CommonSizes.hSmallSpace,
                            GestureDetector(
                              onTap: () => Navigator.of(context)
                                  .pushNamed(RoutePaths.SignUp),
                              child: Text(
                                S.of(context).signup,
                                style: TextStyle(
                                    color: Styles.colorPrimary,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
