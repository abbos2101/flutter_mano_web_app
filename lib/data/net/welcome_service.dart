import 'package:flutter/material.dart';
import 'utils/service_route.dart';
import '../../data/model/response.dart';
export '../../data/model/response.dart';

class WelcomeService {
  Future<ResponseModel> onSlogan() async =>
      await routeService.request(url: 'slogan/random', method: 'GET');

  Future<ResponseModel> onLevelAll({@required String token}) async =>
      await routeService.request(
        url: 'level',
        method: 'GET',
        headers: {"token": token},
      );

  Future<ResponseModel> onSetLevel({
    @required String token,
    @required int level,
  }) async =>
      await routeService.request(
        url: 'user/force-set-level',
        method: 'POST',
        data: '{"level":$level}',
        headers: {"token": token},
      );

  Future<ResponseModel> onEntryQuestions({
    @required String token,
    @required int level,
  }) async =>
      await routeService.request(
        isChecked: (token ?? '').isNotEmpty && (level ?? 0) > 0,
        url: 'entry-question/level/$level',
        method: 'GET',
        headers: {"token": token},
      );
}
