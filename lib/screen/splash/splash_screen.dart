import 'package:flutter/material.dart';
import 'package:flutter_resume_app/data/hive/hive.dart';
import 'package:flutter_resume_app/di/locator.dart';
import 'package:flutter_resume_app/home_screen.dart';
import 'package:flutter_resume_app/screen/auth/login/login_screen.dart';
import 'package:flutter_resume_app/screen/main/main_screen.dart';

class SplashScreen extends StatefulWidget {
  static Widget screen() => HomeScreen(child: SplashScreen());

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final HiveDB hiveDB = locator.get<HiveDB>();

  @override
  void initState() {
    nextScreen();
    super.initState();
  }

  Future<void> nextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    if (await hiveDB.getToken() == null)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen.screen()),
      );
    else
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MainScreen.screen()),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        "assets/img_splash_background.png",
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
