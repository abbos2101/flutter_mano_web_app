part of 'content_exercise_bloc.dart';

abstract class ContentExerciseState extends Equatable {
  double progress;
}

class LoadingState extends ContentExerciseState {
  @override
  List<Object> get props => [progress];
}

class FailState extends ContentExerciseState {
  final String message;

  FailState({this.message});

  @override
  List<Object> get props => [progress, message];
}

class CheckState extends ContentExerciseState {
  final String name;
  final int id;
  final int lessonId;
  final String question;
  final String correct;
  final String wrong;
  final int ruleId;

  CheckState({
    this.name,
    this.id,
    this.lessonId,
    this.question,
    this.correct,
    this.wrong,
    this.ruleId,
  });

  @override
  List<Object> get props => [
        progress,
        name,
        id,
        lessonId,
        question,
        correct,
        wrong,
        ruleId,
      ];
}

class PictureState extends ContentExerciseState {
  final int id;
  final int correctWordId;
  final int wrongWordId;
  final String correctRu;
  final String correctUz;
  final String correctSoundLink;
  final String wrongRu;
  final String wrongUz;
  final String wrongImageLink;
  final String wrongSoundLink;
  final String correctImageLink;

  PictureState({
    this.id,
    this.correctWordId,
    this.wrongWordId,
    this.correctRu,
    this.correctUz,
    this.correctSoundLink,
    this.wrongRu,
    this.wrongUz,
    this.wrongImageLink,
    this.wrongSoundLink,
    this.correctImageLink,
  });

  @override
  List<Object> get props => [
        progress,
        id,
        correctWordId,
        wrongWordId,
        correctRu,
        correctUz,
        correctSoundLink,
        wrongRu,
        wrongUz,
        wrongImageLink,
        wrongSoundLink,
        correctImageLink,
      ];
}

class SentenceState extends ContentExerciseState {
  final String name;
  final int id;
  final int lessonId;
  final String question;
  final int ruleId;
  final String answer;

  SentenceState({
    this.name,
    this.id,
    this.lessonId,
    this.question,
    this.ruleId,
    this.answer,
  });

  @override
  List<Object> get props => [
        progress,
        name,
        id,
        lessonId,
        question,
        ruleId,
        answer,
      ];
}

class PutWordState extends ContentExerciseState {
  final String name;
  final int id;
  final String sentence;
  final int lessonId;
  final String correct;
  final String wrong;
  final int ruleId;

  PutWordState({
    this.name,
    this.id,
    this.sentence,
    this.lessonId,
    this.correct,
    this.wrong,
    this.ruleId,
  });

  @override
  List<Object> get props => [
        progress,
        name,
        id,
        sentence,
        lessonId,
        correct,
        wrong,
        ruleId,
      ];
}

class FinishState extends ContentExerciseState {
  @override
  List<Object> get props => [progress];
}
