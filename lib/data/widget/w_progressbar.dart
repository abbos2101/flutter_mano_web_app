import 'package:flutter/material.dart';
import 'package:polygon_clipper/polygon_border.dart';
import 'widget.dart';

class WProgressBar extends StatelessWidget {
  final Key key;
  final double itemSize;
  final int index;
  final Color colorActive;
  final Color colorPassive;
  final Color colorTrue;
  final Color colorFalse;
  final List<int> anwers;

  WProgressBar({
    this.key,
    this.itemSize = 35,
    this.index = 0,
    this.colorActive,
    this.colorPassive,
    this.colorTrue,
    this.colorFalse,
    @required this.anwers,
  });

  @override
  Widget build(BuildContext context) {
    return (anwers != null && anwers.length != 0)
        ? widgetProgressbar()
        : WLoading(key: key);
  }

  Widget widgetProgressbar() => Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: Stack(
          children: _viewItemsList(
            itemSize: itemSize,
            index: index,
            colorActive: colorActive ?? Colors.orangeAccent,
            colorPassive: colorPassive ?? Colors.grey[300],
            colorTrue: colorTrue ?? Colors.green[400],
            colorFalse: colorFalse ?? Colors.red[400],
            answers: anwers,
          ),
        ),
      );

  Widget _viewShape({
    Color color = Colors.lightGreen,
    EdgeInsets margin,
    double size = 35,
  }) =>
      Container(
        height: size,
        margin: margin,
        child: MaterialButton(
          shape: PolygonBorder(
            sides: 6,
            rotate: 90.0,
            border: BorderSide(width: 6, color: color),
          ),
          color: color.withOpacity(0.5),
          disabledColor: color.withOpacity(0.5),
        ),
      );

  List<Widget> _viewItemsList({
    double itemSize = 35,
    int index = 0,
    Color colorActive = Colors.green,
    Color colorPassive = Colors.grey,
    Color colorTrue = Colors.green,
    Color colorFalse = Colors.red,
    List<int> answers,
  }) {
    List<Widget> tmp = [];
    for (int i = 0; i < answers.length; i++) {
      Color borderColor = colorPassive;
      if (i > index)
        borderColor = colorPassive;
      else if (i == index)
        borderColor = colorActive;
      else if (i < index) {
        if (answers[i] == -1)
          borderColor = colorFalse;
        else if (answers[i] == 0)
          borderColor = colorPassive;
        else if (answers[i] == 1) borderColor = colorTrue;
      }
      tmp.add(
        _viewShape(
          color: borderColor,
          size: itemSize,
          margin: EdgeInsets.only(
              top: i % 2 == 0 ? 0 : itemSize * 0.5, left: i * itemSize * 0.85),
        ),
      );
    }
    return tmp;
  }
}
