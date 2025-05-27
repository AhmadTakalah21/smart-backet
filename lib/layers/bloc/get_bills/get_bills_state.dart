part of 'get_bills_cubit.dart';

@immutable
abstract class GetBillsState extends Equatable {}

class GetBillsInitial extends GetBillsState {
  @override
  List<Object?> get props => [];
}

class GetBillsLoading extends GetBillsState {
  @override
  List<Object?> get props => [];
}

class GetBillsLoaded extends GetBillsState {
  final List<Bill> bills;

  GetBillsLoaded({required this.bills});

  @override
  List<Object?> get props => [this.bills];
}

class BillRemoving extends GetBillsState {
  @override
  List<Object?> get props => [];
}

class BillRemoved extends GetBillsState {
  @override
  List<Object?> get props => [];
}

class BillRemovingError extends GetBillsState {
  final String error;

  BillRemovingError({required this.error});

  @override
  List<Object?> get props => [this.error];
}

class GetBillsError extends GetBillsState {
  final String error;

  GetBillsError({required this.error});

  @override
  List<Object?> get props => [this.error];
}
