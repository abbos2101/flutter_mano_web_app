import 'package:flutter/material.dart';
import 'package:flutter_resume_app/data/util/colors.dart';
import 'package:flutter_resume_app/data/widget/widget.dart';
import '../bloc/content_rule_bloc.dart';

class RuleExampleScreen extends StatefulWidget {
  static MaterialPageRoute route({
    @required ExampleState exampleState,
    @required ContentRuleBlocImp contentRuleBlocImp,
  }) =>
      MaterialPageRoute(
        builder: (_) => screen(
          exampleState: exampleState,
          contentRuleBlocImp: contentRuleBlocImp,
        ),
      );

  static Widget screen({
    @required ExampleState exampleState,
    @required ContentRuleBlocImp contentRuleBlocImp,
  }) =>
      RuleExampleScreen(exampleState, contentRuleBlocImp);

  final ExampleState state;
  final ContentRuleBlocImp imp;

  const RuleExampleScreen(this.state, this.imp);

  @override
  _RuleExampleScreenState createState() => _RuleExampleScreenState();
}

class _RuleExampleScreenState extends State<RuleExampleScreen> {
  @override
  Widget build(BuildContext context) {
    final ExampleState state = widget.state;
    final ContentRuleBlocImp imp = widget.imp;
    return Scaffold(
      backgroundColor: MyColors.greyLight,
      body: widgetBody(
        ruleName: state.name,
        items: state.ruleWords,
        onPressedNext: () => imp.onPressedNextButton(
          ruleId: state.ruleId,
          answer: true,
        ),
      ),
    );
  }

  Widget widgetBody({
    @required String ruleName,
    @required List<ItemRuleWords> items,
    @required onPressedNext,
  }) {
    print(items.length);
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: MyColors.orangeAccent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              '$ruleName',
              style: TextStyle(color: MyColors.black, fontSize: 18),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: (items != null) ? items.length : 0,
                itemBuilder: (context, index) => Row(children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 2, left: 10),
                          padding: EdgeInsets.all(5),
                          color: MyColors.orangeAccent,
                          child: Text(
                            '${items[index].uz}',
                            style:
                                TextStyle(color: MyColors.black, fontSize: 16),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.only(bottom: 2, right: 10, left: 1),
                        padding: EdgeInsets.all(5),
                        color: MyColors.orangeAccent,
                        child: Text(
                          '${items[index].ru}',
                          style: TextStyle(color: MyColors.black, fontSize: 16),
                        ),
                      ))
                    ])),
          ),
          WButton(
            onPressed: onPressedNext,
            height: 55,
            width: 200,
            text: "Tushundim",
            textBold: true,
            textColor: Colors.black,
            circular: 55,
            margin: EdgeInsets.only(bottom: 30),
          ),
        ]));
  }
}
