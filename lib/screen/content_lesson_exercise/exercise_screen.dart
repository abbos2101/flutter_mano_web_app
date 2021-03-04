import 'package:flutter/material.dart';
import 'package:flutter_resume_app/data/util/colors.dart';
import 'package:flutter_resume_app/data/widget/widget.dart';
import 'package:flutter_resume_app/home_screen.dart';
import 'package:flutter_resume_app/screen/content_faq/faq_screen.dart';
import 'package:flutter_resume_app/screen/fail/default/default_fail_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/content_exercise_bloc.dart';
import 'state_screen/state_screen.dart';

class ContentExerciseScreen extends StatefulWidget {
  static Widget screen({@required int lessonId}) => HomeScreen(
        child: BlocProvider(
          create: (context) => ContentExerciseBloc(
            context: context,
            lessonId: lessonId,
          ),
          child: ContentExerciseScreen(),
        ),
      );

  @override
  _ContentExerciseScreenState createState() => _ContentExerciseScreenState();
}

class _ContentExerciseScreenState extends State<ContentExerciseScreen>
    implements ContentExerciseImp {
  ContentExerciseBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<ContentExerciseBloc>(context);
    bloc.add(LoadExerciseEvent());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ContentExerciseBloc, ContentExerciseState>(
        builder: (context, state) => Scaffold(
          backgroundColor: MyColors.greyLight,
          appBar: widgetAppBar(state),
          floatingActionButton: widgetFloatButton(state),
          body: widgetBody(state),
        ),
      ),
    );
  }

  @override
  void onNext(
          {int exerciseCheckId,
          int exercisePictureId,
          int exerciseSentenceId,
          int exercisePutWordId,
          bool answer}) =>
      bloc.add(NextPageEvent(
        exerciseCheckId: exerciseCheckId,
        exercisePictureId: exercisePictureId,
        exerciseSentenceId: exerciseSentenceId,
        exercisePutWordId: exercisePutWordId,
        answer: answer,
      ));

  Widget widgetAppBar(ContentExerciseState state) {
    if (state is LoadingState || state is FinishState)
      return AppBar(
        backgroundColor: MyColors.greyLight,
        leading: SizedBox(),
        elevation: 0,
      );
    if (state is FailState)
      return AppBar(
        backgroundColor: MyColors.greyLight,
        leading: SizedBox(),
        elevation: 0,
        flexibleSpace: Row(
          children: [
            SizedBox(width: 30),
            WButtonExit(),
          ],
        ),
      );
    return AppBar(
      backgroundColor: MyColors.greyLight,
      leading: SizedBox(),
      elevation: 0,
      flexibleSpace: Row(
        children: [
          SizedBox(width: 30),
          WButtonExit(),
          Expanded(
            child: LinearProgressIndicator(
              minHeight: 15,
              backgroundColor: MyColors.greyDark,
              valueColor: AlwaysStoppedAnimation<Color>(MyColors.orangeAccent),
              value: state.progress,
            ),
          ),
          MaterialButton(
            padding: EdgeInsets.all(0),
            minWidth: 50,
            height: 50,
            shape: CircleBorder(),
            onPressed: () {
              if (state is CheckState)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FAQScreen.screen(
                        itemId: state.id, faqType: FaqType.EXERCISE_CHECK),
                  ),
                );
              else if (state is PictureState)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FAQScreen.screen(
                        itemId: state.id, faqType: FaqType.EXERCISE_PICTURE),
                  ),
                );
              else if (state is SentenceState)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FAQScreen.screen(
                        itemId: state.id, faqType: FaqType.EXERCISE_SENTENCE),
                  ),
                );
              else if (state is PutWordState)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FAQScreen.screen(
                        itemId: state.id, faqType: FaqType.EXERCISE_PUTWORD),
                  ),
                );
            },
            child: SvgPicture.asset(
              "assets/icon_help.svg",
              width: 40,
              height: 40,
            ),
          ),
        ],
      ),
    );
  }

  Widget widgetFloatButton(ContentExerciseState state) {
    if (state is FinishState == false)
      return Container(
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.only(left: 30, bottom: 15),
        child: MaterialButton(
          minWidth: 55,
          height: 55,
          shape: CircleBorder(),
          onPressed: () => bloc.add(PreviousEvent()),
          child: Icon(Icons.arrow_back, size: 30),
        ),
      );
    return SizedBox();
  }

  Widget widgetBody(ContentExerciseState state) {
    if (state is LoadingState) return WLoading();
    if (state is CheckState)
      return CheckScreen.screen(
        checkState: state,
        contentExerciseImp: this,
      );
    if (state is PictureState)
      return PictureScreen.screen(
        pictureState: state,
        contentExerciseImp: this,
      );
    if (state is SentenceState)
      return SentenceScreen.screen(
        sentenceState: state,
        contentExerciseImp: this,
      );
    if (state is PutWordState)
      return PutWordScreen.screen(
        putWordState: state,
        contentExerciseImp: this,
      );
    if (state is FinishState)
      return FinishScreen.screen(
        finishState: state,
        contentExerciseImp: this,
      );
    if (state is FailState)
      return DefaultFailScreen.screen(message: "${state.message}");
    return DefaultFailScreen.screen(message: "Xatolik sodir bo'ldi");
  }

  @override
  void onPressedFinish() => bloc.add(FinishEvent());
}
