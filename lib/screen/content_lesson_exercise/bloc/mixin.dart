part of 'content_exercise_bloc.dart';

mixin ContentExerciseImp {
  void onNext({
    @required int exerciseCheckId,
    @required int exercisePictureId,
    @required int exerciseSentenceId,
    @required int exercisePutWordId,
    @required bool answer,
  });

  void onPressedFinish();
}
mixin ContentExerciseWith {
  List<ContentExerciseState> privateGetStateList({
    ExerciseSectionModel exerciseSectionModel,
  }) {
    final List<ContentExerciseState> stateList = [];
    exerciseSectionModel.exerciseCheck.forEach((it) {
      stateList.add(CheckState(
        id: it.id,
        lessonId: it.lessonId,
        question: it.question,
        name: it.name,
        ruleId: it.ruleId,
        correct: it.correct,
        wrong: it.wrong,
      ));
    });
    exerciseSectionModel.exercisePicture.forEach((it) {
      stateList.add(PictureState(
        id: it.id,
        correctWordId: it.correctWordId,
        correctUz: it.correctUz,
        correctRu: it.correctRu,
        correctSoundLink: it.correctSoundLink,
        correctImageLink: it.correctImageLink,
        wrongWordId: it.wrongWordId,
        wrongUz: it.wrongUz,
        wrongRu: it.wrongRu,
        wrongSoundLink: it.wrongSoundLink,
        wrongImageLink: it.wrongImageLink,
      ));
    });
    exerciseSectionModel.exerciseSentence.forEach((it) {
      stateList.add(SentenceState(
        id: it.id,
        ruleId: it.ruleId,
        lessonId: it.lessonId,
        name: it.name,
        question: it.question,
        answer: it.answer,
      ));
    });
    exerciseSectionModel.exercisePutWord.forEach((it) {
      stateList.add(PutWordState(
        id: it.id,
        ruleId: it.ruleId,
        lessonId: it.lessonId,
        name: it.name,
        correct: it.correct,
        wrong: it.wrong,
        sentence: it.sentence,
      ));
    });
    for (int i = 0; i < stateList.length; i++)
      stateList[i].progress = (i / stateList.length).toDouble();
    stateList.add(FinishState());
    return stateList;
  }
}
