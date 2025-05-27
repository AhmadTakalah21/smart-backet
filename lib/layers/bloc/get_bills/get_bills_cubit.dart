import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fresh_shelf/layers/data/model/bill.dart';
import 'package:fresh_shelf/layers/data/params/bill/cancel_bill_params.dart';
import 'package:fresh_shelf/layers/data/params/bill/get_bills_params.dart';
import 'package:fresh_shelf/layers/data/repository/bill_repository.dart';
import 'package:meta/meta.dart';

import '../../../injection_container.dart';

part 'get_bills_state.dart';

class GetBillsCubit extends Cubit<GetBillsState> {
  GetBillsCubit() : super(GetBillsInitial());

  BillRepository _billRepository = sl<BillRepository>();

  void getBills() async {
    emit(GetBillsLoading());
    final res = await _billRepository.getBills(GetBillsParams());
    emit(res.fold(
        (l) => GetBillsError(error: l.data!), (r) => GetBillsLoaded(bills: r)));
  }

  void removeBill(int billId) async {
    emit(BillRemoving());
    final res =
        await _billRepository.cancelBill(CancelBillParams(billId: billId));
    emit(res.fold(
        (l) => BillRemovingError(error: l.data!), (r) => BillRemoved()));
  }
}
