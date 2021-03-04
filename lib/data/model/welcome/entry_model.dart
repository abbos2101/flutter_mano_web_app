class EntryModel {
  const EntryModel({
    this.id,
    this.question,
    this.levelId,
    this.answer,
  });

  final int id;
  final String question;
  final int levelId;
  final bool answer;

  factory EntryModel.fromJson(Map<String, dynamic> json) => EntryModel(
        id: json["id"],
        question: json["question"],
        levelId: json["levelId"],
        answer: json["answer"],
      );
}
