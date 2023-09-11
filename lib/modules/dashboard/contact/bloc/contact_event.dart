part of 'contact_bloc.dart';

/// [ContactEvent] abstract class is used Event of bloc.
/// It's an abstract class that extends Equatable and has a single property called props
abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

/// [Contact] abstract class is used Contact Event
class Contact extends ContactEvent {}
