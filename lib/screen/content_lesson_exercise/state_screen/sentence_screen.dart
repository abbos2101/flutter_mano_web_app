import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_resume_app/data/util/colors.dart';
import 'package:flutter_resume_app/data/widget/widget.dart';
import '../bloc/content_exercise_bloc.dart';

class SentenceScreen extends StatefulWidget {
  static MaterialPageRoute route({
    @required SentenceState sentenceState,
    @required ContentExerciseImp contentExerciseImp,
  }) =>
      MaterialPageRoute(
        builder: (context) => screen(
          sentenceState: sentenceState,
          contentExerciseImp: contentExerciseImp,
        ),
      );

  static Widget screen({
    @required SentenceState sentenceState,
    @required ContentExerciseImp contentExerciseImp,
  }) =>
      SentenceScreen(sentenceState, contentExerciseImp);

  final SentenceState state;
  final ContentExerciseImp imp;

  const SentenceScreen(this.state, this.imp);

  @override
  _SentenceScreenState createState() => _SentenceScreenState();
}

class _SentenceScreenState extends State<SentenceScreen> {
  final int rand = Random().nextInt(2);
  final TextEditingController controller = TextEditingController();
  int answerIndex;
  bool checkButton = true;
  bool answer;

  @override
  void initState() {
    controller.addListener(() {
      String text = controller.text;
      if (text.trim().isEmpty) {
        setState(() => answer = null);
        return;
      }
      setState(
        () => answer = widget.state.answer.trim().toLowerCase() ==
            text.trim().toLowerCase(),
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    FocusScope.of(context).requestFocus(FocusNode());
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.greyLight,
      bottomSheet: Container(
        width: double.infinity,
        height: 100,
        color: MyColors.greyLight,
        alignment: Alignment.bottomCenter,
        child: widgetCheckButton(),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                "Jumlani to'ldiring",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 60,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 20, top: 5, left: 5, right: 5),
              margin: EdgeInsets.only(left: 30, right: 30),
              child: Text("${widget.state.question}",
                  style: TextStyle(fontSize: 16)),
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/img_content_example.png"),
                fit: BoxFit.fill,
              )),
            ),
            SizedBox(height: 10),
            Expanded(
                child: TextField(
              readOnly: !checkButton,
              controller: controller,
              maxLines: 150,
              decoration: InputDecoration(
                hintText: "Gapni kiriting",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            )),
            SizedBox(height: 10),
            checkButton
                ? SizedBox()
                : WCardVoice(
                    answer: answer,
                    height: 180,
                    circular: 25,
                    text: answer ? "" : widget.state.answer,
                  ),
            SizedBox(height: 80),
          ],
        ),
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
        margin: EdgeInsets.only(bottom: 35),
        onPressed: answer == null
            ? null
            : () {
                FocusScope.of(context).requestFocus(FocusNode());
                setState(() => checkButton = false);
              },
      );
    //Next Button
    return WButton(
      width: 200,
      height: 55,
      circular: 55,
      text: "Keyingisi",
      textColor: MyColors.black,
      margin: EdgeInsets.only(bottom: 35),
      onPressed: () {
        FocusScope.of(context).requestFocus(FocusNode());
        widget.imp.onNext(exerciseSentenceId: widget.state.id, answer: answer);
      },
    );
  }
}
