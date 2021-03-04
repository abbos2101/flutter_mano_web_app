class BlockAccessModel {
  const BlockAccessModel({
    this.levelName,
    this.blockId,
    this.levelId,
    this.exams,
    this.blockName,
    this.dialogs,
    this.lessons,
  });

  final String levelName;
  final int blockId;
  final int levelId;
  final bool exams;
  final String blockName;
  final bool dialogs;
  final bool lessons;

  factory BlockAccessModel.fromJson(Map<String, dynamic> json) =>
      BlockAccessModel(
        levelName: json["levelName"],
        blockId: json["blockId"],
        levelId: json["levelId"],
        exams: json["exams"],
        blockName: json["blockName"],
        dialogs: json["dialogs"],
        lessons: json["lessons"],
      );
}
