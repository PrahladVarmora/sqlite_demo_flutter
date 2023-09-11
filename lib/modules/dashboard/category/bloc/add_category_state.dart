part of 'add_category_bloc.dart';


/// [AddCategoryState] abstract class is used AddCategory State
abstract class AddCategoryState extends Equatable {
  const AddCategoryState();

  @override
  List<Object> get props => [];
}

/// [AddCategoryInitial] class is used AddCategory State Initial
class AddCategoryInitial extends AddCategoryState {}

/// [AddCategoryLoading] class is used AddCategory State Loading
class AddCategoryLoading extends AddCategoryState {}

/// [AddCategoryResponse] class is used AddCategory State Response
class AddCategoryResponse extends AddCategoryState {}

/// [AddCategoryFailure] class is used AddCategory State Failure
class AddCategoryFailure extends AddCategoryState {
  final String mError;

  const AddCategoryFailure({required this.mError});

  @override
  List<Object> get props => [mError];
}
