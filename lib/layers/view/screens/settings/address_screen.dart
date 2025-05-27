import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_shelf/core/app/state/app_state.dart';
import 'package:fresh_shelf/layers/bloc/address/address_cubit.dart';
import 'package:fresh_shelf/layers/bloc/auth/auth_cubit.dart';
import 'package:fresh_shelf/layers/data/model/address.dart';
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

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController _cityController = TextEditingController();
  TextEditingController _blockController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _buildingController = TextEditingController();
  TextEditingController _buildingNumberController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
  final _addressCubit = sl<AddressCubit>();

  saveAddress() {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      if (Provider.of<AppState>(context, listen: false).address != null) {
        _addressCubit.updateAddress(
            _cityController.text.trim(),
            _blockController.text.trim(),
            _streetController.text.trim(),
            _buildingController.text.trim(),
            int.parse(_buildingNumberController.text.trim()));
      } else {
        _addressCubit.createAddress(
            _cityController.text.trim(),
            _blockController.text.trim(),
            _streetController.text.trim(),
            _buildingController.text.trim(),
            int.parse(_buildingNumberController.text.trim()));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Address? address = Provider.of<AppState>(context, listen: false).address;
    if (address != null) {
      _cityController.text = address.city;
      _blockController.text = address.block;
      _streetController.text = address.street;
      _buildingController.text = address.building;
      _buildingNumberController.text = address.buildingNumber.toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _cityController.dispose();
    _blockController.dispose();
    _buildingController.dispose();
    _streetController.dispose();
    _buildingNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).address),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: BlocListener<AddressCubit, AddressState>(
          bloc: _addressCubit,
          listener: (context, state) async {
            if (state is AddressUploading) {
              LoadingOverlay.of(context).show();
            } else if (state is AddressUploaded) {
              await Provider.of<AppState>(context, listen: false)
                  .getUserAddress();
              LoadingOverlay.of(context).hide();
              Navigator.of(context).pop();
            } else if (state is AddressError) {
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
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          HeadingWidget(
                            title: S.of(context).city,
                            padding: 10,
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 20),
                            child: TextFormField(
                              controller: _cityController,
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
                                hintText: S.of(context).city,
                              ).copyWith(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 13)),
                            ),
                          ),
                          CommonSizes.vSmallSpace,
                          HeadingWidget(
                            title: S.of(context).street,
                            padding: 10,
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 20),
                            child: TextFormField(
                              controller: _streetController,
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
                                hintText: S.of(context).street,
                              ).copyWith(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 13)),
                            ),
                          ),
                          CommonSizes.vSmallSpace,
                          HeadingWidget(
                            title: S.of(context).block,
                            padding: 10,
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 20),
                            child: TextFormField(
                              controller: _blockController,
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
                                hintText: S.of(context).block,
                              ).copyWith(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 13)),
                            ),
                          ),
                          CommonSizes.vSmallSpace,
                          HeadingWidget(
                            title: S.of(context).building,
                            padding: 10,
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 20),
                            child: TextFormField(
                              controller: _buildingController,
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
                                hintText: S.of(context).building,
                              ).copyWith(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 13)),
                            ),
                          ),
                          CommonSizes.vSmallSpace,
                          HeadingWidget(
                            title: S.of(context).buildingNumber,
                            padding: 10,
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 20),
                            child: TextFormField(
                              controller: _buildingNumberController,
                              keyboardType: TextInputType.number,
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
                                hintText: S.of(context).buildingNumber,
                              ).copyWith(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 13)),
                            ),
                          ),
                        ],
                      )),
                  CommonSizes.vLargeSpace,
                  GestureDetector(
                      onTap: () => saveAddress(),
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
