import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume_app/data/widget/widget.dart';
import 'state_screen/word_screen.dart';
import 'state_screen/rule_screen.dart';
import 'bloc/learn_bloc.dart';

class LearnScreen extends StatefulWidget {
  static Widget screen() => BlocProvider(
        create: (context) => LearnBloc(context),
        child: LearnScreen(),
      );

  @override
  _LearnScreenState createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  LearnBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<LearnBloc>(context);
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
    return BlocBuilder<LearnBloc, LearnState>(
      builder: (context, state) => DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: widgetAppBar(state),
          body: widgetBody(state),
        ),
      ),
    );
  }

  Widget widgetAppBar(LearnState state, {Function onTapChanged(int id)}) {
    return AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        bottom: TabBar(
            onTap: onTapChanged == null ? null : (id) => onTapChanged(id),
            indicatorWeight: 5,
            labelColor: Colors.orangeAccent,
            indicatorColor: Colors.orangeAccent,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(icon: Icon(Icons.star), text: "So'zlar"),
              Tab(icon: Icon(Icons.rule), text: "Qoidalar"),
            ]));
  }

  Widget widgetBody(LearnState state) {
    if (state is ResultState)
      return TabBarView(children: [
        WordScreen.screen(clientModel: state.wordClientModel),
        RuleScreen.screen(ruleList: state.ruleList),
      ]);
    return WLoading();
  }
}
