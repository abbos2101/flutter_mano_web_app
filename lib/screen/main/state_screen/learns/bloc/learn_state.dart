part of 'learn_bloc.dart';

abstract class LearnState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends LearnState {}

class FailState extends LearnState {
  final String message;

  FailState({this.message});

  @override
  List<Object> get props => [message];
}

class ResultState extends LearnState {
  final WordClientModel wordClientModel;
  final List<RuleClientModel> ruleList;

  ResultState({this.wordClientModel, this.ruleList});

  @override
  List<Object> get props => [wordClientModel, ruleList];
}
