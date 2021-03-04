class ContentWordModel {
  final int wordId;
  final String question;
  final String trueAnswer;
  final String firstAnswer;
  final String secondAnswer;
  final String example;
  final String soundName;
  final String imageName;
  final bool check;

  const ContentWordModel({
    this.wordId,
    this.question,
    this.trueAnswer,
    this.firstAnswer,
    this.secondAnswer,
    this.example,
    this.soundName,
    this.imageName,
    this.check,
  });

  ContentWordModel copyWith({
    int wordId,
    String question,
    String trueAnswer,
    String firstAnswer,
    String secondAnswer,
    String example,
    String soundName,
    String imageName,
    bool check,
  }) =>
      ContentWordModel(
        wordId: wordId ?? this.wordId,
        question: question ?? this.question,
        trueAnswer: trueAnswer ?? this.trueAnswer,
        firstAnswer: firstAnswer ?? this.firstAnswer,
        secondAnswer: secondAnswer ?? this.secondAnswer,
        example: example ?? this.example,
        soundName: soundName ?? this.soundName,
        imageName: imageName ?? this.imageName,
        check: check ?? this.check,
      );
}
