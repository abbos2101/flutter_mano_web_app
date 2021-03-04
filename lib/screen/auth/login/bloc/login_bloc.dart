import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume_app/data/hive/hive.dart';
import 'package:flutter_resume_app/data/net/auth_service.dart';
import 'package:flutter_resume_app/di/locator.dart';
import 'package:flutter_resume_app/screen/main/main_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttertoast/fluttertoast_web.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> implements AuthServiceImp {
  final BuildContext context;

  final AuthService _authService = locator.get<AuthService>();
  final HiveDB _hiveDB = locator.get<HiveDB>();

  LoginBloc(this.context) : super(InitialState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is SignEvent)
      yield* _eventSign(event);
    else if (event is SignupLaunchEvent) yield* _eventSignupLaunch(event);
  }

  Stream<LoginState> _eventSign(SignEvent event) async* {
    yield LoadingState();
    try {
      ResponseModel model = await _authService.onLogin(
        username: event.username,
        password: event.password,
        imp: this,
      );
      ResponseModel.onException(model, "onLogin");
      if (model.success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => MainScreen.screen()),
        );
        return;
      } else {
        Fluttertoast.showToast(
          msg: "Login yoki parolda xatolik",
          webPosition: "center",
          timeInSecForIosWeb: 3,
        );
        return;
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "$e",
        webPosition: "center",
        timeInSecForIosWeb: 3,
      );
      yield FailState(message: "$e");
    }
  }

  Stream<LoginState> _eventSignupLaunch(SignupLaunchEvent event) async* {
    Fluttertoast.showToast(
      msg: "Bu qism hali tayyor emas",
      webPosition: "center",
      timeInSecForIosWeb: 3,
    );
  }

  @override
  Future<void> saveToken(String token) async => await _hiveDB.saveToken(token);
}
