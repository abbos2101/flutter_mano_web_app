part of 'content_rule_bloc.dart';

abstract class ContentRuleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadRuleEvent extends ContentRuleEvent {}

class NextPageEvent extends ContentRuleEvent {
  final int ruleId;
  final bool answer;

  NextPageEvent({@required this.ruleId, @required this.answer});

  @override
  List<Object> get props => [ruleId, answer];
}

class PreviousEvent extends ContentRuleEvent {}

class AudioPlayEvent extends ContentRuleEvent {
  final String soundName;

  AudioPlayEvent({@required this.soundName});

  @override
  List<Object> get props => [soundName];
}

class FinishEvent extends ContentRuleEvent {}

class FaqScreenEvent extends ContentRuleEvent {
  final int itemId;

  FaqScreenEvent({this.itemId});

  @override
  List<Object> get props => [itemId];
}
