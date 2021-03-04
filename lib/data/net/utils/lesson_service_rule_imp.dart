import 'package:flutter/material.dart';
import 'service_route.dart';
import '../../model/response.dart';

mixin LessonRuleImp {
  Future<ResponseModel> onRuleClient({@required String token}) async =>
      await routeService.request(
        url: 'client-rule',
        method: 'GET',
        headers: {"token": token},
      );

  Future<ResponseModel> onRuleClientSave({
    @required String token,
    @required int lessonId,
    @required List<int> rules,
  }) async =>
      await routeService.request(
        url: 'client-rule/$lessonId',
        method: 'POST',
        data: '{"rules":$rules}',
        headers: {"token": token},
      );

  Future<ResponseModel> onRuleSection({
    @required String token,
    @required int lessonId,
  }) async =>
      await routeService.request(
        url: 'ruleSection/$lessonId/merged',
        method: 'GET',
        headers: {"token": token},
      );
}
