class RuleClientModel {
  const RuleClientModel({
    this.id,
    this.name,
  });

  final int id;
  final String name;

  factory RuleClientModel.fromJson(Map<String, dynamic> json) =>
      RuleClientModel(
        id: json["id"],
        name: json["name"],
      );
}
