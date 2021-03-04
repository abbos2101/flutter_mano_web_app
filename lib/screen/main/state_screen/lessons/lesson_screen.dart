import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume_app/data/util/colors.dart';
import 'package:flutter_resume_app/data/widget/widget.dart';
import 'bloc/lesson_bloc.dart';

class LessonScreen extends StatefulWidget {
  static Widget screen() => BlocProvider(
        create: (context) => LessonBloc(context),
        child: LessonScreen(),
      );

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  LessonBloc bloc;
  final PageController pageController = PageController(
    initialPage: 0,
    viewportFraction: 1,
  );
  bool isPaged = false;

  @override
  void initState() {
    bloc = BlocProvider.of<LessonBloc>(context);
    bloc.add(LaunchEvent());
    super.initState();
  }

  void setPage(int page) async {
    if (!isPaged) {
      await Future.delayed(Duration.zero);
      pageController.jumpToPage(page);
      isPaged = true;
    }
  }

  @override
  void dispose() {
    bloc.close();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonBloc, LessonState>(
      builder: (context, state) => Scaffold(
        backgroundColor: MyColors.greyLight,
        body: widgetBody(state),
      ),
    );
  }

  Widget widgetBody(LessonState state) {
    if (state is LoadingState) return WLoading();
    if (state is FailState) return widgetFailBody(message: state.message);
    if (state is SuccessState) return widgetSuccessBody(state);
    return widgetFailBody();
  }

  Widget widgetSuccessBody(SuccessState state) {
    setPage(state.current);
    return Column(
      children: [
        SizedBox(height: 80),
        Text(
          "${state.levelId}-level",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          "${state.levelName}",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 35,
          width: 100,
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 15, bottom: 30),
          decoration: BoxDecoration(
            color: MyColors.grey,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Text(
            "${state.progress}%",
            style: TextStyle(
              color: MyColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          "${state.blocName}",
          style: TextStyle(
            color: MyColors.orange,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 30,
          width: double.infinity,
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: state.pageList.length,
            itemBuilder: (context, i) {
              Color color = MyColors.grey;
              if (state.pageList[i].enabled) {
                if (state.pageList[i].word != null) {
                  if (state.pageList[i].word &&
                      state.pageList[i].rule &&
                      state.pageList[i].exercise)
                    color = MyColors.green;
                  else
                    color = MyColors.red;
                }
                if (state.pageList[i].dialog != null) {
                  if (state.pageList[i].dialog)
                    color = MyColors.green;
                  else
                    color = MyColors.red;
                }
                if (state.pageList[i].exam != null) {
                  if (state.pageList[i].exam)
                    color = MyColors.green;
                  else
                    color = MyColors.red;
                }
              }
              if (state.current == i) color = MyColors.greyDark;
              if (state.last == i) color = MyColors.orangeAccent;
              return Container(
                width: 15,
                height: 15,
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              );
            },
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: PageView.builder(
              onPageChanged: (pageIndex) =>
                  bloc.add(PageChangeEvent(pageIndex: pageIndex)),
              itemCount: state.pageList.length,
              physics: BouncingScrollPhysics(),
              controller: pageController,
              itemBuilder: (context, i) {
                return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 40, right: 40),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/img_page_background.png")),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(flex: 3, child: SizedBox()),
                        Text(
                          "${state.pageList[i].lessonIdString}",
                          style: TextStyle(
                            fontSize: 22,
                            color: MyColors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: Text(
                            "${state.pageList[i].lessonName}",
                            style: TextStyle(
                              fontSize: 16,
                              color: MyColors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: state.pageList[i].word != null
                                ? [
                                    Image.asset(
                                      "assets/img_main_progress_${state.pageList[i].word ? "" : "in"}active.png",
                                    ),
                                    Image.asset(
                                      "assets/img_main_progress_${state.pageList[i].rule ? "" : "in"}active.png",
                                    ),
                                    Image.asset(
                                      "assets/img_main_progress_${state.pageList[i].exercise ? "" : "in"}active.png",
                                    ),
                                  ]
                                : [
                                    state.pageList[i].dialog != null
                                        ? Image.asset(
                                            "assets/img_main_progress_${state.pageList[i].dialog ? "" : "in"}active.png",
                                          )
                                        : Image.asset(
                                            "assets/img_main_progress_${state.pageList[i].exam ? "" : "in"}active.png",
                                          )
                                  ],
                          ),
                        ),
                        SizedBox(height: 20),
                        WButton(
                          width: 100,
                          height: 30,
                          text: "Tanlash",
                          color: MyColors.greyLight,
                          circular: 55,
                          fontSize: 16,
                          textColor: state.pageList[i].enabled
                              ? MyColors.greyDark
                              : MyColors.grey,
                          onPressed: state.pageList[i].enabled
                              ? () {
                                  bloc.add(PageItemPressedEvent(pageIndex: i));
                                  isPaged = false;
                                }
                              : null,
                        ),
                        Expanded(flex: 3, child: SizedBox()),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 100,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 30),
          child: MaterialButton(
            height: 60,
            minWidth: 60,
            padding: EdgeInsets.all(0),
            onPressed: () => bloc.add(LogoutEvent()),
            shape: CircleBorder(),
            child: Icon(Icons.arrow_back_sharp, size: 35),
          ),
        ),
      ],
    );
  }

  Widget widgetFailBody({String message}) {
    return Column(
      children: [
        Expanded(child: SizedBox()),
        Text(message ?? "Xatolik sodir bo'ldi", style: TextStyle(fontSize: 18)),
        Expanded(child: SizedBox()),
        Container(
          width: double.infinity,
          height: 100,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 30),
          child: MaterialButton(
            height: 60,
            minWidth: 60,
            padding: EdgeInsets.all(0),
            onPressed: () => bloc.add(LogoutEvent()),
            shape: CircleBorder(),
            child: Icon(Icons.arrow_back_sharp, size: 35),
          ),
        ),
      ],
    );
  }
}
