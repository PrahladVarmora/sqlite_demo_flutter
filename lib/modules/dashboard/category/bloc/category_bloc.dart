import 'package:silver_touch_task/modules/dashboard/category/model/model_category.dart';

import '../../../core/utils/common_import.dart';

part 'category_event.dart';

part 'category_state.dart';

/// Notifies the [CategoryBloc] of a new [CategoryEvent] which triggers
/// [RepositoryCategory] This class used to API and bloc connection.
/// [ApiProvider] class is used to network API call.
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({
    required OpenHelper openHelper,
  })  : mOpenHelper = openHelper,
        super(CategoryInitial()) {
    on<CategoryList>(_onCategory);
  }

  final OpenHelper mOpenHelper;

  /// _onCategory is a function that takes an CategoryList event, an Emitter<CategoryState> emit, and returns
  /// a Future<void> that emits an CategoryLoading state, and then either an CategoryResponse state or an
  /// CategoryFailure state
  ///
  /// Args:
  ///   event (CategoryList): The event that was dispatched.
  ///   emit (Emitter<CategoryState>): This is the function that you use to emit events.
  void _onCategory(
    CategoryList event,
    Emitter<CategoryState> emit,
  ) async {
    /// Emitting an CategoryLoading state.
    emit(CategoryLoading());
    try {
      List<ModelCategory> res = await mOpenHelper.getCategory();
      if (res.isNotEmpty) {
        emit(CategoryResponse(mModelCategory: res));
      } else {
        emit(const CategoryFailure(mError: ValidationString.validationNoData));
      }
    } catch (e) {
      emit(const CategoryFailure(
          mError: ValidationString.validationInternalServerIssue));
    }
  }
}
