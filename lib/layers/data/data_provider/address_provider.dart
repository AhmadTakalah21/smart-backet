import 'package:fresh_shelf/layers/data/params/address/create_address_params.dart';
import 'package:fresh_shelf/layers/data/params/address/get_address_params.dart';
import 'package:fresh_shelf/layers/data/params/address/update_address_params.dart';

import '../../../core/data/data_provider.dart';

class AddressProvider extends RemoteDataSource {
  Future<dynamic> getAddress(GetAddressParams model) async {
    final res = await get(model);
    return Future.value(res);
  }

  Future<dynamic> createAddress(CreateAddressParams model) async {
    final res = await post(model);
    return Future.value(res);
  }

  Future<dynamic> updateAddress(UpdateAddressParams model) async {
    final res = await post(model);
    return Future.value(res);
  }
}
