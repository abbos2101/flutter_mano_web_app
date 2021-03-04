import 'package:flutter/material.dart';
import 'service_route.dart';
import '../../model/response.dart';

mixin LessonLessonServiceImp {
  Future<ResponseModel> onLessonClient({@required String token}) async =>
      await routeService.request(
        url: 'lesson-client',
        method: 'GET',
        headers: {"token": token},
      );

  Future<ResponseModel> onLessonSection({
    @required String token,
    @required int block,
  }) async =>
      await routeService.request(
        url: 'lesson/$block',
        method: 'GET',
        headers: {"token": token},
      );

  Future<ResponseModel> onLessonAccess({
    @required String token,
    int lesson,
  }) async =>
      await routeService.request(
        url: 'lesson/access/${lesson ?? ''}',
        method: 'GET',
        headers: {"token": token},
      );
}
