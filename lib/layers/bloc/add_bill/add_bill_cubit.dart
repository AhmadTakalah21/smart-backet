import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fresh_shelf/core/app/state/app_state.dart';
import 'package:fresh_shelf/layers/data/params/bill/add_bill_params.dart';
import 'package:fresh_shelf/layers/data/repository/bill_repository.dart';
import 'package:meta/meta.dart';

import '../../../injection_container.dart';

part 'add_bill_state.dart';

class AddBillCubit extends Cubit<AddBillState> {
  AddBillCubit() : super(BillInitial());

  BillRepository _billRepository = sl<BillRepository>();

  void addBill() async {
    emit(BillUploading());
    await sl<AppState>().createCart();
    final res = await _billRepository.addBill(AddBillParams());
    emit(res.fold((l) => BillError(error: l.data!), (r) => BillUploaded()));
  }
}
