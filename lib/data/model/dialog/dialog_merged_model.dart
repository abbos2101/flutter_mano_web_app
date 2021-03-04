// {
// "id": 1,
// "audio_name": "dialog-audio-1.mp3",
// "question": "To'g'ri so'zni toping",
// "correct": "дом",
// "wrong": "хлопок",
// "type": "word"
// }

class DialogMergedModel {
  static const String WORD_TYPE = "word";
  static const String SENTENCE_TYPE = "sentence";

  const DialogMergedModel({
    this.id,
    this.audioName,
    this.question,
    this.correct,
    this.wrong,
    this.type,
  });

  final int id;
  final String audioName;
  final String question;
  final String correct;
  final String wrong;
  final String type;

  factory DialogMergedModel.fromJson(Map<String, dynamic> json) =>
      DialogMergedModel(
        id: json['id'],
        audioName: json['audio_name'],
        question: json['question'],
        wrong: json['wrong'],
        correct: json['correct'],
        type: json['type'],
      );

  @override
  String toString() {
    return 'DialogMergedModel($question - $correct - $wrong)';
  }
}

extension When on DialogMergedModel {
  R when<R>({
    R Function() onTypeWord,
    R Function() onTypeSentence,
  }) {
    if (this.type == DialogMergedModel.WORD_TYPE)
      return onTypeWord();
    else if (this.type == DialogMergedModel.SENTENCE_TYPE)
      return onTypeSentence();
    else
      throw new Exception('Unhendled part, could be anything');
  }
}
