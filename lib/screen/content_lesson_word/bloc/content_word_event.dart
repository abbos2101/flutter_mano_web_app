part of 'content_word_bloc.dart';

abstract class ContentWordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LaunchEvent extends ContentWordEvent {}

class BackEvent extends ContentWordEvent {}

class WordPressedEvent extends ContentWordEvent {
  final String word;

  WordPressedEvent({this.word});

  @override
  List<Object> get props => [word];
}

class AudioPlayEvent extends ContentWordEvent {
  final String soundName;

  AudioPlayEvent({this.soundName});

  @override
  List<Object> get props => [soundName];
}

class NextQuestionEvent extends ContentWordEvent {}

class FinishCheckEvent extends ContentWordEvent {
  final int index;

  FinishCheckEvent({this.index});

  @override
  List<Object> get props => [index];
}

class FinishAddEvent extends ContentWordEvent {}
