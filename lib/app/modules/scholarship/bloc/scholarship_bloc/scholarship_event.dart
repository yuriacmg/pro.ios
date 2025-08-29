part of 'scholarship_bloc.dart';

abstract class ScholarshipEvent extends Equatable {
  const ScholarshipEvent();

  @override
  List<Object> get props => [];
}

class AddPageEvent extends ScholarshipEvent {
  const AddPageEvent(this.pageIndex);
  final int pageIndex;

  @override
  List<Object> get props => [pageIndex];
}
