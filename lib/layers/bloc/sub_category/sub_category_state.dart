part of 'sub_category_cubit.dart';

@immutable
abstract class SubCategoryState extends Equatable {}

class SubCategoryInitial extends SubCategoryState {
  @override
  List<Object?> get props => [];
}

class SubCategoryLoading extends SubCategoryState {
  @override
  List<Object?> get props => [];
}

class SubCategoryLoaded extends SubCategoryState {
  final List<SubCategory> subCategories;

  SubCategoryLoaded({required this.subCategories});

  @override
  List<Object?> get props => [this.subCategories];
}

class SubCategoryError extends SubCategoryState {
  final String error;

  SubCategoryError({required this.error});

  @override
  List<Object?> get props => [this.error];
}
