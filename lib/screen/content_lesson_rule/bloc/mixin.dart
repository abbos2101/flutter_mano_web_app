part of 'content_rule_bloc.dart';

mixin ContentRuleBlocImp {
  void onPressedNextButton({int ruleId, bool answer});

  void onPlayAudio(String soundName);

  void onPressedFinish();
}

mixin ContentRuleBlocWith {
  List<T> privateGetUniqueList<T>(List<T> list) {
    List<T> newList = [];
    for (int i = 0; i < list.length; i++) {
      bool x = true;
      for (int j = 0; j < newList.length; j++) {
        if (newList[j] == list[i]) {
          x = false;
          break;
        }
      }
      if (x) newList.add(list[i]);
    }
    return newList;
  }

  List<ContentRuleState> privateGetStateList({
    @required List<RuleSectionModel> ruleList,
    @required String TYPE_EXAMPLE,
    @required String TYPE_SENTENCE,
  }) {
    List<ContentRuleState> stateList = [];
    for (int i = 0; i < ruleList.length; i++) {
      final RuleSectionModel model = ruleList[i];
      if (model.type == TYPE_EXAMPLE) {
        final List<ItemRuleWords> ruleWords = model.ruleWords
            .map((e) => ItemRuleWords(
                  id: e.id,
                  uz: e.uz,
                  ru: e.ru,
                  soundId: e.soundId,
                  link: e.link,
                ))
            .toList();
        stateList.add(ExampleState(
          id: model.id,
          type: model.type,
          name: model.name,
          ruleId: model.ruleId,
          ruleWords: ruleWords,
        ));
      } else {
        final List<ItemRuleSection> ruleSentences = model.ruleSentences ?? [];
        for (int j = 0; j < ruleSentences.length; j++) {
          if ((ruleSentences[j].uz ?? "").isNotEmpty &&
              (ruleSentences[j].ru ?? "").isNotEmpty)
            stateList.add(SentenceState(
              id: model.id,
              type: model.type,
              name: model.name,
              ruleId: model.ruleId,
              itemId: ruleSentences[j].id,
              itemUz: ruleSentences[j].uz,
              itemRu: ruleSentences[j].ru,
              itemSoundId: ruleSentences[j].soundId,
              itemLink: ruleSentences[j].link,
            ));
        }
      }
    }

    for (int i = 0; i < stateList.length; i++)
      if (stateList[i] is ContentRuleState)
        stateList[i].progress = (i / stateList.length).toDouble();
    stateList.add(FinishState());
    return stateList;
  }
}
