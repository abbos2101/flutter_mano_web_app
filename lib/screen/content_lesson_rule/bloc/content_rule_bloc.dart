import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_resume_app/data/hive/hive.dart';
import 'package:flutter_resume_app/data/model/lesson/rule_section_model.dart';
import 'package:flutter_resume_app/data/net/audio_service.dart';
import 'package:flutter_resume_app/data/net/lesson_service.dart';
import 'package:flutter_resume_app/di/locator.dart';
import 'package:flutter_resume_app/screen/content_faq/faq_screen.dart';
import 'package:flutter_resume_app/screen/content_faq/model.dart';

part 'content_rule_event.dart';

part 'content_rule_state.dart';

part 'mixin.dart';

class ContentRuleBloc extends Bloc<ContentRuleEvent, ContentRuleState>
    with ContentRuleBlocWith {
  final HiveDB _hiveDB = locator.get<HiveDB>();
  final LessonService _lessonService = locator.get<LessonService>();
  final AudioService _audioService = locator.get<AudioService>();

  final BuildContext context;
  final int lessonId;

  ContentRuleBloc({@required this.context, @required this.lessonId})
      : super(LoadingState());

  final String _TYPE_EXAMPLE = 'EXAMPLE';
  final String _TYPE_SENTENCE = 'SENTENCE';
  List<ContentRuleState> _stateList = [];
  List<int> _ruleIdList = [];

  int _index = 0;

  @override
  Stream<ContentRuleState> mapEventToState(ContentRuleEvent event) async* {
    if (event is LoadRuleEvent)
      yield* _eventLoadRule(event);
    else if (event is NextPageEvent)
      yield* _eventNextPage(event);
    else if (event is PreviousEvent)
      yield* _eventPrevious(event);
    else if (event is AudioPlayEvent)
      _audioService.onPlayAudio(name: event.soundName);
    else if (event is FinishEvent) {
      yield LoadingState();
      await _lessonService.onRuleClientSave(
        token: await _hiveDB.getToken(),
        lessonId: lessonId,
        rules: privateGetUniqueList(_ruleIdList),
      );
      Navigator.pop(context, true);
    } else if (event is FaqScreenEvent)
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FAQScreen.screen(
            itemId: event.itemId,
            faqType: FaqType.RULE,
          ),
        ),
      );
  }

  Stream<ContentRuleState> _eventLoadRule(LoadRuleEvent event) async* {
    yield LoadingState();
    try {
      final ResponseModel model = await _lessonService.onRuleSection(
        token: await _hiveDB.getToken(),
        lessonId: lessonId,
      );
      ResponseModel.onException(model, "Internet bilan bog'liq xatolik");
      final List<RuleSectionModel> ruleList = (model.object as List)
          .map((e) => RuleSectionModel.fromJson(e))
          .toList();
      _stateList = privateGetStateList(
        ruleList: ruleList,
        TYPE_EXAMPLE: _TYPE_EXAMPLE,
        TYPE_SENTENCE: _TYPE_SENTENCE,
      );
      yield _stateList[_index];
    } catch (e) {
      yield FailState(message: '$e');
    }
  }

  Stream<ContentRuleState> _eventNextPage(NextPageEvent event) async* {
    final int DELAY_TIME = 30;
    if (event.answer == true) _ruleIdList.add(event.ruleId);
    yield LoadingState();
    await Future.delayed(Duration(milliseconds: DELAY_TIME));
    yield _stateList[++_index];
  }

  Stream<ContentRuleState> _eventPrevious(PreviousEvent event) async* {
    if (_index == 0) return;
    final int DELAY_TIME = 30;
    yield LoadingState();
    await Future.delayed(Duration(milliseconds: DELAY_TIME));
    yield _stateList[--_index];
  }
}
