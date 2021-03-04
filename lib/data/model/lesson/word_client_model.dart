class WordClientModel {
  const WordClientModel({
    this.studied,
    this.onStudied,
  });

  final List<ItemWordClient> studied;
  final List<ItemWordClient> onStudied;

  factory WordClientModel.fromJson(Map<String, dynamic> json) =>
      WordClientModel(
        studied: json["studied"] == null
            ? null
            : List<ItemWordClient>.from(
                json["studied"].map((x) => ItemWordClient.fromJson(x))),
        onStudied: json["onStudied"] == null
            ? null
            : List<ItemWordClient>.from(
                json["onStudied"].map((x) => ItemWordClient.fromJson(x))),
      );
}

class ItemWordClient {
  const ItemWordClient({
    this.id,
    this.count,
    this.ru,
    this.uz,
    this.example,
    this.gender,
    this.imageName,
    this.soundName,
  });

  final int id;
  final int count;
  final String ru;
  final String uz;
  final String example;
  final String gender;
  final String imageName;
  final String soundName;

  factory ItemWordClient.fromJson(Map<String, dynamic> json) => ItemWordClient(
        id: json["id"],
        count: json["count"],
        ru: json["ru"],
        uz: json["uz"],
        example: json["example"],
        gender: json["gender"],
        imageName: json["image_name"],
        soundName: json["sound_name"],
      );
}
