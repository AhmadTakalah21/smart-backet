import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_shelf/core/app/state/app_state.dart';
import 'package:fresh_shelf/layers/bloc/auth/auth_cubit.dart';
import 'package:provider/provider.dart';
import '../../../../core/configuration/styles.dart';
import '../../../../core/loaders/loading_overlay.dart';
import '../../../../core/utils.dart';
import '../../../../core/validators/validators.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../data/model/user.dart';
import '../../widgets/heading_widget.dart';
import '../auth/widgets/gradient_button.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController _userFirstName = TextEditingController();
  TextEditingController _userLastName = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
  final _authCubit = sl<AuthCubit>();

  updateProfile() {
    if (formKey.currentState != null &&
        formKey.currentState!.validate() &&
        hasChanged()) {
      _authCubit.updateProfile(
          _emailController.text.trim(),
          _userFirstName.text.trim(),
          _userLastName.text.trim(),
          _phoneNumber.text.trim());
    }
  }

  hasChanged() {
    User user = Provider.of<AppState>(context, listen: false).user!;
    return !(_userFirstName.text == user.firstName &&
        _userLastName.text == user.lastName &&
        _emailController.text == user.email &&
        _phoneNumber.text == user.phoneNumber);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    User user = Provider.of<AppState>(context, listen: false).user!;
    _userFirstName.text = user.firstName;
    _userLastName.text = user.lastName;
    _emailController.text = user.email;
    _phoneNumber.text = user.phoneNumber;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _userFirstName.dispose();
    _userLastName.dispose();
    _phoneNumber.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).profile),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: BlocListener<AuthCubit, AuthState>(
          bloc: _authCubit,
          listener: (context, state) async {
            if (state is AuthLoading) {
              LoadingOverlay.of(context).show();
            } else if (state is ProfileUpdated) {
              await Provider.of<AppState>(context, listen: false).updateUser(
                Provider.of<AppState>(context, listen: false).user!.copyWith(
                    email: _emailController.text.trim(),
                    firstName: _userFirstName.text.trim(),
                    lastName: _userLastName.text.trim(),
                    phoneNumber: _phoneNumber.text.trim()),
              );
              LoadingOverlay.of(context).hide();
              Navigator.of(context).pop();
            } else if (state is AuthError) {
              LoadingOverlay.of(context).hide();
              Utils.showSnackBar(context, state.error);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonSizes.vBiggestSpace,
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          HeadingWidget(
                            title: S.of(context).email,
                            padding: 10,
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 20),
                            child: TextFormField(
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
                              ).copyWith(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 13)),
                            ),
                          ),
                          CommonSizes.vSmallSpace,
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
                            title: S.of(context).phoneNumber,
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
                                hintText: S.of(context).phoneNumber,
                              ).copyWith(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 13)),
                            ),
                          ),
                        ],
                      )),
                  CommonSizes.vLargeSpace,
                  GestureDetector(
                      onTap: () => updateProfile(),
                      child: GradientButton(
                        title: S.of(context).save,
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
