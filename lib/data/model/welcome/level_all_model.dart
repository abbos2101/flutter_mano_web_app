class LevelAllModel {
  const LevelAllModel({this.id, this.name});

  final int id;
  final String name;

  factory LevelAllModel.fromJson(Map<String, dynamic> json) =>
      LevelAllModel(id: json["id"], name: json["name"]);
}
