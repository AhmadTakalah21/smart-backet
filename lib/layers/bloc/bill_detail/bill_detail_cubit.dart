import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fresh_shelf/layers/data/model/cart.dart';
import 'package:fresh_shelf/layers/data/params/bill/get_bill_details_params.dart';
import 'package:fresh_shelf/layers/data/repository/bill_repository.dart';
import 'package:meta/meta.dart';

import '../../../injection_container.dart';

part 'bill_detail_state.dart';

class BillDetailCubit extends Cubit<BillDetailState> {
  BillDetailCubit() : super(BillDetailInitial());

  BillRepository _billRepository = sl<BillRepository>();

  void getBillCart(int billId) async {
    emit(BillDetailLoading());
    final res = await _billRepository
        .getBillDetails(GetBillDetailsParams(billId: billId));
    emit(res.fold((l) => BillDetailError(error: l.data!),
        (r) => BillDetailLoaded(cart: r)));
  }
}
