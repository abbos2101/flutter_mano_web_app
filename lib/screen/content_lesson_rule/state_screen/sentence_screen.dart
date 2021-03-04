import 'package:flutter/material.dart';
import 'package:flutter_resume_app/data/imp/list.dart';
import 'package:flutter_resume_app/data/util/colors.dart';
import 'package:flutter_resume_app/data/widget/widget.dart';
import '../bloc/content_rule_bloc.dart';

class RuleSentenceScreen extends StatefulWidget {
  static MaterialPageRoute route({
    @required SentenceState sentenceState,
    @required ContentRuleBlocImp contentRuleBlocImp,
  }) =>
      MaterialPageRoute(
        builder: (_) => screen(
          sentenceState: sentenceState,
          contentRuleBlocImp: contentRuleBlocImp,
        ),
      );

  static Widget screen({
    @required SentenceState sentenceState,
    @required ContentRuleBlocImp contentRuleBlocImp,
  }) =>
      RuleSentenceScreen(sentenceState, contentRuleBlocImp);

  final SentenceState state;
  final ContentRuleBlocImp imp;

  const RuleSentenceScreen(this.state, this.imp);

  @override
  _RuleSentenceScreenState createState() => _RuleSentenceScreenState();
}

class _RuleSentenceScreenState extends State<RuleSentenceScreen>
    implements WGridViewImp {
  String question = '';
  String name = '';
  List<String> selectWords = [];
  List<String> wordList = [];
  bool answer;
  bool isCheck = true;

  @override
  void initState() {
    name = widget.state.name;
    question = widget.state.itemUz;
    wordList = shuffle(widget.state.itemRu.trim().split(RegExp(r" +")));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.greyLight,
      body: widgetBody(
        selectedList: selectWords,
        wordList: wordList,
        question: question,
        isCheck: isCheck,
        answer: answer,
        onPressedPlay: widget.state.itemSoundId == null
            ? null
            : () => widget.imp.onPlayAudio(widget.state.itemSoundId),
        onPressedNext: () => widget.imp.onPressedNextButton(
          ruleId: widget.state.ruleId,
          answer: answer,
        ),
        onPressedCheck: () {
          String text = "";
          selectWords.forEach((it) => text += "${it.trim()} ");
          answer = text.trim() == widget.state.itemRu;
          isCheck = false;
          setState(() {});
        },
      ),
    );
  }

  Widget widgetBody({
    String question,
    List<String> selectedList,
    List<String> wordList,
    Function onPressedCheck,
    Function onPressedNext,
    Function onPressedPlay,
    bool answer = false,
    bool isCheck = true,
  }) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: MyColors.orangeAccent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              '$name',
              style: TextStyle(color: MyColors.black, fontSize: 18),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              "Jumlani yig'ing",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 20, top: 5, left: 5, right: 5),
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Text("$question", style: TextStyle(fontSize: 16)),
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/img_content_example.png"),
              fit: BoxFit.fill,
            )),
          ),
          WGridView(
            width: MediaQuery.of(context).size.width,
            height: 200,
            list: selectedList,
            rowCount: 3,
            viewImp: this,
          ),
          Expanded(child: SizedBox()),
          SizedBox(
            height: 40,
            child: isCheck == false
                ? SizedBox()
                : ListView.builder(
                    itemCount: wordList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => widgetItem(
                      word: wordList[index],
                      index: index,
                      isSelected: false,
                    ),
                  ),
          ),
          Expanded(
              child: isCheck
                  ? SizedBox()
                  : WCardVoice(
                      answer: answer,
                      text: answer ? "" : widget.state.itemRu,
                      circular: 25,
                      onPressed: onPressedPlay,
                      margin: EdgeInsets.all(20),
                    )),
          Align(
            alignment: Alignment.center,
            child: isCheck
                ? WButton(
                    width: 200,
                    height: 55,
                    circular: 55,
                    onPressed: selectWords.isEmpty ? null : onPressedCheck,
                    color: selectWords.isNotEmpty ? null : MyColors.greyLight,
                    text: "Tekshirish",
                    textBold: true,
                    textColor: Colors.black,
                    margin: EdgeInsets.only(bottom: 30),
                  )
                : WButton(
                    width: 200,
                    height: 55,
                    circular: 55,
                    onPressed: onPressedNext,
                    text: "Keyingisi",
                    textBold: true,
                    textColor: Colors.black,
                    margin: EdgeInsets.only(bottom: 30),
                  ),
          ),
        ],
      ),
    );
  }

  Widget widgetItem({String word, int index, bool isSelected = true}) {
    Function onPressed;
    if (isSelected)
      onPressed = () {
        for (int i = 0; i < wordList.length; i++)
          if (wordList[i] == "_${selectWords[index]}") {
            wordList[i] = wordList[i].substring(1);
            break;
          }
        selectWords.removeAt(index);
        setState(() {});
      };
    else
      onPressed = () {
        if (wordList[index][0] == '_') return;
        selectWords.add(wordList[index]);
        wordList[index] = "_${wordList[index]}";
        setState(() {});
      };
    if (word[0] == '_')
      return WButton(
        text: '',
        onPressed: onPressed,
        color: Colors.grey[200],
        width: 100,
        fontSize: 12,
        margin: EdgeInsets.all(1),
      );
    return WButton(
      text: word,
      width: 100,
      onPressed: onPressed,
      fontSize: 12,
      margin: EdgeInsets.all(1),
    );
  }

  @override
  void onChangedList(List<String> list) => setState(() => selectWords = list);

  @override
  void onItemClick(int index) {
    setState(() {
      for (int i = 0; i < wordList.length; i++)
        if (wordList[i] == "_${selectWords[index]}") {
          wordList[i] = wordList[i].substring(1);
          break;
        }
      selectWords.removeAt(index);
    });
  }
}
