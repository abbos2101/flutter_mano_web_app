import 'package:flutter/material.dart';
import 'service_route.dart';
import '../../model/response.dart';

mixin LessonWordServiceImp {
  Future<ResponseModel> onWordClient({@required String token}) async =>
      await routeService.request(
        url: 'client-word',
        method: 'GET',
        headers: {"token": token},
      );

  Future<ResponseModel> onWordClientSave({
    @required String token,
    @required int lessonId,
    @required List<int> wordsId,
  }) async =>
      await routeService.request(
        url: 'client-word/$lessonId',
        method: 'POST',
        data: '{"words":$wordsId}',
        headers: {"token": token},
      );

  Future<ResponseModel> onWordSection({
    @required String token,
    @required int lesson,
  }) async =>
      await routeService.request(
        url: 'wordSection/lesson/$lesson',
        method: 'GET',
        headers: {"token": token},
      );
}
