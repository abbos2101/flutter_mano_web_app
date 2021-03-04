import 'package:flutter/material.dart';
import 'utils/service_route.dart';
import '../../data/model/response.dart';
export '../../data/model/response.dart';

class FAQService {
  Future<ResponseModel> onGetWord({
    @required String token,
    @required int itemId,
  }) async {
    ResponseModel model = await routeService.request(
      isChecked: (token ?? '').isNotEmpty && (itemId ?? 0) > 0,
      url: 'faq/ask/word/$itemId',
      method: 'GET',
      headers: {"token": token},
    );
    return model;
  }

  Future<ResponseModel> onSaveWord({
    @required String token,
    @required int itemId,
    @required String question,
  }) async {
    ResponseModel model = await routeService.request(
      isChecked: (token ?? '').isNotEmpty && (itemId ?? 0) > 0,
      url: 'faq/ask/word',
      method: 'POST',
      headers: {"token": token},
      data: '{ "itemId" : $itemId, "question" : "$question"}',
    );
    return model;
  }

  Future<ResponseModel> onGetRule({
    @required String token,
    @required int itemId,
  }) async {
    ResponseModel model = await routeService.request(
      isChecked: (token ?? '').isNotEmpty && (itemId ?? 0) > 0,
      url: 'faq/ask/rule/$itemId',
      method: 'GET',
      headers: {"token": token},
    );
    return model;
  }

  Future<ResponseModel> onSaveRule({
    @required String token,
    @required int itemId,
    @required String question,
  }) async {
    ResponseModel model = await routeService.request(
      isChecked: (token ?? '').isNotEmpty && (itemId ?? 0) > 0,
      url: 'faq/ask/rule',
      method: 'POST',
      headers: {"token": token},
      data: '{ "itemId" : $itemId, "question" : "$question"}',
    );
    return model;
  }

  Future<ResponseModel> onGetExerciseCheck({
    @required String token,
    @required int itemId,
  }) async {
    ResponseModel model = await routeService.request(
      isChecked: (token ?? '').isNotEmpty && (itemId ?? 0) > 0,
      url: 'faq/ask/exercise-check/$itemId',
      method: 'GET',
      headers: {"token": token},
    );
    return model;
  }

  Future<ResponseModel> onSaveExerciseCheck({
    @required String token,
    @required int itemId,
    @required String question,
  }) async {
    ResponseModel model = await routeService.request(
      isChecked: (token ?? '').isNotEmpty && (itemId ?? 0) > 0,
      url: 'faq/ask/exercise-check',
      method: 'POST',
      headers: {"token": token},
      data: '{ "itemId" : $itemId, "question" : "$question"}',
    );
    return model;
  }

  Future<ResponseModel> onGetExercisePicture({
    @required String token,
    @required int itemId,
  }) async {
    ResponseModel model = await routeService.request(
      isChecked: (token ?? '').isNotEmpty && (itemId ?? 0) > 0,
      url: 'faq/ask/exercise-picture/$itemId',
      method: 'GET',
      headers: {"token": token},
    );
    return model;
  }

  Future<ResponseModel> onSaveExercisePicture({
    @required String token,
    @required int itemId,
    @required String question,
  }) async {
    ResponseModel model = await routeService.request(
      isChecked: (token ?? '').isNotEmpty && (itemId ?? 0) > 0,
      url: 'faq/ask/exercise-picture',
      method: 'POST',
      headers: {"token": token},
      data: '{ "itemId" : $itemId, "question" : "$question"}',
    );
    return model;
  }

  Future<ResponseModel> onGetExerciseSentence({
    @required String token,
    @required int itemId,
  }) async {
    ResponseModel model = await routeService.request(
      isChecked: (token ?? '').isNotEmpty && (itemId ?? 0) > 0,
      url: 'faq/ask/exercise-sentence/$itemId',
      method: 'GET',
      headers: {"token": token},
    );
    return model;
  }

  Future<ResponseModel> onSaveExerciseSentence({
    @required String token,
    @required int itemId,
    @required String question,
  }) async {
    ResponseModel model = await routeService.request(
      isChecked: (token ?? '').isNotEmpty && (itemId ?? 0) > 0,
      url: 'faq/ask/exercise-sentence',
      method: 'POST',
      headers: {"token": token},
      data: '{ "itemId" : $itemId, "question" : "$question"}',
    );
    return model;
  }

  Future<ResponseModel> onGetExercisePutWord({
    @required String token,
    @required int itemId,
  }) async {
    ResponseModel model = await routeService.request(
      isChecked: (token ?? '').isNotEmpty && (itemId ?? 0) > 0,
      url: 'faq/ask/exercise-put-word/$itemId',
      method: 'GET',
      headers: {"token": token},
    );
    return model;
  }

  Future<ResponseModel> onSaveExercisePutWord({
    @required String token,
    @required int itemId,
    @required String question,
  }) async {
    ResponseModel model = await routeService.request(
      isChecked: (token ?? '').isNotEmpty && (itemId ?? 0) > 0,
      url: 'faq/ask/exercise-put-word',
      method: 'POST',
      headers: {"token": token},
      data: '{ "itemId" : $itemId, "question" : "$question"}',
    );
    return model;
  }

  Future<ResponseModel> onGetDialogSentence({
    @required String token,
    @required int itemId,
  }) async {
    ResponseModel model = await routeService.request(
      isChecked: (token ?? '').isNotEmpty && (itemId ?? 0) > 0,
      url: 'faq/ask/dialog-sentence/$itemId',
      method: 'GET',
      headers: {"token": token},
    );
    return model;
  }

  Future<ResponseModel> onSaveDialogSentence({
    @required String token,
    @required int itemId,
    @required String question,
  }) async {
    ResponseModel model = await routeService.request(
      isChecked: (token ?? '').isNotEmpty && (itemId ?? 0) > 0,
      url: 'faq/ask/dialog-sentence',
      method: 'POST',
      headers: {"token": token},
      data: '{ "itemId" : $itemId, "question" : "$question"}',
    );
    return model;
  }

  Future<ResponseModel> onGetDialogWord({
    @required String token,
    @required int itemId,
  }) async {
    ResponseModel model = await routeService.request(
      isChecked: (token ?? '').isNotEmpty && (itemId ?? 0) > 0,
      url: 'faq/ask/dialog-word/$itemId',
      method: 'GET',
      headers: {"token": token},
    );
    return model;
  }

  Future<ResponseModel> onSaveDialogWord({
    @required String token,
    @required int itemId,
    @required String question,
  }) async {
    ResponseModel model = await routeService.request(
      isChecked: (token ?? '').isNotEmpty && (itemId ?? 0) > 0,
      url: 'faq/ask/dialog-word',
      method: 'POST',
      headers: {"token": token},
      data: '{ "itemId" : $itemId, "question" : "$question"}',
    );
    return model;
  }
}
