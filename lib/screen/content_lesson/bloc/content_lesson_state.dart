part of 'content_lesson_bloc.dart';

abstract class ContentLessonState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends ContentLessonState {}

class FailState extends ContentLessonState {
  final String message;

  FailState({this.message});

  @override
  List<Object> get props => [message];
}

class SuccessState extends ContentLessonState {
  final String indexLessonName;
  final String lessonName;
  final String blocName;
  final bool word;
  final bool rule;
  final bool exercise;

  SuccessState({
    this.indexLessonName,
    this.lessonName,
    this.blocName,
    this.word,
    this.rule,
    this.exercise,
  });

  @override
  List<Object> get props => [
        indexLessonName,
        lessonName,
        blocName,
        word,
        rule,
        exercise,
      ];
}
