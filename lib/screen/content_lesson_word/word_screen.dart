import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume_app/data/util/colors.dart';
import 'package:flutter_resume_app/data/widget/widget.dart';
import 'package:flutter_resume_app/home_screen.dart';
import 'package:flutter_resume_app/screen/content_faq/faq_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'bloc/content_word_bloc.dart';

class ContentWordScreen extends StatefulWidget {
  static Widget screen({@required int lessonId}) => HomeScreen(
        child: BlocProvider(
          create: (context) => ContentWordBloc(context, lessonId),
          child: ContentWordScreen(),
        ),
      );

  @override
  _ContentWordScreenState createState() => _ContentWordScreenState();
}

class _ContentWordScreenState extends State<ContentWordScreen> {
  ContentWordBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<ContentWordBloc>(context);
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
    return BlocBuilder<ContentWordBloc, ContentWordState>(
      builder: (context, state) => Scaffold(
        backgroundColor: MyColors.greyLight,
        appBar: widgetAppBar(state),
        body: widgetBody(state),
      ),
    );
  }

  Widget widgetAppBar(ContentWordState state) {
    if (state is TestState)
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
                valueColor:
                    AlwaysStoppedAnimation<Color>(MyColors.orangeAccent),
                value: state.progress,
              ),
            ),
            SizedBox(width: 5),
            MaterialButton(
              padding: EdgeInsets.all(0),
              minWidth: 50,
              height: 50,
              shape: CircleBorder(),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FAQScreen.screen(
                    itemId: state.wordId,
                    faqType: FaqType.WORD,
                  ),
                ),
              ),
              child: SvgPicture.asset(
                "assets/icon_help.svg",
                width: 40,
                height: 40,
              ),
            ),
          ],
        ),
      );
    if (state is CheckState)
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
                valueColor:
                    AlwaysStoppedAnimation<Color>(MyColors.orangeAccent),
                value: state.progress,
              ),
            ),
            SizedBox(width: 55),
          ],
        ),
      );
    if (state is FinishState)
      return AppBar(
        backgroundColor: MyColors.greyLight,
        elevation: 0,
        leading: SizedBox(),
      );
    return AppBar(
      backgroundColor: MyColors.greyLight,
      elevation: 0,
      leading: SizedBox(),
      flexibleSpace: Row(children: [
        SizedBox(width: 15),
        WButtonExit(color: MyColors.greyDark),
      ]),
    );
  }

  Widget widgetBody(ContentWordState state) {
    if (state is LoadingState) return WLoading();
    if (state is TestState) return widgetBodyTest(state);
    if (state is CheckState) return widgetBodyCheck(state);
    if (state is FailState)
      return Center(
        child: Text("${state.message}", style: TextStyle(fontSize: 16)),
      );
    if (state is FinishState) return widgetBodyFinish(state);
    return SizedBox();
  }

  Widget widgetBodyTest(TestState state) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(30),
      child: Column(
        children: [
          Expanded(child: SizedBox()),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: state.imageName != null
                      ? NetworkImage(
                          'http://185.16.40.113:8080/api/download/image/${state.imageName}',
                        )
                      : AssetImage(
                          'assets/error_gif/img${state.trueAnswer.length % 5 + 1}.gif',
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
                  "${state.question}",
                  style: TextStyle(fontSize: 16, color: MyColors.red),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MaterialButton(
                  onPressed: () => bloc.add(BackEvent()),
                  minWidth: 55,
                  height: 55,
                  shape: CircleBorder(),
                  child: Icon(Icons.arrow_back_outlined, size: 30),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      WButton(
                        width: 200,
                        height: 55,
                        color: MyColors.greyLight,
                        shadowColor: MyColors.grey,
                        circular: 50,
                        onPressed: () =>
                            bloc.add(WordPressedEvent(word: state.firstAnswer)),
                        text: state.firstAnswer,
                        textColor: MyColors.greyDark,
                      ),
                      SizedBox(height: 10),
                      WButton(
                        width: 200,
                        height: 55,
                        color: MyColors.greyLight,
                        circular: 50,
                        onPressed: () => bloc
                            .add(WordPressedEvent(word: state.secondAnswer)),
                        text: state.secondAnswer,
                        textColor: MyColors.greyDark,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget widgetBodyCheck(CheckState state) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(30),
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img_content_example.png")),
                    ),
                    child: Text(
                      "${state.example}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Text(
                    "${state.answer}",
                    style: TextStyle(fontSize: 16, color: MyColors.red),
                  )
                ],
              )),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: state.imageName != null
                      ? NetworkImage(
                          'http://185.16.40.113:8080/api/download/image/${state.imageName}',
                        )
                      : AssetImage(
                          'assets/error_gif/img${state.answer.length % 5 + 1}.gif',
                        ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(top: 40, bottom: 40),
              decoration: BoxDecoration(
                color: state.check == true ? MyColors.green : MyColors.red,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: SizedBox(height: 50)),
                      state.soundName == null
                          ? SizedBox()
                          : MaterialButton(
                              minWidth: 50,
                              height: 50,
                              padding: EdgeInsets.all(0),
                              shape: CircleBorder(),
                              onPressed: () => bloc.add(
                                  AudioPlayEvent(soundName: state.soundName)),
                              child: Icon(
                                Icons.volume_up,
                                color: MyColors.white,
                                size: 30,
                              ),
                            ),
                      SizedBox(width: 10),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(bottom: 50),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${state.check == true ? "To'g'ri" : "To’g’ri javob"}",
                            style: TextStyle(
                              color: MyColors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "${state.answer}",
                            style: TextStyle(
                              color: MyColors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MaterialButton(
                  onPressed: () => bloc.add(BackEvent()),
                  minWidth: 55,
                  height: 55,
                  shape: CircleBorder(),
                  child: Icon(Icons.arrow_back_outlined, size: 30),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      WButton(
                        width: 200,
                        height: 55,
                        color: MyColors.orangeAccent,
                        circular: 55,
                        onPressed: () => bloc.add(NextQuestionEvent()),
                        text: "KEYINGISI",
                        textColor: MyColors.black,
                        fontSize: 16,
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                SizedBox(width: 55),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget widgetBodyFinish(FinishState state) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Keyinchalik o'rganadigan so'zlariningizni belgilang",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.separated(
                itemCount: state.list.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) => InkWell(
                      onTap: () => bloc.add(FinishCheckEvent(index: index)),
                      child: Row(children: [
                        Checkbox(
                          value: state.list[index].check != true,
                          onChanged: (value) => bloc.add(
                            FinishCheckEvent(index: index),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${state.list[index].question}',
                            style: TextStyle(
                              fontSize: 20,
                              color: MyColors.greyDark,
                            ),
                          ),
                        ),
                      ]),
                    )),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(width: 30),
              MaterialButton(
                onPressed: () => bloc.add(BackEvent()),
                minWidth: 55,
                height: 55,
                shape: CircleBorder(),
                child: Icon(Icons.arrow_back_outlined, size: 30),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    WButton(
                      width: 200,
                      height: 55,
                      color: MyColors.orangeAccent,
                      circular: 55,
                      text: "Qo'shish(${state.count})",
                      fontSize: 16,
                      textColor: MyColors.black,
                      onPressed: () => bloc.add(FinishAddEvent()),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              SizedBox(width: 85),
            ],
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
