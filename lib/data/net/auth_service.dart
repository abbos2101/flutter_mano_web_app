import 'package:flutter/material.dart';
import 'utils/service_route.dart';
import '../../data/model/response.dart';
export '../../data/model/response.dart';

mixin AuthServiceImp {
  Future<void> saveToken(String token);
}

class AuthService {
  Future<ResponseModel> onLogin({
    @required String username,
    @required String password,
    @required AuthServiceImp imp,
  }) async {
    ResponseModel model = await routeService.request(
      isChecked: (username ?? '').isNotEmpty && (password ?? '').isNotEmpty,
      url: 'auth/login',
      method: 'POST',
      data: '{"username":"$username","password":"$password"}',
    );
    if (model.success == true) await imp.saveToken(model.object);
    return model;
  }

  Future<ResponseModel> onSignUp({
    @required String firstname,
    @required String lastname,
    @required String username,
    @required String password,
    @required String confirmPassword,
    @required AuthServiceImp imp,
  }) async {
    ResponseModel model = await routeService.request(
      url: 'auth/signup',
      method: 'POST',
      isChecked: (firstname ?? '').isNotEmpty &&
          (lastname ?? '').isNotEmpty &&
          (username ?? '').isNotEmpty &&
          (password ?? '').isNotEmpty &&
          (confirmPassword ?? '').isNotEmpty,
      data: '{"firstname":"$firstname",'
          '"lastname":"$lastname",'
          '"username":"$username",'
          '"password":"$password",'
          '"confirmPassword":"$confirmPassword"}',
    );
    if (model.success == true) await imp.saveToken(model.object);
    return model;
  }

  Future<ResponseModel> onAboutMe({@required String token}) async =>
      await routeService.request(
        url: 'user/me',
        method: 'GET',
        headers: {"token": token},
      );
}
