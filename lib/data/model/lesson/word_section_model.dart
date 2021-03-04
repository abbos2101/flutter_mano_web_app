class WordSectionModel {
  const WordSectionModel({
    this.id,
    this.correctWord,
    this.incorrectWord,
  });

  final int id;
  final ItemWordSection correctWord;
  final ItemWordSection incorrectWord;

  factory WordSectionModel.fromJson(Map<String, dynamic> json) =>
      WordSectionModel(
        id: json["id"],
        correctWord: json["correctWord"] == null
            ? null
            : ItemWordSection.fromJson(json["correctWord"]),
        incorrectWord: json["incorrectWord"] == null
            ? null
            : ItemWordSection.fromJson(json["incorrectWord"]),
      );
}

class ItemWordSection {
  const ItemWordSection({
    this.id,
    this.ru,
    this.uz,
    this.imageName,
    this.soundName,
    this.example,
    this.gender,
  });

  final int id;
  final String ru;
  final String uz;
  final String imageName;
  final String soundName;
  final String example;
  final String gender;

  factory ItemWordSection.fromJson(Map<String, dynamic> json) =>
      ItemWordSection(
        id: json["id"],
        ru: json["ru"],
        uz: json["uz"],
        imageName: json["image_name"],
        soundName: json["sound_name"],
        example: json["example"],
        gender: json["gender"],
      );
}
