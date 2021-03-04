part of 'content_word_bloc.dart';

abstract class ContentWordState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends ContentWordState {}

class FailState extends ContentWordState {
  final String message;

  FailState({this.message});

  @override
  List<Object> get props => [message];
}

class TestState extends ContentWordState {
  final int wordId;
  final String question;
  final String trueAnswer;
  final String firstAnswer;
  final String secondAnswer;
  final String imageName;
  final double progress;

  TestState({
    this.wordId,
    this.question,
    this.trueAnswer,
    this.firstAnswer,
    this.secondAnswer,
    this.imageName,
    this.progress,
  });

  @override
  List<Object> get props => [
        wordId,
        question,
        trueAnswer,
        firstAnswer,
        secondAnswer,
        imageName,
        progress,
      ];
}

class CheckState extends ContentWordState {
  final int wordId;
  final String question;
  final String answer;
  final String example;
  final String imageName;
  final String soundName;
  final bool check;
  final double progress;

  CheckState({
    this.wordId,
    this.question,
    this.answer,
    this.example,
    this.imageName,
    this.soundName,
    this.check,
    this.progress,
  });

  @override
  List<Object> get props => [
        wordId,
        question,
        answer,
        example,
        imageName,
        soundName,
        check,
        progress,
      ];
}

class FinishState extends ContentWordState {
  final int rand;
  final List<ContentWordModel> list;
  final int count;

  FinishState({this.rand, this.list, this.count});

  @override
  List<Object> get props => [rand, list, count];
}
