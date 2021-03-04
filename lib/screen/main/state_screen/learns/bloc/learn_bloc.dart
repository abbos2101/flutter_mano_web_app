import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_resume_app/data/hive/hive.dart';
import 'package:flutter_resume_app/data/model/lesson/rule_client_model.dart';
import 'package:flutter_resume_app/data/model/lesson/word_client_model.dart';
import 'package:flutter_resume_app/data/net/lesson_service.dart';
import 'package:flutter_resume_app/di/locator.dart';

part 'learn_event.dart';

part 'learn_state.dart';

class LearnBloc extends Bloc<LearnEvent, LearnState> {
  final BuildContext context;

  final HiveDB _hiveDB = locator.get<HiveDB>();
  final LessonService _lessonService = locator.get<LessonService>();

  LearnBloc(this.context) : super(LoadingState());
  WordClientModel _clientModel;
  final List<RuleClientModel> _ruleList = [];

  @override
  Stream<LearnState> mapEventToState(LearnEvent event) async* {
    if (event is LaunchEvent) yield* _eventLaunch(event);
  }

  Stream<LearnState> _eventLaunch(LaunchEvent event) async* {
    yield LoadingState();
    try {
      ResponseModel model;
      String token = await _hiveDB.getToken();
      model = await _lessonService.onWordClient(token: token);
      ResponseModel.onException(model, "Client Word Model");
      _clientModel = WordClientModel.fromJson(model.object);

      model = await _lessonService.onRuleClient(token: token);
      _ruleList.addAll(
        (model.object as List).map((e) => RuleClientModel.fromJson(e)).toList(),
      );
      yield ResultState(wordClientModel: _clientModel, ruleList: _ruleList);
    } catch (e) {
      yield FailState(message: "$e");
    }
  }
}
