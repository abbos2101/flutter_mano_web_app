import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume_app/data/model/faq/faq_model.dart';
import 'package:flutter_resume_app/data/util/colors.dart';
import 'package:flutter_resume_app/data/widget/widget.dart';
import 'package:flutter_resume_app/home_screen.dart';
import 'package:flutter_resume_app/screen/fail/default/default_fail_screen.dart';
import 'model.dart';
export 'model.dart';
import 'bloc/faq_bloc.dart';

class FAQScreen extends StatefulWidget {
  static Widget screen({@required int itemId, @required FaqType faqType}) =>
      HomeScreen(
        child: BlocProvider(
          create: (context) => FaqBloc(context, itemId, faqType),
          child: FAQScreen(),
        ),
      );

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  FaqBloc bloc;
  final TextEditingController controller = TextEditingController();
  bool sendEnabled = false;

  @override
  void initState() {
    bloc = BlocProvider.of<FaqBloc>(context);
    bloc.add(LaunchEvent());
    controller.addListener(() {
      sendEnabled = controller.text.trim().isNotEmpty;
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.white,
          elevation: 0,
          leading: SizedBox(),
          flexibleSpace: Row(children: [SizedBox(width: 15), WButtonExit()]),
        ),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: BlocBuilder<FaqBloc, FaqState>(
          builder: (context, state) {
            if (state is LoadingState) {
              if (state.loading) return WLoading();
              return widgetBody(state.faqList, true);
            }
            if (state is SuccessState) return widgetBody(state.faqList, false);
            if (state is FailState)
              return DefaultFailScreen.screen(message: state.message);
            return DefaultFailScreen.screen(message: "Xatolik sodir bo'ldi");
          },
        ),
      ),
    );
  }

  Widget widgetBody(List<FaqModel> list, bool loading) {
    List<ItemModel> items = [];
    for (int i = 0; i < list.length; i++) {
      items.add(ItemModel(
        admin: false,
        publish: list[i].status == "PUBLISHED",
        text: list[i].question,
        login: list[i].clientLogin,
      ));
      if (list[i].status != "PUBLISHED")
        items.add(ItemModel(
          admin: true,
          publish: false,
          text: "Tez orada javob berishadi",
          login: list[i].clientLogin,
        ));
      for (int j = 0; j < list[i].answers.length; j++)
        items.add(ItemModel(
          admin: true,
          publish: true,
          text: list[i].answers[j].answer,
          login: list[i].answers[j].adminName,
        ));
    }
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
              child: list.isEmpty
                  ? Center(
                      child: Text(
                      "Savollar mavjud emas😞",
                      style: TextStyle(fontSize: 18),
                    ))
                  : ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, i) => widgetItem(items[i]),
                    )),
          SizedBox(
            height: 4,
            child: loading == true
                ? LinearProgressIndicator(backgroundColor: Colors.yellow)
                : null,
          ),
          Divider(),
          Container(
            width: double.infinity,
            color: Colors.white,
            margin: EdgeInsets.only(left: 100, bottom: 40),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(hintText: "Savolni yozing..."),
                  ),
                ),
                MaterialButton(
                  onPressed: sendEnabled
                      ? () {
                          bloc.add(SendEvent(question: controller.text));
                          controller.clear();
                        }
                      : null,
                  shape: CircleBorder(),
                  minWidth: 50,
                  height: 50,
                  child: Icon(
                    Icons.send,
                    size: 30,
                    color: sendEnabled ? Colors.orangeAccent : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget widgetItem(ItemModel model) {
    if (model.admin)
      return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: model.publish ? Colors.grey[200] : Colors.grey[400],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.elliptical(50, 10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )),
          child: Text(
            "${model.text}",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.orangeAccent[100],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomRight: Radius.elliptical(50, 10),
          ),
        ),
        child: Text(
          "${model.text}",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
