class LessonClientModel {
  const LessonClientModel({
    this.levelName,
    this.name,
    this.id,
    this.blockId,
    this.levelId,
    this.blockName,
  });

  final String levelName;
  final String name;
  final int id;
  final int blockId;
  final int levelId;
  final String blockName;

  factory LessonClientModel.fromJson(Map<String, dynamic> json) =>
      LessonClientModel(
        levelName: json["levelName"],
        name: json["name"],
        id: json["id"],
        blockId: json["blockId"],
        levelId: json["levelId"],
        blockName: json["blockName"],
      );
}
