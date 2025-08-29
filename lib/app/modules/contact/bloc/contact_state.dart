// ignore_for_file: lines_longer_than_80_chars

part of 'contact_bloc.dart';

abstract class ContactState extends Equatable {
  const ContactState();
}

class ContactInitialState extends ContactState {
  @override
  List<Object> get props => [];
}

class ContactLoadCompleteState extends ContactState {
  const ContactLoadCompleteState(this.chanelResponse, this.socialResponse);

  final ContactDataModel chanelResponse;
  final ContactDataModel socialResponse;

  @override
  List<Object> get props => [chanelResponse, socialResponse];
}

class ContactLoadLocalCompleteState extends ContactState {
  const ContactLoadLocalCompleteState(this.listCanal, this.listContacto, this.schedule);

  final List<CanalAtencionEntity> listCanal;
  final List<ContactoEntity> listContacto;
  final CanalAtencionEntity schedule; 

  @override
  List<Object> get props => [listCanal, listContacto, schedule];
}
