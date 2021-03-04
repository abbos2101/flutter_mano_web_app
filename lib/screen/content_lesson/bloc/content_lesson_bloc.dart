import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume_app/data/hive/hive.dart';
import 'package:flutter_resume_app/data/model/lesson/lesson_access_model.dart';
import 'package:flutter_resume_app/data/net/lesson_service.dart';
import 'package:flutter_resume_app/di/locator.dart';
import 'package:flutter_resume_app/screen/content_lesson_exercise/exercise_screen.dart';
import 'package:flutter_resume_app/screen/content_lesson_rule/rule_screen.dart';
import 'package:flutter_resume_app/screen/content_lesson_word/word_screen.dart';

part 'content_lesson_event.dart';

part 'content_lesson_state.dart';

class ContentLessonBloc extends Bloc<ContentLessonEvent, ContentLessonState> {
  final BuildContext context;
  final int lessonId;
  final String lessonIdString;
  final LessonAccessModel lessonAccessModel;

  final LessonService _lessonService = locator.get<LessonService>();
  final HiveDB _hiveDB = locator.get<HiveDB>();

  ContentLessonBloc(
    this.context, {
    this.lessonId,
    this.lessonIdString,
    this.lessonAccessModel,
  }) : super(LoadingState());

  LessonAccessModel _accessModel;

  @override
  Stream<ContentLessonState> mapEventToState(ContentLessonEvent event) async* {
    if (event is LaunchEvent)
      yield* _eventLaunch(event);
    else if (event is PushWordEvent ||
        event is PushRuleEvent ||
        event is PushExerciseEvent) yield* _eventPush(event);
  }

  Stream<ContentLessonState> _eventLaunch(LaunchEvent event) async* {
    if (_accessModel == null) {
      yield LoadingState();
      try {
        ResponseModel model = await _lessonService.onLessonAccess(
          token: await _hiveDB.getToken(),
          lesson: lessonId,
        );
        ResponseModel.onException(model, "Xatolik sodir bo'ldi");
        _accessModel = LessonAccessModel.fromJson(model.object);
        yield SuccessState(
          indexLessonName: lessonIdString,
          lessonName: _accessModel.lessonName,
          blocName: _accessModel.blockName,
          word: _accessModel.words,
          rule: _accessModel.rules,
          exercise: _accessModel.exercises,
        );
      } catch (e) {
        yield FailState(message: "$e");
      }
    } else
      yield SuccessState(
        indexLessonName: lessonIdString,
        lessonName: _accessModel.lessonName,
        blocName: _accessModel.blockName,
        word: _accessModel.words,
        rule: _accessModel.rules,
        exercise: _accessModel.exercises,
      );
  }

  Stream<ContentLessonState> _eventPush(ContentLessonEvent event) async* {
    var isFinished;
    if (event is PushWordEvent)
      isFinished = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ContentWordScreen.screen(lessonId: lessonId),
        ),
      );
    else if (event is PushRuleEvent)
      isFinished = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ContentRuleScreen.screen(lessonId: lessonId),
        ),
      );
    else if (event is PushExerciseEvent)
      isFinished = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ContentExerciseScreen.screen(lessonId: lessonId),
        ),
      );
    if (isFinished != null) {
      _accessModel = null;
      add(LaunchEvent());
    }
  }
}
