import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_shelf/core/routing/route_path.dart';
import 'package:fresh_shelf/layers/bloc/auth/auth_cubit.dart';
import 'package:fresh_shelf/layers/view/screens/auth/widgets/animated_background.dart';
import 'package:fresh_shelf/layers/view/screens/auth/widgets/gradient_button.dart';
import 'package:provider/provider.dart';

import '../../../../core/configuration/styles.dart';
import '../../../../core/validators/validators.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../../l10n/local_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _password.dispose();
    _confirmPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            AnimatedBackground(),
            Positioned.directional(
              top: 30,
              start: 15,
              textDirection: Directionality.of(context),
              child: IconButton(
                style: IconButton.styleFrom(
                    backgroundColor:
                        Provider.of<LocaleProvider>(context, listen: false)
                                .isRTL
                            ? Styles.colorSecondary.withOpacity(0.8)
                            : Styles.colorSecondary.withOpacity(0.4)),
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                iconSize: 30,
              ),
            ),
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
                        S.of(context).signup,
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
                                    if (!Validators.isValidEmail(text)) {
                                      return S.of(context).invalidEmail;
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
                                    if (!Validators.isValidPassword(text)) {
                                      return S.of(context).invalidPassword;
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
                              CommonSizes.vSmallSpace,
                              TextFormField(
                                controller: _confirmPassword,
                                keyboardType: TextInputType.text,
                                validator: (text) {
                                  if (text != null) {
                                    if (!Validators.isNotEmptyString(text)) {
                                      return S.of(context).fill_all_fields;
                                    }
                                    if (text != _password.text) {
                                      return S
                                          .of(context)
                                          .confirmationPasswordError;
                                    }
                                  }
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                style: TextStyle(fontSize: 16),
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: S.of(context).confirm_password,
                                    prefixIcon: Icon(Icons.lock)),
                              ),
                            ],
                          )),
                      CommonSizes.vLargeSpace,
                      GestureDetector(
                        onTap: () {
                          if (formKey.currentState != null &&
                              formKey.currentState!.validate()) {
                            sl<AuthCubit>().email =
                                _emailController.text.trim();
                            sl<AuthCubit>().password = _password.text.trim();
                            Navigator.of(context)
                                .pushNamed(RoutePaths.SetUpProfileScreen);
                          }
                        },
                        child: GradientButton(
                          title: S.of(context).signup,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
