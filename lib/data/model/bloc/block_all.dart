class BlockAllModel {
  const BlockAllModel({this.id, this.levelName, this.name, this.description});

  final int id;
  final String levelName;
  final String name;
  final String description;

  factory BlockAllModel.fromJson(Map<String, dynamic> json) => BlockAllModel(
        id: json['id'],
        levelName: json['levelName'],
        name: json['name'],
        description: json['description'],
      );
}
