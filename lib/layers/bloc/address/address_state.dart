part of 'address_cubit.dart';

@immutable
abstract class AddressState extends Equatable {}

class AddressInitial extends AddressState {
  @override
  List<Object?> get props => [];
}

class AddressUploading extends AddressState {
  @override
  List<Object?> get props => [];
}

class AddressUploaded extends AddressState {
  @override
  List<Object?> get props => [];
}

class AddressError extends AddressState {
  final String error;

  AddressError({required this.error});

  @override
  List<Object?> get props => [this.error];
}
