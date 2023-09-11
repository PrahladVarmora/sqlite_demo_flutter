import 'package:silver_touch_task/modules/core/utils/common_import.dart';
import 'package:silver_touch_task/modules/dashboard/contact/model/model_contact.dart';

part 'contact_event.dart';

part 'contact_state.dart';

/// Notifies the [ContactBloc] of a new [ContactEvent] which triggers
/// [RepositoryContact] This class used to API and bloc connection.
/// [ApiProvider] class is used to network API call.
class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc({
    required OpenHelper openHelper,
  })  : mOpenHelper = openHelper,
        super(ContactInitial()) {
    on<Contact>(_onContact);
  }

  final OpenHelper mOpenHelper;

  /// _onContact is a function that takes an ContactAdd event, an Emitter<ContactState> emit, and returns
  /// a Future<void> that emits an ContactLoading state, and then either an ContactResponse state or an
  /// ContactFailure state
  ///
  /// Args:
  ///   event (ContactAdd): The event that was dispatched.
  ///   emit (Emitter<ContactState>): This is the function that you use to emit events.
  void _onContact(
    Contact event,
    Emitter<ContactState> emit,
  ) async {
    /// Emitting an ContactLoading state.
    try {
      emit(ContactLoading());
      List<ModelContact> res = await mOpenHelper.getContact();
      if (res.isNotEmpty) {
        emit(ContactResponse(mContact: res));
      } else {
        emit(const ContactFailure(mError: ValidationString.validationNoData));
      }
    } catch (e) {
      emit(const ContactFailure(
          mError: ValidationString.validationInternalServerIssue));
    }
  }
}
