part of 'lesson_bloc.dart';

abstract class LessonEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LaunchEvent extends LessonEvent {}

class LogoutEvent extends LessonEvent {}

class PageChangeEvent extends LessonEvent {
  final int pageIndex;

  PageChangeEvent({this.pageIndex});

  @override
  List<Object> get props => [pageIndex];
}

class PageItemPressedEvent extends LessonEvent {
  final int pageIndex;

  PageItemPressedEvent({this.pageIndex});

  @override
  List<Object> get props => [pageIndex];
}
