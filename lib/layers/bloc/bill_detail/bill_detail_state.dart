part of 'bill_detail_cubit.dart';

@immutable
abstract class BillDetailState extends Equatable {}

class BillDetailInitial extends BillDetailState {
  @override
  List<Object?> get props => [];
}

class BillDetailLoading extends BillDetailState {
  @override
  List<Object?> get props => [];
}

class BillDetailLoaded extends BillDetailState {
  final Cart cart;

  BillDetailLoaded({required this.cart});

  @override
  List<Object?> get props => [this.cart];
}

class BillDetailError extends BillDetailState {
  final String error;

  BillDetailError({required this.error});

  @override
  List<Object?> get props => [this.error];
}
