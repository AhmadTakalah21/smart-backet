import 'package:dartz/dartz.dart';
import 'package:fresh_shelf/layers/data/data_provider/bill_provider.dart';
import 'package:fresh_shelf/layers/data/data_provider/cart_provider.dart';
import 'package:fresh_shelf/layers/data/data_provider/wishlist_provider.dart';
import 'package:fresh_shelf/layers/data/model/bill.dart';
import 'package:fresh_shelf/layers/data/model/cart.dart';
import 'package:fresh_shelf/layers/data/model/wish_product.dart';
import 'package:fresh_shelf/layers/data/params/bill/add_bill_params.dart';
import 'package:fresh_shelf/layers/data/params/bill/cancel_bill_params.dart';
import 'package:fresh_shelf/layers/data/params/bill/get_bill_details_params.dart';
import 'package:fresh_shelf/layers/data/params/bill/get_bills_params.dart';
import 'package:fresh_shelf/layers/data/params/cart/create_cart_params.dart';
import 'package:fresh_shelf/layers/data/params/cart/get_cart_params.dart';
import 'package:fresh_shelf/layers/data/params/wishlist/get_wishlist_params.dart';
import 'package:fresh_shelf/layers/data/params/wishlist/remove_from_wishlist_params.dart';
import '../../../core/exception/app_exception.dart';
import '../params/wishlist/add_to_wishlist_params.dart';

class BillRepository {
  final BillProvider _billProvider;

  BillRepository(this._billProvider);

  Future<Either<AppException, List<Bill>>> getBills(
      GetBillsParams model) async {
    try {
      final res = await _billProvider.getBills(model);
      if (res['success']) {
        List<Bill> bills = getBillList(res["result"]);
        return Right(bills);
      }
      throw AppException(res["error"]);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  Future<Either<AppException, Cart>> getBillDetails(
      GetBillDetailsParams model) async {
    try {
      final res = await _billProvider.getBillDetails(model);
      if (res['success']) {
        Cart cart = Cart.fromJson(res["result"]);
        return Right(cart);
      }
      throw AppException(res["error"]);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  Future<Either<AppException, bool>> addBill(AddBillParams model) async {
    try {
      final res = await _billProvider.addBill(model);
      if (res['success']) {
        return Right(true);
      }
      throw AppException(res["error"]);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  Future<Either<AppException, bool>> cancelBill(CancelBillParams model) async {
    try {
      final res = await _billProvider.cancelBill(model);
      if (res['success']) {
        return Right(true);
      }
      throw AppException(res["error"]);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
