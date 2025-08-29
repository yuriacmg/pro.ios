part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();
}

class GetContactDataEvent extends ContactEvent {
  @override
  List<Object> get props => [];
}

class GetContactDataLocalEvent extends ContactEvent {
  @override
  List<Object> get props => [];
}
