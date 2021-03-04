import 'package:flutter/material.dart';
import 'package:flutter_resume_app/data/util/colors.dart';
import 'package:flutter_resume_app/data/widget/widget.dart';
import '../bloc/content_rule_bloc.dart';

class RuleFinishScreen extends StatefulWidget {
  static MaterialPageRoute route({
    @required FinishState finishState,
    @required ContentRuleBlocImp contentRuleBlocImp,
  }) =>
      MaterialPageRoute(
        builder: (_) => screen(
          finishState: finishState,
          contentRuleBlocImp: contentRuleBlocImp,
        ),
      );

  static Widget screen({
    @required FinishState finishState,
    @required ContentRuleBlocImp contentRuleBlocImp,
  }) =>
      RuleFinishScreen(finishState, contentRuleBlocImp);

  final FinishState state;
  final ContentRuleBlocImp imp;

  const RuleFinishScreen(this.state, this.imp);

  @override
  _RuleFinishScreenState createState() => _RuleFinishScreenState();
}

class _RuleFinishScreenState extends State<RuleFinishScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.greyLight,
      body: Center(
        child: Image.asset(
          'assets/error_gif/win.gif',
          height: 200,
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: WButton(
          width: 180,
          height: 60,
          circular: 15,
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
