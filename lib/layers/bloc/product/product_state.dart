part of 'product_cubit.dart';

@immutable
abstract class ProductState extends Equatable {}

class ProductInitial extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoading extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded({required this.products});

  @override
  List<Object?> get props => [this.products];
}

class ProductError extends ProductState {
  final String error;

  ProductError({required this.error});

  @override
  List<Object?> get props => [this.error];
}
