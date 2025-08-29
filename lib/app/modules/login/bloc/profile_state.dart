// ignore_for_file: must_be_immutable

part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  
  @override
  List<Object> get props => [];
}

class ProfileInitialState extends ProfileState {}

class ProfileDataState extends ProfileState {
  ProfileDataState(this.entity);
  ProfileEntity entity;
}
