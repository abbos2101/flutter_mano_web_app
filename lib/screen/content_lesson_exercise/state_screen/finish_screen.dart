import 'package:flutter/material.dart';
import 'package:flutter_resume_app/data/widget/widget.dart';
import '../bloc/content_exercise_bloc.dart';

class FinishScreen extends StatefulWidget {
  static MaterialPageRoute route({
    @required FinishState finishState,
    @required ContentExerciseImp contentExerciseImp,
  }) =>
      MaterialPageRoute(
        builder: (context) => screen(
          finishState: finishState,
          contentExerciseImp: contentExerciseImp,
        ),
      );

  static Widget screen({
    @required FinishState finishState,
    @required ContentExerciseImp contentExerciseImp,
  }) =>
      FinishScreen(finishState, contentExerciseImp);

  final FinishState state;
  final ContentExerciseImp imp;

  const FinishScreen(this.state, this.imp);

  @override
  _FinishScreenState createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/error_gif/win.gif',
          height: 200,
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: WButton(
          width: 200,
          height: 55,
          circular: 55,
          text: "Tugatish",
          textBold: true,
          onPressed: () => widget.imp.onPressedFinish(),
          textColor: Colors.black,
          margin: EdgeInsets.only(bottom: 35),
        ),
      ),
    );
  }
}
