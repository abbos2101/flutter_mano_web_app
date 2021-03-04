import 'package:flutter/material.dart';
import 'package:flutter_resume_app/data/util/colors.dart';
import 'package:flutter_resume_app/di/locator.dart';
import 'package:flutter_resume_app/screen/auth/login/login_screen.dart';
import 'package:flutter_resume_app/screen/main/main_screen.dart';
import 'package:flutter_resume_app/screen/splash/splash_screen.dart';

void main() {
  locatorSetup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ma'no Web",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: MyColors.orangeAccent,
      ),
      home: SplashScreen.screen(),
    );
  }
}
