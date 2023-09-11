import '../../../core/utils/common_import.dart';
import '../model/model_category.dart';

part 'add_category_event.dart';

part 'add_category_state.dart';

/// Notifies the [AddCategoryBloc] of a new [AddCategoryEvent] which triggers
/// [RepositoryAddCategory] This class used to API and bloc connection.
/// [ApiProvider] class is used to network API call.
class AddCategoryBloc extends Bloc<AddCategoryEvent, AddCategoryState> {
  AddCategoryBloc({
    required OpenHelper openHelper,
  })  : mOpenHelper = openHelper,
        super(AddCategoryInitial()) {
    on<AddCategory>(_onAddCategory);
    on<EditCategory>(_onEditCategory);
    on<DeleteCategory>(_onDeleteCategory);
  }

  final OpenHelper mOpenHelper;

  /// _onAddCategory is a function that takes an AddCategoryAdd event, an Emitter<AddCategoryState> emit, and returns
  /// a Future<void> that emits an AddCategoryLoading state, and then either an AddCategoryResponse state or an
  /// AddCategoryFailure state
  ///
  /// Args:
  ///   event (AddCategoryAdd): The event that was dispatched.
  ///   emit (Emitter<AddCategoryState>): This is the function that you use to emit events.
  void _onAddCategory(
    AddCategory event,
    Emitter<AddCategoryState> emit,
  ) async {
    /// Emitting an AddCategoryLoading state.
    emit(AddCategoryLoading());
    try {
      if (event.categoryName.isNotEmpty) {
        ModelCategory mModelCategory = ModelCategory();
        mModelCategory.categoryName = event.categoryName;
        var res = await mOpenHelper.insertCategory(mModelCategory);
        if (res == 1) {
          emit(AddCategoryResponse());
        } else {
          emit(const AddCategoryFailure(
              mError: ValidationString.validationPleaseEnterCategoryName));
        }
      } else {
        emit(const AddCategoryFailure(
            mError: ValidationString.validationPleaseEnterCategoryName));
      }
    } catch (e) {
      emit(const AddCategoryFailure(
          mError: ValidationString.validationInternalServerIssue));
    }
  }

  /// _onEditCategory is a function that takes an EditCategory event, an Emitter<AddCategoryState> emit, and returns
  /// a Future<void> that emits an AddCategoryLoading state, and then either an AddCategoryResponse state or an
  /// AddCategoryFailure state
  ///
  /// Args:
  ///   event (EditCategory): The event that was dispatched.
  ///   emit (Emitter<AddCategoryState>): This is the function that you use to emit events.
  void _onEditCategory(
    EditCategory event,
    Emitter<AddCategoryState> emit,
  ) async {
    /// Emitting an AddCategoryLoading state.
    emit(AddCategoryLoading());
    try {
      if (event.categoryName.isNotEmpty) {
        await mOpenHelper.updateCategory(event.categoryName, event.categoryId);
        emit(AddCategoryResponse());
      } else {
        emit(const AddCategoryFailure(
            mError: ValidationString.validationPleaseEnterCategoryName));
      }
    } catch (e) {
      emit(const AddCategoryFailure(
          mError: ValidationString.validationInternalServerIssue));
    }
  }

  /// _onEditCategory is a function that takes an EditCategory event, an Emitter<AddCategoryState> emit, and returns
  /// a Future<void> that emits an AddCategoryLoading state, and then either an AddCategoryResponse state or an
  /// AddCategoryFailure state
  ///
  /// Args:
  ///   event (EditCategory): The event that was dispatched.
  ///   emit (Emitter<AddCategoryState>): This is the function that you use to emit events.
  void _onDeleteCategory(
    DeleteCategory event,
    Emitter<AddCategoryState> emit,
  ) async {
    /// Emitting an AddCategoryLoading state.
    emit(AddCategoryLoading());
    try {
      await mOpenHelper.deleteCategory(event.categoryId);
      emit(AddCategoryResponse());
    } catch (e) {
      emit(const AddCategoryFailure(
          mError: ValidationString.validationInternalServerIssue));
    }
  }
}
