import 'package:flutter/material.dart';
import '../util/colors.dart';

class WCardVoice extends StatelessWidget {
  final Key key;
  final double width;
  final double height;
  final String text;
  final Function onPressed;
  final bool answer;
  final EdgeInsets margin;
  final double circular;

  const WCardVoice({
    this.key,
    this.width,
    this.height,
    this.text = "",
    this.onPressed,
    this.answer = true,
    this.margin,
    this.circular = 0,
  });

  @override
  Widget build(BuildContext context) {
    Color colorTrue = MyColors.green;
    Color colorFalse = MyColors.red;
    String titleTrue = "To'g'ri";
    String titleFalse = "To'g'ri javob";

    return Stack(
      children: <Widget>[
        Container(
          key: key,
          alignment: Alignment.center,
          width: width,
          height: height,
          margin: margin,
          padding: EdgeInsets.all(5),
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Text(
              answer == true ? titleTrue : titleFalse,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: text.length == 0 ? 0 : 18,
                color: Colors.white,
              ),
            ),
          ]),
          decoration: BoxDecoration(
              color: answer == true ? colorTrue : colorFalse,
              borderRadius: BorderRadius.all(Radius.circular(circular))),
        ),
        onPressed == null
            ? Container()
            : Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(top: 20, right: 20),
                child: MaterialButton(
                  minWidth: 50,
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  onPressed: onPressed,
                  //onPressed,
                  child: Icon(
                    Icons.volume_up,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
      ],
    );
  }
}
