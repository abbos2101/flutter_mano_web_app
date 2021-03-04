part of 'content_exercise_bloc.dart';

abstract class ContentExerciseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadExerciseEvent extends ContentExerciseEvent {}

class NextPageEvent extends ContentExerciseEvent {
  final int exerciseCheckId;
  final int exercisePictureId;
  final int exerciseSentenceId;
  final int exercisePutWordId;
  final bool answer;

  NextPageEvent({
    this.exerciseCheckId,
    this.exercisePictureId,
    this.exerciseSentenceId,
    this.exercisePutWordId,
    this.answer,
  });

  @override
  List<Object> get props => [
        exerciseCheckId,
        exercisePictureId,
        exerciseSentenceId,
        exercisePutWordId,
        answer
      ];
}

class PreviousEvent extends ContentExerciseEvent {}

class FinishEvent extends ContentExerciseEvent {}
