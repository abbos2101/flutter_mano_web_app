import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_resume_app/data/util/colors.dart';
import 'package:flutter_resume_app/data/widget/widget.dart';
import '../bloc/content_exercise_bloc.dart';

class PictureScreen extends StatefulWidget {
  static MaterialPageRoute route({
    @required PictureState pictureState,
    @required ContentExerciseImp contentExerciseImp,
  }) =>
      MaterialPageRoute(
        builder: (context) => screen(
          pictureState: pictureState,
          contentExerciseImp: contentExerciseImp,
        ),
      );

  static Widget screen({
    @required PictureState pictureState,
    @required ContentExerciseImp contentExerciseImp,
  }) =>
      PictureScreen(pictureState, contentExerciseImp);

  final PictureState state;
  final ContentExerciseImp imp;

  const PictureScreen(this.state, this.imp);

  @override
  _PictureScreenState createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {
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
          Expanded(flex: 1, child: SizedBox()),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: widget.state.correctImageLink != null
                      ? NetworkImage(
                          'http://185.16.40.113:8080/api/download/image/${widget.state.correctImageLink}',
                        )
                      : AssetImage(
                          'assets/error_gif/img${widget.state.correctRu.length % 5 + 1}.gif',
                        ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  "Tarjima qiling",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "${widget.state.correctUz}",
                  style: TextStyle(fontSize: 16, color: MyColors.red),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          widgetCard(),
          widgetCheckButton(),
        ],
      ),
    );
  }

  Widget widgetImage() {
    return Expanded(
        child: Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: widget.state.correctImageLink != null
              ? NetworkImage(
                  'http://185.16.40.113:8080/api/download/image/${widget.state.correctImageLink}',
                )
              : AssetImage(
                  'assets/error_gif/img${widget.state.correctRu.length % 5 + 1}.gif',
                ),
          fit: BoxFit.fill,
        ),
      ),
    ));
  }

  Widget widgetCard() {
    if (checkButton == false)
      return WCardVoice(
        answer: answer,
        height: 180,
        circular: 25,
        text: answer ? "" : widget.state.correctRu,
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
                ? "${widget.state.correctRu}"
                : "${widget.state.wrongRu}",
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
                ? "${widget.state.correctRu}"
                : "${widget.state.wrongRu}",
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
      width: 200,
      height: 55,
      circular: 55,
      text: "Keyingisi",
      margin: EdgeInsets.only(bottom: 15, top: 40),
      onPressed: () {
        widget.imp.onNext(exercisePictureId: widget.state.id, answer: answer);
      },
    );
  }
}
