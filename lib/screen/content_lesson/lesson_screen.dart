import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume_app/data/model/lesson/lesson_access_model.dart';
import 'package:flutter_resume_app/data/util/colors.dart';
import 'package:flutter_resume_app/data/widget/widget.dart';
import 'package:flutter_resume_app/home_screen.dart';
import 'package:polygon_clipper/polygon_border.dart';
import 'bloc/content_lesson_bloc.dart';

class ContentLessonScreen extends StatefulWidget {
  static Widget screen({
    @required int lessonId,
    @required String lessonIdString,
    LessonAccessModel accessModel,
  }) =>
      HomeScreen(
          child: BlocProvider(
        create: (context) => ContentLessonBloc(
          context,
          lessonId: lessonId,
          lessonIdString: lessonIdString,
          lessonAccessModel: accessModel,
        ),
        child: ContentLessonScreen(),
      ));

  @override
  _ContentLessonScreenState createState() => _ContentLessonScreenState();
}

class _ContentLessonScreenState extends State<ContentLessonScreen> {
  ContentLessonBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<ContentLessonBloc>(context);
    bloc.add(LaunchEvent());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContentLessonBloc, ContentLessonState>(
      builder: (context, state) => Scaffold(
        backgroundColor: MyColors.greyLight,
        appBar: widgetAppBar(state),
        body: widgetBody(state),
      ),
    );
  }

  Widget widgetAppBar(ContentLessonState state) {
    return AppBar(
      leading: SizedBox(),
      backgroundColor: MyColors.greyLight,
      elevation: 0,
      flexibleSpace: Row(
        children: [
          SizedBox(width: 15),
          WButtonExit(),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  Widget widgetBody(ContentLessonState state) {
    if (state is LoadingState) return WLoading();
    if (state is SuccessState) return widgetSuccessBody(state);
    if (state is FailState)
      return Center(
        child: Text("${state.message}", style: TextStyle(fontSize: 18)),
      );
    return Center(
      child: Text("Xatolik sodir bo'ldi:(", style: TextStyle(fontSize: 18)),
    );
  }

  Widget widgetSuccessBody(SuccessState state) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Expanded(flex: 2, child: SizedBox()),
          Text(
            "${state.blocName}",
            style: TextStyle(
              color: MyColors.orange,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(flex: 1, child: SizedBox()),
          Text(
            "${state.indexLessonName}",
            style: TextStyle(
              color: MyColors.orange,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${state.lessonName}",
              style: TextStyle(color: MyColors.greyDark, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(flex: 2, child: SizedBox()),
          Expanded(
              flex: 6,
              child: widgetItemsBody(
                word: state.word,
                rule: state.rule,
                exercise: state.exercise,
              )),
          Expanded(flex: 2, child: SizedBox()),
        ],
      ),
    );
  }

  Widget widgetItemsBody({
    bool word = true,
    bool rule = false,
    bool exercise = false,
  }) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;
    final double width = w > h ? h * 0.5 : w;
    final Function onPressedWord = () => bloc.add(PushWordEvent());
    final Function onPressedRule =
        word == true ? () => bloc.add(PushRuleEvent()) : null;
    final Function onPressedExercise =
        rule == true ? () => bloc.add(PushExerciseEvent()) : null;
    return Stack(
      children: [
        Container(
          width: width * 0.4,
          height: width * 0.4,
          margin: EdgeInsets.only(
            right: width * 0.34,
            bottom: width * 0.29,
          ),
          alignment: Alignment.center,
          child: MaterialButton(
            minWidth: width * 0.36,
            height: width * 0.36,
            shape: PolygonBorder(sides: 6),
            onPressed: onPressedWord,
            child: Text(
              "So'zlar",
              style: TextStyle(
                color: MyColors.black,
                fontSize: 18,
              ),
            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/img_content_progress_${word == true ? "" : "in"}active.png"),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Container(
          width: width * 0.4,
          height: width * 0.4,
          margin: EdgeInsets.only(
            left: width * 0.34,
            bottom: width * 0.29,
          ),
          alignment: Alignment.center,
          child: MaterialButton(
            minWidth: width * 0.36,
            height: width * 0.36,
            shape: PolygonBorder(sides: 6),
            onPressed: onPressedRule,
            child: Text(
              "Qoida",
              style: TextStyle(
                color: word == true ? MyColors.black : MyColors.greyDark,
                fontSize: 18,
              ),
            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/img_content_progress_${rule == true ? "" : "in"}active.png"),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Container(
          width: width * 0.4,
          height: width * 0.4,
          margin: EdgeInsets.only(top: width * 0.29, left: width * 0.17),
          alignment: Alignment.center,
          child: MaterialButton(
            minWidth: width * 0.36,
            height: width * 0.36,
            shape: PolygonBorder(sides: 6),
            onPressed: onPressedExercise,
            child: Text(
              "Mashq",
              style: TextStyle(
                color: rule == true ? MyColors.black : MyColors.greyDark,
                fontSize: 18,
              ),
            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/img_content_progress_${exercise == true ? "" : "in"}active.png"),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ],
    );
  }
}
