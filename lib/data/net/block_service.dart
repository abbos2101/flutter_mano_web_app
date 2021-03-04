import 'package:flutter/material.dart';
import 'utils/service_route.dart';
import '../../data/model/response.dart';
export '../../data/model/response.dart';

class BlockService {
  Future<ResponseModel> onBlockAll({
    @required String token,
    @required int levelId,
  }) async {
    ResponseModel model = await routeService.request(
      isChecked: (token ?? '').isNotEmpty && (levelId ?? 0) > 0,
      url: 'block/$levelId',
      method: 'GET',
      headers: {"token": token},
    );
    return model;
  }

  Future<ResponseModel> onBlockOne({
    @required String token,
    @required int blockId,
  }) async {
    ResponseModel model = await routeService.request(
      isChecked: (token ?? '').isNotEmpty && (blockId ?? 0) > 0,
      url: 'block/one/$blockId',
      method: 'GET',
      headers: {"token": token},
    );
    return model;
  }

  Future<ResponseModel> onBlockAccess({
    @required String token,
    @required int blockId,
  }) async {
    ResponseModel model = await routeService.request(
      isChecked: (token ?? '').isNotEmpty && (blockId ?? 0) > 0,
      url: 'block/access/$blockId',
      method: 'GET',
      headers: {"token": token},
    );
    return model;
  }
}
