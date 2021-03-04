import 'package:flutter/material.dart';
import 'package:flutter_resume_app/home_screen.dart';

class SignupScreen extends StatefulWidget {
  static Widget screen() => HomeScreen(
        child: SignupScreen(),
      );

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
