part of 'add_category_bloc.dart';

/// [AddCategoryEvent] abstract class is used Event of bloc.
/// It's an abstract class that extends Equatable and has a single property called props
abstract class AddCategoryEvent extends Equatable {
  const AddCategoryEvent();

  @override
  List<Object> get props => [];
}

/// [AddCategory] abstract class is used AddCategory Event
class AddCategory extends AddCategoryEvent {
  const AddCategory({required this.categoryName});

  final String categoryName;

  @override
  List<Object> get props => [categoryName];
}

/// [EditCategory] abstract class is used EditCategory Event
class EditCategory extends AddCategoryEvent {
  const EditCategory({required this.categoryName, required this.categoryId});

  final String categoryName;
  final int categoryId;

  @override
  List<Object> get props => [categoryName, categoryId];
}

/// [DeleteCategory] abstract class is used EditCategory Event
class DeleteCategory extends AddCategoryEvent {
  const DeleteCategory({required this.categoryId});

  final int categoryId;

  @override
  List<Object> get props => [categoryId];
}
