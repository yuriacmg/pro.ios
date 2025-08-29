// ignore_for_file: must_be_immutable

part of 'notice_cubit.dart';

abstract class NoticeState extends Equatable {
  const NoticeState();

  @override
  List<Object> get props => [];
}

class NoticeInitial extends NoticeState {
  NoticeInitial({this.isVisible = true});
  bool isVisible;
}
