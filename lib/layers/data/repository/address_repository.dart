import 'package:dartz/dartz.dart';
import 'package:fresh_shelf/layers/data/data_provider/address_provider.dart';
import 'package:fresh_shelf/layers/data/data_provider/wishlist_provider.dart';
import 'package:fresh_shelf/layers/data/model/address.dart';
import 'package:fresh_shelf/layers/data/model/wish_product.dart';
import 'package:fresh_shelf/layers/data/params/address/create_address_params.dart';
import 'package:fresh_shelf/layers/data/params/address/get_address_params.dart';
import 'package:fresh_shelf/layers/data/params/address/update_address_params.dart';
import 'package:fresh_shelf/layers/data/params/wishlist/get_wishlist_params.dart';
import 'package:fresh_shelf/layers/data/params/wishlist/remove_from_wishlist_params.dart';
import '../../../core/exception/app_exception.dart';
import '../params/wishlist/add_to_wishlist_params.dart';

class AddressRepository {
  final AddressProvider _addressProvider;

  AddressRepository(this._addressProvider);

  Future<Either<AppException, Address>> getAddress(
      GetAddressParams model) async {
    try {
      final res = await _addressProvider.getAddress(model);
      print(res);
      if (res['success'] && res['result'] != null) {
        Address address = Address.fromJson(res["result"]);
        return Right(address);
      }
      throw AppException(res["error"]);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  Future<Either<AppException, bool>> createAddress(
      CreateAddressParams model) async {
    try {
      final res = await _addressProvider.createAddress(model);
      if (res['success']) {
        return Right(true);
      }
      throw AppException(res["error"]);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  Future<Either<AppException, bool>> updateAddress(
      UpdateAddressParams model) async {
    try {
      final res = await _addressProvider.updateAddress(model);
      if (res['success']) {
        return Right(true);
      }
      throw AppException(res["error"]);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
