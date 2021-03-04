part of 'content_rule_bloc.dart';

abstract class ContentRuleState extends Equatable {
  double progress = 0;
}

class LoadingState extends ContentRuleState {
  @override
  List<Object> get props => [];
}

class FailState extends ContentRuleState {
  final String message;

  FailState({this.message});

  @override
  List<Object> get props => [message];
}

class ExampleState extends ContentRuleState {
  final int id;
  final int ruleId;
  final String name;
  final String type;
  final List<ItemRuleWords> ruleWords;

  ExampleState({
    this.id,
    this.ruleId,
    this.name,
    this.type,
    this.ruleWords,
  });

  @override
  List<Object> get props => [id, ruleId, name, type, ruleWords, progress];
}

class ItemRuleWords {
  final int id;
  final String uz;
  final String ru;
  final String soundId;
  final String link;

  const ItemRuleWords({this.id, this.uz, this.ru, this.soundId, this.link});
}

class SentenceState extends ContentRuleState {
  final int id;
  final int ruleId;
  final String name;
  final String type;
  final int itemId;
  final String itemUz;
  final String itemRu;
  final String itemSoundId;
  final String itemLink;

  SentenceState({
    this.id,
    this.ruleId,
    this.name,
    this.type,
    this.itemId,
    this.itemUz,
    this.itemRu,
    this.itemSoundId,
    this.itemLink,
  });

  @override
  List<Object> get props => [
        id,
        ruleId,
        name,
        type,
        itemId,
        itemUz,
        itemRu,
        itemSoundId,
        itemLink,
        progress,
      ];
}

class FinishState extends ContentRuleState {
  FinishState();

  @override
  List<Object> get props => [];
}
