import 'package:flutter/material.dart';
import 'package:flutter_resume_app/home_screen.dart';

class DefaultFailScreen extends StatefulWidget {
  static Widget screen({@required String message}) => HomeScreen(
        child: DefaultFailScreen(message),
      );

  const DefaultFailScreen(this.message);

  final String message;

  @override
  _DefaultFailScreenState createState() => _DefaultFailScreenState();
}

class _DefaultFailScreenState extends State<DefaultFailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('${widget.message ?? 'Xatolik'}')),
    );
  }
}
