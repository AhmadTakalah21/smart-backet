part of 'add_bill_cubit.dart';

@immutable
abstract class AddBillState extends Equatable {}

class BillInitial extends AddBillState {
  @override
  List<Object?> get props => [];
}

class BillUploading extends AddBillState {
  @override
  List<Object?> get props => [];
}

class BillUploaded extends AddBillState {
  @override
  List<Object?> get props => [];
}

class BillError extends AddBillState {
  final String error;

  BillError({required this.error});

  @override
  List<Object?> get props => [this.error];
}
