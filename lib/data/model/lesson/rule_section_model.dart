class RuleSectionModel {
  const RuleSectionModel({
    this.id,
    this.ruleId,
    this.name,
    this.type,
    this.ruleSentences,
    this.ruleWords,
  });

  final int id;
  final int ruleId;
  final String name;
  final String type;
  final List<ItemRuleSection> ruleSentences;
  final List<ItemRuleSection> ruleWords;

  factory RuleSectionModel.fromJson(Map<String, dynamic> json) =>
      RuleSectionModel(
        id: json["id"],
        ruleId: json["ruleId"],
        name: json["name"],
        type: json["type"],
        ruleSentences: json["ruleSentences"] == null
            ? null
            : List<ItemRuleSection>.from(
                json["ruleSentences"].map((x) => ItemRuleSection.fromJson(x))),
        ruleWords: json["ruleWords"] == null
            ? null
            : List<ItemRuleSection>.from(
                json["ruleWords"].map((x) => ItemRuleSection.fromJson(x))),
      );
}

class ItemRuleSection {
  const ItemRuleSection({
    this.id,
    this.uz,
    this.ru,
    this.soundId,
    this.link,
  });

  final int id;
  final String uz;
  final String ru;
  final String soundId;
  final String link;

  factory ItemRuleSection.fromJson(Map<String, dynamic> json) =>
      ItemRuleSection(
        id: json["id"],
        uz: json["uz"],
        ru: json["ru"],
        soundId: json["soundId"],
        link: json["link"],
      );
}
