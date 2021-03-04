import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume_app/data/hive/hive.dart';
import 'package:flutter_resume_app/data/model/lesson/word_section_model.dart';
import 'package:flutter_resume_app/data/net/audio_service.dart';
import 'package:flutter_resume_app/data/net/lesson_service.dart';
import 'package:flutter_resume_app/di/locator.dart';
import 'package:flutter_resume_app/screen/auth/login/login_screen.dart';
import 'content_word_model.dart';

part 'content_word_event.dart';

part 'content_word_state.dart';

class ContentWordBloc extends Bloc<ContentWordEvent, ContentWordState> {
  final BuildContext context;
  final lessonId;

  final LessonService _lessonService = locator.get<LessonService>();
  final AudioService _audioService = locator.get<AudioService>();
  final HiveDB _hiveDB = locator.get<HiveDB>();

  ContentWordBloc(this.context, this.lessonId) : super(LoadingState());
  String _token = "";
  List<WordSectionModel> _wordList;
  List<ContentWordModel> _contentWordList = [];
  int _current = 0;

  @override
  Stream<ContentWordState> mapEventToState(ContentWordEvent event) async* {
    if (event is LaunchEvent)
      yield* _eventLaunch(event);
    else if (event is BackEvent)
      yield* _eventBack(event);
    else if (event is WordPressedEvent)
      yield* _eventWordPressed(event);
    else if (event is NextQuestionEvent)
      yield* _eventNextQuestion(event);
    else if (event is AudioPlayEvent)
      yield* _eventAudioPlay(event);
    else if (event is FinishCheckEvent)
      yield* _eventFinishCheck(event);
    else if (event is FinishAddEvent) yield* _eventFinishAdd(event);
  }

  Stream<ContentWordState> _eventLaunch(LaunchEvent event) async* {
    yield LoadingState();
    ResponseModel model;
    _token = await _hiveDB.getToken();
    try {
      _contentWordList.clear();
      model = await _lessonService.onWordSection(
        token: _token,
        lesson: lessonId,
      );
      ResponseModel.onException(model, "onWordSection");
      _wordList = (model.object as List)
          .map((e) => WordSectionModel.fromJson(e))
          .toList();
      for (int i = 0; i < _wordList.length; i++) {
        final int rand = Random().nextInt(2);
        if (_wordList[i].correctWord != null &&
            _wordList[i].incorrectWord != null)
          _contentWordList.add(ContentWordModel(
            wordId: _wordList[i].id,
            question: _wordList[i].correctWord.uz,
            trueAnswer: _wordList[i].correctWord.ru,
            firstAnswer: rand == 0
                ? _wordList[i].incorrectWord.ru
                : _wordList[i].correctWord.ru,
            secondAnswer: rand != 0
                ? _wordList[i].incorrectWord.ru
                : _wordList[i].correctWord.ru,
            example: _wordList[i].correctWord.example,
            soundName: _wordList[i].correctWord.soundName,
            imageName: _wordList[i].correctWord.imageName,
            check: null,
          ));
      }
      yield TestState(
        wordId: _contentWordList[_current].wordId,
        question: _contentWordList[_current].question,
        trueAnswer: _contentWordList[_current].trueAnswer,
        firstAnswer: _contentWordList[_current].firstAnswer,
        secondAnswer: _contentWordList[_current].secondAnswer,
        imageName: _contentWordList[_current].imageName,
        progress: _current / _contentWordList.length,
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

  Stream<ContentWordState> _eventBack(BackEvent event) async* {
    if (_current > 0) {
      _current--;
      final ContentWordModel model = _contentWordList[_current];
      yield CheckState(
        wordId: model.wordId,
        question: model.question,
        answer: model.trueAnswer,
        example: model.example,
        progress: (_current + 1) / _contentWordList.length,
        imageName: model.imageName,
        soundName: model.soundName,
        check: model.check,
      );
    }
  }

  Stream<ContentWordState> _eventWordPressed(WordPressedEvent event) async* {
    ContentWordModel model = _contentWordList[_current];
    model = model.copyWith(check: model.trueAnswer == event.word);
    _contentWordList[_current] = model;
    yield CheckState(
      wordId: model.wordId,
      question: model.question,
      answer: model.trueAnswer,
      example: model.example,
      progress: (_current + 1) / _contentWordList.length,
      imageName: model.imageName,
      soundName: model.soundName,
      check: model.check,
    );
  }

  Stream<ContentWordState> _eventNextQuestion(NextQuestionEvent event) async* {
    _current++;
    if (_current == _contentWordList.length) {
      int count = 0;
      _contentWordList.forEach((it) => it.check != true ? count++ : count);
      yield FinishState(list: _contentWordList, count: count);
      return;
    }
    final ContentWordModel model = _contentWordList[_current];
    if (model.check == null)
      yield TestState(
        wordId: model.wordId,
        question: model.question,
        trueAnswer: model.trueAnswer,
        firstAnswer: model.firstAnswer,
        secondAnswer: model.secondAnswer,
        imageName: model.imageName,
        progress: _current / _contentWordList.length,
      );
    else
      yield CheckState(
        wordId: model.wordId,
        question: model.question,
        answer: model.trueAnswer,
        example: model.example,
        progress: (_current + 1) / _contentWordList.length,
        imageName: model.imageName,
        soundName: model.soundName,
        check: model.check,
      );
  }

  Stream<ContentWordState> _eventAudioPlay(AudioPlayEvent event) async* {
    _audioService.onPlayAudio(name: event.soundName);
  }

  Stream<ContentWordState> _eventFinishCheck(FinishCheckEvent event) async* {
    ContentWordModel model = _contentWordList[event.index];
    model = model.copyWith(check: !(model.check ?? false));
    _contentWordList[event.index] = model;
    int count = 0;
    _contentWordList.forEach((it) => it.check != true ? count++ : null);
    yield FinishState(
      list: _contentWordList,
      rand: Random().nextInt(100),
      count: count,
    );
  }

  Stream<ContentWordState> _eventFinishAdd(FinishAddEvent event) async* {
    final List<int> wordsId = [];
    _contentWordList.forEach((it) => !it.check ? wordsId.add(it.wordId) : null);
    try {
      yield LoadingState();
      ResponseModel model = await _lessonService.onWordClientSave(
        token: _token,
        lessonId: lessonId,
        wordsId: wordsId,
      );
      ResponseModel.onException(model, "onWordClientSave");
      Navigator.pop(context, true);
    } catch (e) {
      yield FailState(message: "$e");
      await Future.delayed(Duration(seconds: 2));
      Navigator.pop(context, true);
    }
  }
}
