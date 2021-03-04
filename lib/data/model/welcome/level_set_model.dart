class LevelSetModel {
  const LevelSetModel({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.role,
    this.token,
    this.level,
    this.lesson,
    this.block,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String role;
  final String token;
  final int level;
  final int lesson;
  final int block;

  factory LevelSetModel.fromJson(Map<String, dynamic> json) => LevelSetModel(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        username: json["username"],
        role: json["role"],
        token: json["token"],
        level: json["level"],
        lesson: json["lesson"],
        block: json["block"],
      );
}
