import '../../../core/utils/common_import.dart';
import '../model/model_contact.dart';

part 'add_contact_event.dart';
part 'add_contact_state.dart';

/// Notifies the [AddContactBloc] of a new [AddContactEvent] which triggers
/// [RepositoryAddContact] This class used to API and bloc connection.
/// [ApiProvider] class is used to network API call.
class AddContactBloc extends Bloc<AddContactEvent, AddContactState> {
  AddContactBloc({
    required OpenHelper openHelper,
  })  : mOpenHelper = openHelper,
        super(AddContactInitial()) {
    on<AddContact>(_onAddContact);
    on<EditContact>(_onEditContact);
    on<DeleteContact>(_onDeleteContact);
  }

  final OpenHelper mOpenHelper;

  /// _onAddContact is a function that takes an AddContactAdd event, an Emitter<AddContactState> emit, and returns
  /// a Future<void> that emits an AddContactLoading state, and then either an AddContactResponse state or an
  /// AddContactFailure state
  ///
  /// Args:
  ///   event (AddContactAdd): The event that was dispatched.
  ///   emit (Emitter<AddContactState>): This is the function that you use to emit events.
  void _onAddContact(
    AddContact event,
    Emitter<AddContactState> emit,
  ) async {
    /// Emitting an AddContactLoading state.
    emit(AddContactLoading());
    try {
      if (event.image.isEmpty) {
        emit(const AddContactFailure(mError: AppStrings.textPleaseSelectImage));
      } else if (event.firstName.isEmpty) {
        emit(const AddContactFailure(
            mError: AppStrings.textPleaseEnterFirstName));
      } else if (event.lastName.isEmpty) {
        emit(const AddContactFailure(
            mError: AppStrings.textPleaseEnterLastName));
      } else if (event.mobile.isEmpty) {
        emit(const AddContactFailure(
            mError: AppStrings.textPleaseEnterMobileNumber));
      } else if (event.email.isEmpty) {
        emit(const AddContactFailure(mError: AppStrings.textPleaseEnterEmail));
      } else if (!validateEmail(event.email.trim())) {
        emit(const AddContactFailure(
            mError: AppStrings.textPleaseEnterValidEmail));
      } else {
        ModelContact mModelContact = ModelContact();
        mModelContact.contactFirstName = event.firstName;
        mModelContact.contactLastName = event.lastName;
        mModelContact.contactMobile = event.mobile;
        mModelContact.contactCategory = event.catId;
        mModelContact.contactEmail = event.email;
        mModelContact.contactImage = event.image;
        var res = await mOpenHelper.insertContact(mModelContact);
        if (res == 1) {
          emit(AddContactResponse());
        } else {
          emit(const AddContactFailure(
              mError: AppStrings.textSomethingWentWrong));
        }
      }
    } catch (e) {
      emit(const AddContactFailure(
          mError: ValidationString.validationInternalServerIssue));
    }
  }

  /// _onEditContact is a function that takes an EditContact event, an Emitter<AddContactState> emit, and returns
  /// a Future<void> that emits an AddContactLoading state, and then either an AddContactResponse state or an
  /// AddContactFailure state
  ///
  /// Args:
  ///   event (EditContact): The event that was dispatched.
  ///   emit (Emitter<AddContactState>): This is the function that you use to emit events.
  void _onEditContact(
    EditContact event,
    Emitter<AddContactState> emit,
  ) async {
    /// Emitting an AddContactLoading state.
    emit(AddContactLoading());
    try {
      if (event.image.isEmpty) {
        emit(const AddContactFailure(mError: AppStrings.textPleaseSelectImage));
      } else if (event.firstName.isEmpty) {
        emit(const AddContactFailure(
            mError: AppStrings.textPleaseEnterFirstName));
      } else if (event.lastName.isEmpty) {
        emit(const AddContactFailure(
            mError: AppStrings.textPleaseEnterLastName));
      } else if (event.mobile.isEmpty) {
        emit(const AddContactFailure(
            mError: AppStrings.textPleaseEnterMobileNumber));
      } else if (event.email.isEmpty) {
        emit(const AddContactFailure(mError: AppStrings.textPleaseEnterEmail));
      } else if (!validateEmail(event.email.trim())) {
        emit(const AddContactFailure(
            mError: AppStrings.textPleaseEnterValidEmail));
      } else {
        Map<String, dynamic> row = {
          AppConfig.contactImage: event.image,
          AppConfig.contactFirstName: event.firstName,
          AppConfig.contactLastName: event.lastName,
          AppConfig.contactMobile: event.mobile,
          AppConfig.contactEmail: event.email,
          AppConfig.contactCategory: event.catId,
        };
        var res = await mOpenHelper.updateContact(row, event.contactId);
        if (res) {
          emit(AddContactResponse());
        } else {
          emit(const AddContactFailure(
              mError: AppStrings.textSomethingWentWrong));
        }
      }
    } catch (e) {
      emit(const AddContactFailure(
          mError: ValidationString.validationInternalServerIssue));
    }
  }

  /// _onDeleteContact is a function that takes an DeleteContact event, an Emitter<AddContactState> emit, and returns
  /// a Future<void> that emits an AddContactLoading state, and then either an AddContactResponse state or an
  /// AddContactFailure state
  ///
  /// Args:
  ///   event (DeleteContact): The event that was dispatched.
  ///   emit (Emitter<AddContactState>): This is the function that you use to emit events.
  void _onDeleteContact(
    DeleteContact event,
    Emitter<AddContactState> emit,
  ) async {
    /// Emitting an AddContactLoading state.
    emit(AddContactLoading());
    try {
      await mOpenHelper.deleteContact(event.contactId);
      emit(AddContactResponse());
    } catch (e) {
      emit(const AddContactFailure(
          mError: ValidationString.validationInternalServerIssue));
    }
  }
}
