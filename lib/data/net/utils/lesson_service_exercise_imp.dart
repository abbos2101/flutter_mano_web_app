import 'package:flutter/material.dart';
import 'service_route.dart';
import '../../model/response.dart';

mixin LessonExerciseImp {
  Future<ResponseModel> onExerciseSection({
    @required String token,
    @required int lessonId,
  }) async =>
      await routeService.request(
        url: 'exercise/$lessonId',
        method: 'GET',
        headers: {"token": token},
      );

  Future<ResponseModel> onExerciseClientSave({
    @required String token,
    @required int lessonId,
    @required List<int> exerciseChecks,
    @required List<int> exercisePictures,
    @required List<int> exercisePutWords,
    @required List<int> exerciseSentences,
  }) async =>
      await routeService.request(
        url: 'client-exercise/$lessonId',
        method: 'POST',
        headers: {"token": token},
        data: '{"exerciseCheck":$exerciseChecks,'
            '"exercisePicture":$exercisePictures,'
            '"exercisePutWord":$exercisePutWords,'
            '"exerciseSentence":$exerciseSentences}',
      );
}
