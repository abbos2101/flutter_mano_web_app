class LessonAccessModel {
  const LessonAccessModel({
    this.rules,
    this.lessonId,
    this.words,
    this.blockId,
    this.lessonName,
    this.blockName,
    this.exercises,
  });

  final bool rules;
  final int lessonId;
  final bool words;
  final int blockId;
  final String lessonName;
  final String blockName;
  final bool exercises;

  factory LessonAccessModel.fromJson(Map<String, dynamic> json) =>
      LessonAccessModel(
        rules: json["rules"],
        lessonId: json["lessonId"],
        words: json["words"],
        blockId: json["blockId"],
        lessonName: json["lessonName"],
        blockName: json["blockName"],
        exercises: json["exercises"],
      );

  factory LessonAccessModel.empty({String lessonName = ''}) =>
      LessonAccessModel(lessonName: lessonName);
}
