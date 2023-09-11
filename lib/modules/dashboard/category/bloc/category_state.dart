part of 'category_bloc.dart';

/// [CategoryState] abstract class is used Category State
abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

/// [CategoryInitial] class is used Category State Initial
class CategoryInitial extends CategoryState {}

/// [CategoryLoading] class is used Category State Loading
class CategoryLoading extends CategoryState {}

/// [CategoryResponse] class is used Category State Response
class CategoryResponse extends CategoryState {
  final List<ModelCategory> mModelCategory;

  const CategoryResponse({required this.mModelCategory});

  @override
  List<Object> get props => [mModelCategory];
}

/// [CategoryFailure] class is used Category State Failure
class CategoryFailure extends CategoryState {
  final String mError;

  const CategoryFailure({required this.mError});

  @override
  List<Object> get props => [mError];
}
