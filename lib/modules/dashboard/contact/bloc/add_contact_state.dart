part of 'add_contact_bloc.dart';


/// [AddContactState] abstract class is used AddContact State
abstract class AddContactState extends Equatable {
  const AddContactState();

  @override
  List<Object> get props => [];
}

/// [AddContactInitial] class is used AddContact State Initial
class AddContactInitial extends AddContactState {}

/// [AddContactLoading] class is used AddContact State Loading
class AddContactLoading extends AddContactState {}

/// [AddContactResponse] class is used AddContact State Response
class AddContactResponse extends AddContactState {}

/// [AddContactFailure] class is used AddContact State Failure
class AddContactFailure extends AddContactState {
  final String mError;

  const AddContactFailure({required this.mError});

  @override
  List<Object> get props => [mError];
}
