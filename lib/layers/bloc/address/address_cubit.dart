import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fresh_shelf/layers/data/params/address/create_address_params.dart';
import 'package:fresh_shelf/layers/data/params/address/update_address_params.dart';
import 'package:fresh_shelf/layers/data/repository/address_repository.dart';
import 'package:meta/meta.dart';

import '../../../injection_container.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  AddressRepository _addressRepository = sl<AddressRepository>();

  void createAddress(
      String city, block, street, building, int buildingNumber) async {
    emit(AddressUploading());
    final res = await _addressRepository.createAddress(CreateAddressParams(
        body: CreateAddressParamsBody(
            city: city,
            block: block,
            street: street,
            building: building,
            buildingNumber: buildingNumber)));
    emit(res.fold(
        (l) => AddressError(error: l.data!), (r) => AddressUploaded()));
  }

  void updateAddress(
      String city, block, street, building, int buildingNumber) async {
    emit(AddressUploading());
    final res = await _addressRepository.updateAddress(UpdateAddressParams(
        body: UpdateAddressParamsBody(
            city: city,
            block: block,
            street: street,
            building: building,
            buildingNumber: buildingNumber)));
    emit(res.fold(
        (l) => AddressError(error: l.data!), (r) => AddressUploaded()));
  }
}
