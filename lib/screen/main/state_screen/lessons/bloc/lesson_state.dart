part of 'lesson_bloc.dart';

abstract class LessonState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends LessonState {}

class FailState extends LessonState {
  final String message;

  FailState({this.message});

  @override
  List<Object> get props => [message];
}

class SuccessState extends LessonState {
  final int levelId;
  final String levelName;
  final int progress;
  final String blocName;
  final List<PageModel> pageList;
  final int last;
  final int current;

  SuccessState({
    this.levelId,
    this.levelName,
    this.progress,
    this.blocName,
    this.pageList,
    this.last,
    this.current,
  });

  @override
  List<Object> get props => [
        levelId,
        levelName,
        progress,
        blocName,
        pageList,
        last,
        current,
      ];
}
