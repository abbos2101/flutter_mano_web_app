class BlockOneModel {
  const BlockOneModel({this.id, this.levelId, this.name});

  final int id;
  final int levelId;
  final String name;

  factory BlockOneModel.fromJson(Map<String, dynamic> json) => BlockOneModel(
        id: json['id'],
        levelId: json['levelId'],
        name: json['name'],
      );
}
