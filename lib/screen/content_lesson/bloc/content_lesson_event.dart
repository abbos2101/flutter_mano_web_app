part of 'content_lesson_bloc.dart';

abstract class ContentLessonEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LaunchEvent extends ContentLessonEvent {}

class PushWordEvent extends ContentLessonEvent {}

class PushRuleEvent extends ContentLessonEvent {}

class PushExerciseEvent extends ContentLessonEvent {}
