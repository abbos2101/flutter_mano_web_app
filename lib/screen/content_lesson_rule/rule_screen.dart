import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume_app/data/util/colors.dart';
import 'package:flutter_resume_app/data/widget/widget.dart';
import 'package:flutter_resume_app/home_screen.dart';
import 'package:flutter_resume_app/screen/content_faq/faq_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'bloc/content_rule_bloc.dart';
import 'state_screen/state_screen.dart';

class ContentRuleScreen extends StatefulWidget {
  static Widget screen({@required int lessonId}) => HomeScreen(
        child: BlocProvider(
          create: (context) =>
              ContentRuleBloc(context: context, lessonId: lessonId),
          child: ContentRuleScreen(),
        ),
      );

  @override
  _ContentRuleScreenState createState() => _ContentRuleScreenState();
}

class _ContentRuleScreenState extends State<ContentRuleScreen>
    implements ContentRuleBlocImp {
  ContentRuleBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<ContentRuleBloc>(context);
    bloc.add(LoadRuleEvent());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  void onPressedNextButton({int ruleId, bool answer}) =>
      bloc.add(NextPageEvent(ruleId: ruleId, answer: answer));

  @override
  void onPlayAudio(String soundName) =>
      bloc.add(AudioPlayEvent(soundName: soundName));

  @override
  void onPressedFinish() => bloc.add(FinishEvent());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContentRuleBloc, ContentRuleState>(
      builder: (context, state) => Scaffold(
        backgroundColor: MyColors.greyLight,
        floatingActionButton: widgetFloatButton(state),
        appBar: widgetAppBar(state),
        body: widgetBody(state),
      ),
    );
  }

  Widget widgetAppBar(ContentRuleState state) {
    if (state is LoadingState || state is FinishState)
      return AppBar(
        backgroundColor: MyColors.greyLight,
        elevation: 0,
        leading: SizedBox(),
      );
    return AppBar(
      backgroundColor: MyColors.greyLight,
      elevation: 0,
      leading: SizedBox(),
      flexibleSpace: Row(
        children: [
          SizedBox(width: 15),
          WButtonExit(color: MyColors.greyDark),
          Expanded(
            child: LinearProgressIndicator(
              minHeight: 15,
              backgroundColor: MyColors.greyDark,
              valueColor: AlwaysStoppedAnimation<Color>(MyColors.orangeAccent),
              value: state.progress,
            ),
          ),
          SizedBox(width: 5),
          MaterialButton(
            padding: EdgeInsets.all(0),
            minWidth: 50,
            height: 50,
            shape: CircleBorder(),
            onPressed: () {
              if (state is ExampleState)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FAQScreen.screen(
                        itemId: state.ruleId, faqType: FaqType.RULE),
                  ),
                );
              if (state is SentenceState)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FAQScreen.screen(
                        itemId: state.ruleId, faqType: FaqType.RULE),
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

  Widget widgetFloatButton(ContentRuleState state) {
    if (state is FinishState) return SizedBox();
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
  }

  Widget widgetBody(ContentRuleState state) {
    if (state is LoadingState) return WLoading();
    if (state is ExampleState)
      return RuleExampleScreen.screen(
        exampleState: state,
        contentRuleBlocImp: this,
      );
    if (state is SentenceState)
      return RuleSentenceScreen.screen(
        sentenceState: state,
        contentRuleBlocImp: this,
      );
    if (state is FinishState)
      return RuleFinishScreen.screen(
        finishState: state,
        contentRuleBlocImp: this,
      );
    if (state is FailState) return Center(child: Text('${state.message}'));
    return Center(child: Text('Xatolik'));
  }
}
