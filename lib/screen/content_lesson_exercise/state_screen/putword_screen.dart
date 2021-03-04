import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_resume_app/data/util/colors.dart';
import 'package:flutter_resume_app/data/widget/widget.dart';
import '../bloc/content_exercise_bloc.dart';

class PutWordScreen extends StatefulWidget {
  static MaterialPageRoute route({
    @required PutWordState putWordState,
    @required ContentExerciseImp contentExerciseImp,
  }) =>
      MaterialPageRoute(
        builder: (context) => screen(
          putWordState: putWordState,
          contentExerciseImp: contentExerciseImp,
        ),
      );

  static Widget screen({
    @required PutWordState putWordState,
    @required ContentExerciseImp contentExerciseImp,
  }) =>
      PutWordScreen(putWordState, contentExerciseImp);

  final PutWordState state;
  final ContentExerciseImp imp;

  const PutWordScreen(this.state, this.imp);

  @override
  _PutWordScreenState createState() => _PutWordScreenState();
}

class _PutWordScreenState extends State<PutWordScreen> {
  final int rand = Random().nextInt(2);
  int answerIndex;
  bool checkButton = true;
  bool answer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: MyColors.greyLight,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            child: Text("${widget.state.name}"),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: MyColors.orangeAccent,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: Text(
              "Tushirib qoldirilgan so'zni qo'ying",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          widgetQuestion(),
          Expanded(child: SizedBox()),
          widgetCard(),
          widgetCheckButton(),
        ],
      ),
    );
  }

  Widget widgetQuestion() {
    String sentence = widget.state.sentence;
    if (checkButton == false)
      sentence = sentence.replaceAll("[...]", "${widget.state.correct}");
    return Container(
      width: double.infinity,
      height: 60,
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 20, top: 5, left: 5, right: 5),
      margin: EdgeInsets.only(left: 30, right: 30),
      child: Text("$sentence", style: TextStyle(fontSize: 16)),
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/img_content_example.png"),
        fit: BoxFit.fill,
      )),
    );
  }

  Widget widgetCard() {
    if (checkButton == false)
      return WCardVoice(
        answer: answer,
        height: 180,
        circular: 25,
        text: answer ? "" : widget.state.correct,
      );
    return SizedBox(
      height: 180,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          WButton(
            width: double.infinity,
            height: 55,
            circular: 55,
            margin: EdgeInsets.only(left: 40, right: 40, bottom: 10),
            color: answerIndex == null || answerIndex != 0
                ? MyColors.greyLight
                : MyColors.grey,
            textColor: Colors.black,
            text: rand % 2 == 0
                ? "${widget.state.correct}"
                : "${widget.state.wrong}",
            onPressed: () => setState(() {
              answerIndex = 0;
              answer = rand % 2 == answerIndex;
            }),
          ),
          WButton(
            width: double.infinity,
            height: 55,
            circular: 55,
            margin: EdgeInsets.only(left: 40, right: 40),
            color: answerIndex == null || answerIndex != 1
                ? MyColors.greyLight
                : MyColors.grey,
            textColor: Colors.black,
            text: rand % 2 != 0
                ? "${widget.state.correct}"
                : "${widget.state.wrong}",
            onPressed: () => setState(() {
              answerIndex = 1;
              answer = rand % 2 == answerIndex;
            }),
          ),
        ],
      ),
    );
  }

  Widget widgetCheckButton() {
    //Check Button
    if (checkButton)
      return WButton(
        width: 200,
        height: 55,
        circular: 55,
        text: "Tekshirish",
        color: answer != null ? null : MyColors.greyLight,
        textColor: MyColors.black,
        margin: EdgeInsets.only(bottom: 15, top: 40),
        onPressed:
            answer == null ? null : () => setState(() => checkButton = false),
      );
    //Next Button
    return WButton(
      width: 180,
      height: 55,
      circular: 55,
      text: "Keyingisi",
      textColor: MyColors.black,
      margin: EdgeInsets.only(bottom: 15, top: 40),
      onPressed: () {
        widget.imp.onNext(exercisePutWordId: widget.state.id, answer: answer);
      },
    );
  }
}
