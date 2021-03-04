class ExerciseSectionModel {
  const ExerciseSectionModel({
    this.exerciseCheck,
    this.exercisePicture,
    this.exerciseSentence,
    this.exercisePutWord,
  });

  final List<ItemExerciseCheck> exerciseCheck;
  final List<ItemExercisePicture> exercisePicture;
  final List<ItemExerciseSentence> exerciseSentence;
  final List<ItemExercisePut> exercisePutWord;

  factory ExerciseSectionModel.fromJson(Map<String, dynamic> json) =>
      ExerciseSectionModel(
        exerciseCheck: json["exerciseCheck"] == null
            ? null
            : List<ItemExerciseCheck>.from(json["exerciseCheck"]
                .map((x) => ItemExerciseCheck.fromJson(x))),
        exercisePicture: json["exercisePicture"] == null
            ? null
            : List<ItemExercisePicture>.from(json["exercisePicture"]
                .map((x) => ItemExercisePicture.fromJson(x))),
        exerciseSentence: json["exerciseSentence"] == null
            ? null
            : List<ItemExerciseSentence>.from(json["exerciseSentence"]
                .map((x) => ItemExerciseSentence.fromJson(x))),
        exercisePutWord: json["exercisePutWord"] == null
            ? null
            : List<ItemExercisePut>.from(json["exercisePutWord"]
                .map((x) => ItemExercisePut.fromJson(x))),
      );
}

class ItemExerciseCheck {
  const ItemExerciseCheck({
    this.name,
    this.id,
    this.lessonId,
    this.question,
    this.correct,
    this.wrong,
    this.ruleId,
  });

  final String name;
  final int id;
  final int lessonId;
  final String question;
  final String correct;
  final String wrong;
  final int ruleId;

  factory ItemExerciseCheck.fromJson(Map<String, dynamic> json) =>
      ItemExerciseCheck(
        name: json["name"],
        id: json["id"],
        lessonId: json["lessonId"],
        question: json["question"],
        correct: json["correct"],
        wrong: json["wrong"],
        ruleId: json["ruleId"],
      );
}

class ItemExercisePicture {
  const ItemExercisePicture({
    this.id,
    this.correctWordId,
    this.wrongWordId,
    this.correctRu,
    this.correctUz,
    this.correctSoundLink,
    this.wrongRu,
    this.wrongUz,
    this.wrongImageLink,
    this.wrongSoundLink,
    this.correctImageLink,
  });

  final int id;
  final int correctWordId;
  final int wrongWordId;
  final String correctRu;
  final String correctUz;
  final String correctSoundLink;
  final String wrongRu;
  final String wrongUz;
  final String wrongImageLink;
  final String wrongSoundLink;
  final String correctImageLink;

  factory ItemExercisePicture.fromJson(Map<String, dynamic> json) =>
      ItemExercisePicture(
        id: json["id"],
        correctWordId: json["correctWordId"],
        wrongWordId: json["wrongWordId"],
        correctRu: json["correctRu"],
        correctUz: json["correctUz"],
        correctSoundLink: json["correctSoundLink"],
        wrongRu: json["wrongRu"],
        wrongUz: json["wrongUz"],
        wrongImageLink: json["wrongImageLink"],
        wrongSoundLink: json["wrongSoundLink"],
        correctImageLink: json["correctImageLink"],
      );
}

class ItemExerciseSentence {
  const ItemExerciseSentence({
    this.name,
    this.id,
    this.lessonId,
    this.question,
    this.ruleId,
    this.answer,
  });

  final String name;
  final int id;
  final int lessonId;
  final String question;
  final int ruleId;
  final String answer;

  factory ItemExerciseSentence.fromJson(Map<String, dynamic> json) =>
      ItemExerciseSentence(
        name: json["name"],
        id: json["id"],
        lessonId: json["lessonId"],
        question: json["question"],
        ruleId: json["ruleId"],
        answer: json["answer"],
      );
}

class ItemExercisePut {
  const ItemExercisePut({
    this.name,
    this.id,
    this.sentence,
    this.lessonId,
    this.correct,
    this.wrong,
    this.ruleId,
  });

  final String name;
  final int id;
  final String sentence;
  final int lessonId;
  final String correct;
  final String wrong;
  final int ruleId;

  factory ItemExercisePut.fromJson(Map<String, dynamic> json) =>
      ItemExercisePut(
        name: json["name"],
        id: json["id"],
        sentence: json["sentence"],
        lessonId: json["lessonId"],
        correct: json["correct"],
        wrong: json["wrong"],
        ruleId: json["ruleId"],
      );
}
