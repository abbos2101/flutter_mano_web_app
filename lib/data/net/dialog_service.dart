import 'package:flutter/material.dart';
import 'utils/service_route.dart';
import '../../data/model/response.dart';
export '../../data/model/response.dart';

class DialogService {
  Future<ResponseModel> onDialogMerged({
    @required String token,
    @required int dialogId,
  }) async {
    ResponseModel model = await routeService.request(
      isChecked: (token ?? '').isNotEmpty && (dialogId ?? 0) > 0,
      url: 'dialog/merged/$dialogId',
      method: 'GET',
      headers: {"token": token},
    );
    return model;
  }

  Future<ResponseModel> onDialogFinish(
      {@required String token,
      @required int dialogId,
      @required List<int> wordIds,
      @required List<int> sentenceIds}) async {
    ResponseModel model = await routeService.request(
      isChecked: (token ?? '').isNotEmpty && (dialogId ?? 0) > 0,
      url: '/client-dialog/$dialogId',
      method: 'POST',
      headers: {"token": token},
      data: '{ "word" : "$wordIds", "sentence" : "$sentenceIds"}',
    );
    return model;
  }
}
