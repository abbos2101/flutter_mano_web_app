import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume_app/screen/content_lesson/lesson_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_resume_app/data/hive/hive.dart';
import 'package:flutter_resume_app/data/model/auth/me_model.dart';
import 'package:flutter_resume_app/data/model/bloc/bloc_access.dart';
import 'package:flutter_resume_app/data/model/bloc/bloc_one_model.dart';
import 'package:flutter_resume_app/data/model/bloc/block_all.dart';
import 'package:flutter_resume_app/data/model/lesson/lesson_access_model.dart';
import 'package:flutter_resume_app/data/model/lesson/lesson_section_model.dart';
import 'package:flutter_resume_app/data/model/welcome/level_all_model.dart';
import 'package:flutter_resume_app/data/net/auth_service.dart';
import 'package:flutter_resume_app/data/net/block_service.dart';
import 'package:flutter_resume_app/data/net/lesson_service.dart';
import 'package:flutter_resume_app/data/net/welcome_service.dart';
import 'package:flutter_resume_app/di/locator.dart';
import 'package:flutter_resume_app/screen/auth/login/login_screen.dart';
import 'page_model.dart';

part 'lesson_event.dart';

part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final BuildContext context;

  final AuthService _authService = locator.get<AuthService>();
  final BlockService _blockService = locator.get<BlockService>();
  final LessonService _lessonService = locator.get<LessonService>();
  final HiveDB _hiveDB = locator.get<HiveDB>();

  LessonBloc(this.context) : super(LoadingState());

  String _token;
  MeModel _meModel;
  BlockAccessModel _blockAccessModel;
  List<BlockAllModel> _blockAllList = [];
  List<LessonSectionModel> _lessonList = [];
  int _progress = 0;
  List<PageModel> _pageList = [];
  int _last = -1;
  int _current = -1;

  @override
  Stream<LessonState> mapEventToState(LessonEvent event) async* {
    if (event is LaunchEvent)
      yield* _eventLaunch(event);
    else if (event is LogoutEvent)
      yield* _eventLogout(event);
    else if (event is PageChangeEvent)
      yield* _eventPageChange(event);
    else if (event is PageItemPressedEvent) yield* _eventItemPressed(event);
  }

  Stream<LessonState> _eventLaunch(LaunchEvent event) async* {
    yield LoadingState();
    _pageList.clear();
    ResponseModel model;
    _token = await _hiveDB.getToken();
    if (_token.isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen.screen()),
      );
      return;
    }
    try {
      model = await _authService.onAboutMe(token: _token);
      ResponseModel.onException(model, "onAboutMe");
      _meModel = MeModel.fromJson(model.object);

      model = await _blockService.onBlockAccess(
        token: _token,
        blockId: _meModel.block,
      );
      ResponseModel.onException(model, "onBlockAccess");
      _blockAccessModel = BlockAccessModel.fromJson(model.object);

      model = await _blockService.onBlockAll(
        token: _token,
        levelId: _meModel.level,
      );
      ResponseModel.onException(model, "onBlockAll");
      _blockAllList =
          (model.object as List).map((e) => BlockAllModel.fromJson(e)).toList();

      model = await _lessonService.onLessonSection(
        token: _token,
        block: _meModel.block,
      );
      _lessonList = (model.object as List)
          .map((e) => LessonSectionModel.fromJson(e))
          .toList();
      for (int i = 0; i < _lessonList.length; i++) {
        if (_lessonList[i].type == "lesson") {
          model = await _lessonService.onLessonAccess(
            token: _token,
            lesson: _lessonList[i].id,
          );
          if (model.object != null) {
            final LessonAccessModel accessModel =
                LessonAccessModel.fromJson(model.object);
            _pageList.add(PageModel(
              id: _lessonList[i].id,
              lessonName: _lessonList[i].name,
              lessonIdString: "${i + 1}-dars",
              word: accessModel.words,
              rule: accessModel.rules,
              exercise: accessModel.exercises,
              enabled: true,
            ));
          } else
            _pageList.add(PageModel(
              id: _lessonList[i].id,
              lessonName: _lessonList[i].name,
              lessonIdString: "${i + 1}-dars",
              word: false,
              rule: false,
              exercise: false,
              enabled: false,
            ));
        } else if (_lessonList[i].type == "dialog")
          _pageList.add(PageModel(
            id: _lessonList[i].id,
            lessonName: _lessonList[i].name,
            lessonIdString: "Dialog",
            dialog: _blockAccessModel.dialogs,
            enabled: _blockAccessModel.lessons,
          ));
        else if (_lessonList[i].type == "examine")
          _pageList.add(PageModel(
            id: _lessonList[i].id,
            lessonName: _lessonList[i].name,
            lessonIdString: "Exam",
            exam: _blockAccessModel.exams,
            enabled: _blockAccessModel.dialogs,
          ));
      }
      for (int i = 1; i < _pageList.length; i++)
        if (_pageList[i - 1].enabled && !_pageList[i].enabled) {
          _last = i - 1;
          _current = _current == -1 ? i - 1 : _current;
          break;
        }
      if (_last == -1) {
        _last = _pageList.length - 1;
        _current = _pageList.length - 1;
      }

      for (int i = 0; i < _blockAllList.length; i++)
        if (_blockAllList[i].id == _blockAccessModel.blockId) {
          _progress = i * 100 ~/ _blockAllList.length;
          break;
        }

      yield SuccessState(
        levelId: _blockAccessModel.levelId,
        levelName: _blockAccessModel.levelName,
        blocName: _blockAccessModel.blockName,
        progress: _progress,
        pageList: _pageList,
        last: _last,
        current: _current,
      );
    } catch (e) {
      if (e.message == "Access denied") {
        await _hiveDB.saveToken(null);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen.screen()),
        );
        return;
      }
      yield FailState(message: "$e");
    }
  }

  Stream<LessonState> _eventLogout(LogoutEvent event) async* {
    await _hiveDB.saveToken(null);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen.screen()),
    );
  }

  Stream<LessonState> _eventPageChange(PageChangeEvent event) async* {
    _current = event.pageIndex;
    yield SuccessState(
      levelId: _blockAccessModel.levelId,
      levelName: _blockAccessModel.levelName,
      blocName: _blockAccessModel.blockName,
      progress: _progress,
      pageList: _pageList,
      last: _last,
      current: _current,
    );
  }

  Stream<LessonState> _eventItemPressed(PageItemPressedEvent event) async* {
    final PageModel pageModel = _pageList[event.pageIndex];
    if (pageModel.word != null) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ContentLessonScreen.screen(
            lessonId: pageModel.id,
            lessonIdString: pageModel.lessonIdString,
          ),
        ),
      );
    } else if (pageModel.dialog != null) {
      Fluttertoast.showToast(msg: "Tez kunda!");
      // await Navigator.push(
      //   context,
      //   ContentDialogScreen.route(dialogId: pageModel.id),
      // );
    } else
      Fluttertoast.showToast(msg: "Tez kunda!");
    add(LaunchEvent());
  }
}
