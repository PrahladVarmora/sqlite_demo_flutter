part of 'category_bloc.dart';

/// [CategoryEvent] abstract class is used Event of bloc.
/// It's an abstract class that extends Equatable and has a single property called props
abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

/// [CategoryList] abstract class is used Category Event
class CategoryList extends CategoryEvent {}

