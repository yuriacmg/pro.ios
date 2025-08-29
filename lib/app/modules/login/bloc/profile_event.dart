// ignore_for_file: must_be_immutable

part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileDataEvent extends ProfileEvent {}

class ProfileUpdateDataEvent extends ProfileEvent {
  ProfileUpdateDataEvent(this.prefix, this.num);
  String prefix;
  String num;
}
