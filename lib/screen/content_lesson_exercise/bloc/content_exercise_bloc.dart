import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_resume_app/data/hive/hive.dart';
import 'package:flutter_resume_app/data/model/lesson/exercise_section_model.dart';
import 'package:flutter_resume_app/data/net/lesson_service.dart';
import 'package:flutter_resume_app/di/locator.dart';

part 'content_exercise_event.dart';

part 'content_exercise_state.dart';

part 'mixin.dart';

class ContentExerciseBloc
    extends Bloc<ContentExerciseEvent, ContentExerciseState>
    with ContentExerciseWith {
  final HiveDB _hiveDB = locator.get<HiveDB>();
  final LessonService _lessonService = locator.get<LessonService>();

  final BuildContext context;
  final int lessonId;

  ContentExerciseBloc({@required this.context, @required this.lessonId})
      : super(LoadingState());

  List<ContentExerciseState> _stateList = [];
  List<int> _exerciseCheckIdList = [];
  List<int> _exercisePictureIdList = [];
  List<int> _exerciseSentenceIdList = [];
  List<int> _exercisePutWordIdList = [];
  int _index = 0;

  @override
  Stream<ContentExerciseState> mapEventToState(
    ContentExerciseEvent event,
  ) async* {
    if (event is LoadExerciseEvent)
      yield* _eventLoadExercise(event);
    else if (event is NextPageEvent)
      yield* _eventNextPage(event);
    else if (event is PreviousEvent)
      yield* _eventPrevious(event);
    else if (event is FinishEvent) {
      yield LoadingState();
      await _lessonService.onExerciseClientSave(
        token: await _hiveDB.getToken(),
        lessonId: lessonId,
        exerciseChecks: _exerciseCheckIdList,
        exercisePictures: _exercisePictureIdList,
        exercisePutWords: _exercisePutWordIdList,
        exerciseSentences: _exercisePutWordIdList,
      );
      Navigator.pop(this.context, true);
    }
  }

  Stream<ContentExerciseState> _eventLoadExercise(
    LoadExerciseEvent event,
  ) async* {
    yield LoadingState();
    try {
      final ResponseModel model = await _lessonService.onExerciseSection(
        token: await _hiveDB.getToken(),
        lessonId: lessonId,
      );
      ResponseModel.onException(model, "Xatolik sodir bo'ldi");
      final ExerciseSectionModel exercise = ExerciseSectionModel.fromJson(
        model.object,
      );
      _stateList = privateGetStateList(exerciseSectionModel: exercise);
      yield _stateList[_index];
    } catch (e) {
      yield FailState(message: "$e");
    }
  }

  Stream<ContentExerciseState> _eventNextPage(NextPageEvent event) async* {
    final int DELAY_TIME = 30;
    if (event.answer) {
      if (event.exerciseCheckId != null)
        _exerciseCheckIdList.add(event.exerciseCheckId);
      if (event.exercisePictureId != null)
        _exercisePictureIdList.add(event.exercisePictureId);
      if (event.exerciseSentenceId != null)
        _exerciseSentenceIdList.add(event.exerciseSentenceId);
      if (event.exercisePutWordId != null)
        _exercisePutWordIdList.add(event.exercisePutWordId);
    }
    yield LoadingState();
    await Future.delayed(Duration(milliseconds: DELAY_TIME));
    yield _stateList[++_index];
  }

  Stream<ContentExerciseState> _eventPrevious(PreviousEvent event) async* {
    if (_index == 0) return;
    final int DELAY_TIME = 30;
    yield LoadingState();
    await Future.delayed(Duration(milliseconds: DELAY_TIME));
    yield _stateList[--_index];
  }
}
