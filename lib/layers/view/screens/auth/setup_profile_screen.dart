import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_shelf/layers/bloc/auth/auth_cubit.dart';
import 'package:provider/provider.dart';
import '../../../../core/app/state/app_state.dart';
import '../../../../core/loaders/loading_overlay.dart';
import '../../../../core/routing/route_path.dart';
import '../../../../core/utils.dart';
import '../../../../injection_container.dart';
import 'widgets/gradient_button.dart';
import '../../../../core/configuration/styles.dart';
import '../../../../core/validators/validators.dart';
import '../../../../generated/l10n.dart';
import '../../widgets/heading_widget.dart';

class SetUpProfileScreen extends StatefulWidget {
  const SetUpProfileScreen({super.key});

  @override
  State<SetUpProfileScreen> createState() => _SetUpProfileScreenState();
}

class _SetUpProfileScreenState extends State<SetUpProfileScreen> {
  TextEditingController _userFirstName = TextEditingController();
  TextEditingController _userLastName = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();

  final _authCubit = sl<AuthCubit>();
  GlobalKey<FormState> formKey = GlobalKey();

  signUp() {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      _authCubit.signUp(_userFirstName.text.trim(), _userLastName.text.trim(),
          _phoneNumber.text.trim());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _userFirstName.dispose();
    _userLastName.dispose();
    _phoneNumber.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).welcome,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        S.of(context).setUpProfile,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  CommonSizes.vBiggestSpace,
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          HeadingWidget(
                            title: S.of(context).firstName,
                            padding: 10,
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 20),
                            child: TextFormField(
                              controller: _userFirstName,
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
                              decoration: InputDecoration(
                                hintText: S.of(context).firstName,
                              ).copyWith(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 13)),
                            ),
                          ),
                          CommonSizes.vSmallSpace,
                          HeadingWidget(
                            title: S.of(context).lastName,
                            padding: 10,
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 20),
                            child: TextFormField(
                              controller: _userLastName,
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
                              decoration: InputDecoration(
                                hintText: S.of(context).lastName,
                              ).copyWith(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 13)),
                            ),
                          ),
                          CommonSizes.vSmallSpace,
                          HeadingWidget(
                            title: "Phone number",
                            padding: 10,
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 20),
                            child: TextFormField(
                              controller: _phoneNumber,
                              keyboardType: TextInputType.number,
                              validator: (text) {
                                if (text != null) {
                                  if (!Validators.isNotEmptyString(text)) {
                                    return S.of(context).fill_all_fields;
                                  }
                                  if (!Validators.isPhoneNumberValid(text)) {
                                    return "Invalid phone number";
                                  }
                                }
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                hintText: "phone number",
                              ).copyWith(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 13)),
                            ),
                          ),
                        ],
                      )),
                  CommonSizes.vLargeSpace,
                  GestureDetector(
                      onTap: () => signUp(),
                      child: GradientButton(
                        title: "Sign up",
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
