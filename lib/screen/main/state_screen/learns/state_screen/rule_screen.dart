import 'package:flutter/material.dart';
import 'package:flutter_resume_app/data/model/lesson/rule_client_model.dart';

class RuleScreen extends StatefulWidget {
  static MaterialPageRoute route({List<RuleClientModel> ruleList}) =>
      MaterialPageRoute(builder: (context) => screen(ruleList: ruleList));

  static Widget screen({List<RuleClientModel> ruleList}) =>
      RuleScreen(ruleList);

  final List<RuleClientModel> ruleList;

  const RuleScreen(this.ruleList);

  @override
  _RuleScreenState createState() => _RuleScreenState();
}

class _RuleScreenState extends State<RuleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: widget.ruleList.length,
        itemBuilder: (context, index) =>
            widgetItem(ruleText: widget.ruleList[index].name),
      ),
    );
  }

  Widget widgetItem({String ruleText}) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.orangeAccent.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text("$ruleText"),
    );
  }
}
