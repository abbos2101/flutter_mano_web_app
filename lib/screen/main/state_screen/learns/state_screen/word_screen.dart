import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_resume_app/data/model/lesson/word_client_model.dart';
import 'package:flutter_resume_app/data/net/audio_service.dart';
import 'package:flutter_resume_app/data/widget/widget.dart';
import 'package:flutter_resume_app/di/locator.dart';

class WordScreen extends StatefulWidget {
  static Widget screen({WordClientModel clientModel}) =>
      WordScreen(clientModel);

  final WordClientModel clientModel;

  const WordScreen(this.clientModel);

  @override
  _WordScreenState createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  final AudioService audioService = locator.get<AudioService>();

  final ScrollController studiedController = ScrollController();
  final ScrollController onStudiedController = ScrollController();

  final List<ItemWordClient> studiedList = [];
  final List<ItemWordClient> onStudiedList = [];

  final int INDEX_ON_STUDY = 0;
  final int INDEX_STUDY = 1;

  int index;
  int studiedIndex = -1;
  int onStudiedIndex = -1;

  @override
  void initState() {
    index = INDEX_ON_STUDY;
    studiedList.addAll(widget.clientModel.studied);
    onStudiedList.addAll(widget.clientModel.onStudied);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WButton(
                height: 40,
                circular: 20,
                margin: EdgeInsets.all(5),
                text: "O'rganaman ${onStudiedList.length}",
                color: index == INDEX_ON_STUDY
                    ? Colors.orangeAccent
                    : Colors.grey[200],
                textColor:
                    index == INDEX_ON_STUDY ? Colors.white : Colors.black,
                onPressed: () => setState(() => index = INDEX_ON_STUDY),
              ),
              WButton(
                height: 40,
                circular: 20,
                margin: EdgeInsets.all(5),
                text: "O'rgandim ${studiedList.length}",
                color: index == INDEX_STUDY
                    ? Colors.orangeAccent
                    : Colors.grey[200],
                textColor: index == INDEX_STUDY ? Colors.white : Colors.black,
                onPressed: () => setState(() => index = INDEX_STUDY),
              ),
            ],
          ),
          Expanded(
            child: index != 0
                ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                    controller: studiedController,
                    itemCount: studiedList.length,
                    itemBuilder: (context, index) =>
                        widgetItemStudied(itemIndex: index),
                  )
                : ListView.builder(
                    physics: BouncingScrollPhysics(),
                    controller: onStudiedController,
                    itemCount: onStudiedList.length,
                    itemBuilder: (context, index) =>
                        widgetItemOnStudied(itemIndex: index),
                  ),
          ),
        ],
      ),
    );
  }

  Widget widgetItemOnStudied({int itemIndex}) {
    ItemWordClient model = onStudiedList[itemIndex];
    if (onStudiedIndex != itemIndex)
      return Container(
        width: double.infinity,
        height: 80,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            SizedBox(width: 5),
            MaterialButton(
              height: 45,
              minWidth: 45,
              onPressed: () {
                if ((model.soundName ?? "").isEmpty) return;
                audioService.onPlayAudio(name: model.soundName);
              },
              color: Colors.grey[100],
              shape: CircleBorder(),
              child: Icon(Icons.volume_up,
                  color: (model.soundName ?? "").isEmpty
                      ? Colors.redAccent
                      : Colors.orangeAccent),
            ),
            SizedBox(width: 5),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.ru,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                RatingBar(
                  itemCount: 3,
                  itemSize: 12,
                  maxRating: 3,
                  initialRating: model.count.toDouble(),
                  ratingWidget: RatingWidget(
                    full: Icon(Icons.star, color: Colors.grey),
                    empty: Icon(Icons.star_border, color: Colors.grey),
                    half: Icon(Icons.star_half, color: Colors.grey),
                  ),
                )
              ],
            )),
            MaterialButton(
              height: 45,
              minWidth: 45,
              onPressed: () => setState(() => onStudiedIndex = itemIndex),
              color: Colors.grey[100],
              shape: CircleBorder(),
              child: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            ),
            SizedBox(width: 5),
          ],
        ),
      );
    return Container(
      width: double.infinity,
      height: 220,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 5),
          MaterialButton(
            height: 45,
            minWidth: 45,
            onPressed: () {
              if ((model.soundName ?? "").isEmpty) return;
              audioService.onPlayAudio(name: model.soundName);
            },
            color: Colors.grey[100],
            shape: CircleBorder(),
            child: Icon(Icons.volume_up,
                color: (model.soundName ?? "").isEmpty
                    ? Colors.redAccent
                    : Colors.orangeAccent),
          ),
          SizedBox(width: 5),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Text(
                model.ru,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              RatingBar(
                itemCount: 3,
                itemSize: 12,
                maxRating: 3,
                initialRating: model.count.toDouble(),
                ratingWidget: RatingWidget(
                  full: Icon(Icons.star, color: Colors.grey),
                  empty: Icon(Icons.star_border, color: Colors.grey),
                  half: Icon(Icons.star_half, color: Colors.grey),
                ),
              ),
              Text(model.uz),
              Expanded(
                child: Container(
                    margin: EdgeInsets.only(bottom: 5, top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: (model.imageName ?? "").isNotEmpty
                            ? NetworkImage(
                                'http://185.16.40.113:8080/api/download/image/${model.imageName}',
                              )
                            : AssetImage(
                                'assets/error_gif/img${model.ru.length % 5 + 1}.gif',
                              ),
                        fit: BoxFit.fill,
                      ),
                    )),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(model.example),
              ),
            ],
          )),
          MaterialButton(
            height: 45,
            minWidth: 45,
            onPressed: () => setState(() => onStudiedIndex = -1),
            color: Colors.grey[100],
            shape: CircleBorder(),
            child: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          ),
          SizedBox(width: 5),
        ],
      ),
    );
  }

  Widget widgetItemStudied({int itemIndex}) {
    ItemWordClient model = studiedList[itemIndex];
    if (studiedIndex != itemIndex)
      return Container(
        width: double.infinity,
        height: 80,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            SizedBox(width: 5),
            MaterialButton(
              height: 45,
              minWidth: 45,
              onPressed: () {
                if ((model.soundName ?? "").isEmpty) return;
                audioService.onPlayAudio(name: model.soundName);
              },
              color: Colors.grey[100],
              shape: CircleBorder(),
              child: Icon(Icons.volume_up,
                  color: (model.soundName ?? "").isEmpty
                      ? Colors.redAccent
                      : Colors.orangeAccent),
            ),
            SizedBox(width: 5),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.ru,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.check, color: Colors.green, size: 15),
              ],
            )),
            MaterialButton(
              height: 45,
              minWidth: 45,
              onPressed: () => setState(() => studiedIndex = itemIndex),
              color: Colors.grey[100],
              shape: CircleBorder(),
              child: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            ),
            SizedBox(width: 5),
          ],
        ),
      );
    return Container(
      width: double.infinity,
      height: 220,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 5),
          MaterialButton(
            height: 45,
            minWidth: 45,
            onPressed: () {
              if ((model.soundName ?? "").isEmpty) return;
              audioService.onPlayAudio(name: model.soundName);
            },
            color: Colors.grey[100],
            shape: CircleBorder(),
            child: Icon(Icons.volume_up,
                color: (model.soundName ?? "").isEmpty
                    ? Colors.redAccent
                    : Colors.orangeAccent),
          ),
          SizedBox(width: 5),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Text(
                model.ru,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.check, color: Colors.green, size: 15),
              Text(model.uz),
              Expanded(
                child: Container(
                    margin: EdgeInsets.only(bottom: 5, top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: (model.imageName ?? "").isNotEmpty
                            ? NetworkImage(
                                'http://185.16.40.113:8080/api/download/image/${model.imageName}',
                              )
                            : AssetImage(
                                'assets/error_gif/img${model.ru.length % 5 + 1}.gif',
                              ),
                        fit: BoxFit.fill,
                      ),
                    )),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(model.example),
              ),
            ],
          )),
          MaterialButton(
            height: 45,
            minWidth: 45,
            onPressed: () => setState(() => studiedIndex = -1),
            color: Colors.grey[100],
            shape: CircleBorder(),
            child: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          ),
          SizedBox(width: 5),
        ],
      ),
    );
  }
}
