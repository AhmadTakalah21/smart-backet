import 'package:fresh_shelf/layers/data/params/bill/add_bill_params.dart';
import 'package:fresh_shelf/layers/data/params/bill/cancel_bill_params.dart';
import 'package:fresh_shelf/layers/data/params/bill/get_bill_details_params.dart';
import 'package:fresh_shelf/layers/data/params/bill/get_bills_params.dart';
import 'package:fresh_shelf/layers/data/params/cart/create_cart_params.dart';
import 'package:fresh_shelf/layers/data/params/cart/get_cart_params.dart';
import '../../../core/data/data_provider.dart';

class BillProvider extends RemoteDataSource {
  Future<dynamic> getBills(GetBillsParams model) async {
    final res = await get(model);
    return Future.value(res);
  }

  Future<dynamic> getBillDetails(GetBillDetailsParams model) async {
    final res = await get(model);
    return Future.value(res);
  }

  Future<dynamic> addBill(AddBillParams model) async {
    final res = await post(model);
    return Future.value(res);
  }

  Future<dynamic> cancelBill(CancelBillParams model) async {
    final res = await post(model);
    return Future.value(res);
  }
}
