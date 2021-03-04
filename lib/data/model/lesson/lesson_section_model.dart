class LessonSectionModel {
  const LessonSectionModel({
    this.name,
    this.id,
    this.blockName,
    this.type,
  });

  final String name;
  final int id;
  final String blockName;
  final String type;

  factory LessonSectionModel.fromJson(Map<String, dynamic> json) =>
      LessonSectionModel(
        name: json["name"],
        id: json["id"],
        blockName: json["blockName"],
        type: json["type"],
      );
}
