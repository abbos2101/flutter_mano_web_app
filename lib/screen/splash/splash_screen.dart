import 'package:dio/dio.dart';
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
  final String token = "45425426-1363-4ee3-9056-7716b5d91583";
  bool isLoading = false;
  String slogan = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            child: Text("FAKE"),
            //flutter build web --release --web-renderer html
            onPressed: () async {
              setState(() => isLoading = true);
              try {
                Response response = await Dio().get(
                  "https://jsonplaceholder.typicode.com/users",
                );
                slogan = "${response.data}";
                setState(() => isLoading = false);
              } catch (e) {
                slogan = "$e";
                setState(() => isLoading = false);
              }
            },
          ),
          SizedBox(width: 30),
          FloatingActionButton(
            child: Text("GET"),
            //flutter build web --release --web-renderer html
            onPressed: () async {
              setState(() => isLoading = true);
              try {
                Response response = await Dio().get(
                  "http://185.16.40.113:8080/api/slogan/random",
                  options: Options(
                    headers: {
                      "Content-Type": "application/json",
                      "token": "45425426-1363-4ee3-9056-7716b5d91583",
                    },
                  ),
                );
                slogan = "${response.data}";
                setState(() => isLoading = false);
              } catch (e) {
                slogan = "$e";
                setState(() => isLoading = false);
              }
            },
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            child: Text("POST"),
            onPressed: () async {
              setState(() => isLoading = true);
              try {
                Response response = await Dio().post(
                  "http://185.16.40.113:8080/api/auth/login",
                  data: {"username": "a", "password": "1"},
                  options: Options(
                    headers: {
                      "Content-Type": "application/json",
                      "token": "45425426-1363-4ee3-9056-7716b5d91583",
                    },
                  ),
                );
                slogan = "${response.data}";
                setState(() => isLoading = false);
              } catch (e) {
                slogan = "$e";
                setState(() => isLoading = false);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: isLoading == true
              ? CircularProgressIndicator()
              : Text("DATA = $slogan"),
        ),
      ),
    );
  }
}
