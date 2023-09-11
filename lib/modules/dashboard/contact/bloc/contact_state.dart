part of 'contact_bloc.dart';

/// [ContactState] abstract class is used Contact State
abstract class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

/// [ContactInitial] class is used Contact State Initial
class ContactInitial extends ContactState {}

/// [ContactLoading] class is used Contact State Loading
class ContactLoading extends ContactState {}

/// [ContactResponse] class is used Contact State Response
class ContactResponse extends ContactState {
  final List<ModelContact> mContact;

  const ContactResponse({required this.mContact});

  @override
  List<Object> get props => [mContact];
}

/// [ContactFailure] class is used Contact State Failure
class ContactFailure extends ContactState {
  final String mError;

  const ContactFailure({required this.mError});

  @override
  List<Object> get props => [mError];
}
