import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_resume_app/data/hive/hive.dart';
import 'package:flutter_resume_app/data/model/faq/faq_model.dart';
import 'package:flutter_resume_app/data/net/faq_service.dart';
import 'package:flutter_resume_app/di/locator.dart';

import '../model.dart';

part 'faq_event.dart';

part 'faq_state.dart';

class FaqBloc extends Bloc<FaqEvent, FaqState> {
  final BuildContext context;
  final int itemId;
  final FaqType faqType;

  final HiveDB _hiveDB = locator.get<HiveDB>();
  final FAQService _faqService = locator.get<FAQService>();

  FaqBloc(this.context, this.itemId, this.faqType)
      : super(LoadingState(faqList: [], loading: true));

  String token = "";
  List<FaqModel> _faqList = [];

  @override
  Stream<FaqState> mapEventToState(FaqEvent event) async* {
    if (event is LaunchEvent)
      yield* _eventLaunch(event);
    else if (event is SendEvent) yield* _eventSend(event);
  }

  Stream<FaqState> _eventLaunch(LaunchEvent event) async* {
    try {
      token = await _hiveDB.getToken();
      ResponseModel model;
      if (faqType == FaqType.WORD)
        model = await _faqService.onGetWord(
          token: token,
          itemId: itemId,
        );
      else if (faqType == FaqType.RULE)
        model = await _faqService.onGetRule(
          token: token,
          itemId: itemId,
        );
      else if (faqType == FaqType.EXERCISE_CHECK)
        model = await _faqService.onGetExerciseCheck(
          token: token,
          itemId: itemId,
        );
      else if (faqType == FaqType.EXERCISE_PICTURE)
        model = await _faqService.onGetExercisePicture(
          token: token,
          itemId: itemId,
        );
      else if (faqType == FaqType.EXERCISE_SENTENCE)
        model = await _faqService.onGetExerciseSentence(
          token: token,
          itemId: itemId,
        );
      else if (faqType == FaqType.EXERCISE_PUTWORD)
        model = await _faqService.onGetExercisePutWord(
          token: token,
          itemId: itemId,
        );
      else if (faqType == FaqType.DIALOG_WORD)
        model = await _faqService.onGetDialogWord(
          token: token,
          itemId: itemId,
        );
      else if (faqType == FaqType.DIALOG_SENTENCE)
        model = await _faqService.onGetDialogSentence(
          token: token,
          itemId: itemId,
        );

      ResponseModel.onException(model, "FAQda xatolik");
      _faqList =
          (model.object as List).map((e) => FaqModel.fromJson(e)).toList();
      yield SuccessState(faqList: _faqList);
    } catch (e) {
      yield FailState(message: "$e");
    }
  }

  Stream<FaqState> _eventSend(SendEvent event) async* {
    yield LoadingState(faqList: _faqList);
    try {
      ResponseModel model;
      if (faqType == FaqType.WORD)
        model = await _faqService.onSaveWord(
          token: token,
          itemId: itemId,
          question: event.question,
        );
      else if (faqType == FaqType.RULE)
        model = await _faqService.onSaveRule(
          token: token,
          itemId: itemId,
          question: event.question,
        );
      else if (faqType == FaqType.EXERCISE_CHECK)
        model = await _faqService.onSaveExerciseCheck(
          token: token,
          itemId: itemId,
          question: event.question,
        );
      else if (faqType == FaqType.EXERCISE_PICTURE)
        model = await _faqService.onSaveExercisePicture(
          token: token,
          itemId: itemId,
          question: event.question,
        );
      else if (faqType == FaqType.EXERCISE_SENTENCE)
        model = await _faqService.onSaveExerciseSentence(
          token: token,
          itemId: itemId,
          question: event.question,
        );
      else if (faqType == FaqType.EXERCISE_PUTWORD)
        model = await _faqService.onSaveExercisePutWord(
          token: token,
          itemId: itemId,
          question: event.question,
        );
      else if (faqType == FaqType.DIALOG_WORD)
        model = await _faqService.onSaveDialogWord(
          token: token,
          itemId: itemId,
          question: event.question,
        );
      else if (faqType == FaqType.DIALOG_SENTENCE)
        model = await _faqService.onSaveDialogSentence(
          token: token,
          itemId: itemId,
          question: event.question,
        );

      ResponseModel.onException(model, "Xatolik sodir bo'ldi");
      add(LaunchEvent());
    } catch (e) {
      yield FailState(message: "$e");
    }
  }
}
