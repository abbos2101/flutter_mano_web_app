import 'package:flutter/material.dart';

mixin WGridViewImp {
  void onItemClick(int index);

  void onChangedList(List<String> list);
}

class WGridView extends StatelessWidget {
  final double width;
  final double height;
  final List<String> list;
  final WGridViewImp viewImp;
  final int rowCount;
  final double space;
  final double itemWidthByElement;
  final double itemHeight;
  final bool itemCenter;

  WGridView({
    @required this.width,
    @required this.height,
    @required this.list,
    @required this.viewImp,
    this.itemWidthByElement = 15,
    this.itemHeight = 40,
    this.rowCount = 1,
    this.space = 30,
    this.itemCenter = true,
  });

  int dragIndex = -1;
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ListView.builder(
        itemCount: list.length ~/ rowCount + 1,
        itemBuilder: (context, i) => Container(
          height: itemHeight + 5,
          width: width,
          alignment: itemCenter ? Alignment.center : Alignment.topLeft,
          margin: EdgeInsets.all(2),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: (list.length ~/ rowCount) != i
                  ? rowCount
                  : list.length % rowCount,
              itemBuilder: (context, j) {
                final int itemIndex = i * rowCount + j;
                return Row(
                  children: [
                    DragTarget(
                      builder: (context, candidateData, rejectedData) =>
                          SizedBox(width: space, height: itemHeight),
                      onWillAccept: (data) => false,
                      onLeave: (data) async {
                        await Future.delayed(Duration(milliseconds: 50));
                        dragIndex = -1;
                      },
                      onMove: (details) => dragIndex = itemIndex,
                    ),
                    Draggable(
                      feedback: _widgetItem(
                        height: itemHeight,
                        shadow: true,
                        text: list[itemIndex],
                      ),
                      child: _widgetItem(
                        height: itemHeight,
                        shadow: true,
                        text: list[itemIndex],
                        onPressed: () => viewImp.onItemClick(itemIndex),
                      ),
                      childWhenDragging: _widgetItem(
                        height: itemHeight,
                        shadow: false,
                        text: list[itemIndex],
                      ),
                      onDragStarted: () => selectedIndex = itemIndex,
                      onDraggableCanceled: (velocity, offset) {
                        if (dragIndex != -1) {
                          list.insert(dragIndex, list[selectedIndex]);
                          list.removeAt(dragIndex > selectedIndex
                              ? selectedIndex
                              : selectedIndex + 1);
                        }
                        viewImp.onChangedList(list);
                        selectedIndex = -1;
                      },
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  Widget _widgetItem({
    double height,
    bool shadow,
    Function onPressed,
    String text,
    double fontSize = 12,
  }) {
    double width = text.length * (text.length < 4 ? 15.0 : 10.0);
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: shadow == false
            ? []
            : [BoxShadow(color: Colors.grey, blurRadius: 5)],
      ),
      child: MaterialButton(
        minWidth: width,
        height: height,
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: onPressed,
        child: Text("$text", style: TextStyle(fontSize: fontSize)),
      ),
    );
  }
}
