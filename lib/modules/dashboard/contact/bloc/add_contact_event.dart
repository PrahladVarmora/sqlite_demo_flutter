part of 'add_contact_bloc.dart';

/// [AddContactEvent] abstract class is used Event of bloc.
/// It's an abstract class that extends Equatable and has a single property called props
abstract class AddContactEvent extends Equatable {
  const AddContactEvent();

  @override
  List<Object> get props => [];
}

/// [AddContact] abstract class is used AddContact Event
class AddContact extends AddContactEvent {
  const AddContact(
      {required this.image,
      required this.firstName,
      required this.lastName,
      required this.mobile,
      required this.email,
      required this.catId});

  final String image;
  final String firstName;
  final String lastName;
  final String mobile;
  final String email;
  final int catId;

  @override
  List<Object> get props => [image, firstName, lastName, mobile, email, catId];
}

/// [EditContact] abstract class is used EditContact Event
class EditContact extends AddContactEvent {
  const EditContact(
      {required this.image,
      required this.firstName,
      required this.lastName,
      required this.mobile,
      required this.email,
      required this.contactId,
      required this.catId});

  final String image;
  final String firstName;
  final String lastName;
  final String mobile;
  final String email;
  final int catId;
  final int contactId;

  @override
  List<Object> get props =>
      [image, contactId, firstName, lastName, mobile, email, catId];
}

/// [DeleteContact] abstract class is used EditContact Event
class DeleteContact extends AddContactEvent {
  const DeleteContact({required this.contactId});

  final int contactId;

  @override
  List<Object> get props => [contactId];
}
