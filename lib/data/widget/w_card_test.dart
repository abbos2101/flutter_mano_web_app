import 'package:flutter/material.dart';
import 'widget.dart';

class WCardTest extends StatelessWidget {
  final Key key;
  final String title;
  final String question;
  final Function onPressedTrue;
  final Function onPressedFalse;
  final Color colorTrue;
  final Color colorFalse;
  final double height;
  final double width;
  final bool enableButton;
  final EdgeInsets margin;
  final EdgeInsets padding;

  WCardTest({
    this.key,
    this.title = "Gap to'g'ri tuzulganmi?",
    this.question = "Savol",
    this.colorTrue = Colors.green,
    this.height = 300,
    this.width = double.infinity,
    this.colorFalse = Colors.red,
    this.onPressedTrue,
    this.onPressedFalse,
    this.enableButton = true,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) => _widgetCardCustom();

  Widget _widgetCardCustom() {
    return Stack(children: <Widget>[
      Container(
        key: key,
        width: width,
        height: height * 0.48,
        margin: margin ?? EdgeInsets.only(left: 20, right: 20),
        padding: padding,
        decoration: _viewBoxDecoration,
        child: Column(children: [
          SizedBox(height: 20),
          Text(title, style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          Divider(thickness: 2, color: Colors.black),
          Expanded(
            child: Center(
              child: Text(
                question,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Expanded(
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Expanded(
                  child: _viewButton(
                    enableButton: enableButton,
                    color: colorTrue,
                    text: "To'g'ri",
                    onPressed: onPressedTrue,
                  ),
                ),
                Expanded(
                    child: _viewButton(
                  enableButton: enableButton,
                  color: colorFalse,
                  text: "Noto'g'ri",
                  onPressed: onPressedFalse,
                ))
              ]))
        ]),
      ),
      _viewFolderIcon(),
    ]);
  }

  Widget _viewButton({
    Color color = Colors.yellow,
    Function onPressed,
    EdgeInsets margin,
    double circular = 0,
    bool enableButton = true,
    String text = "",
  }) =>
      WButton(
        circular: circular,
        height: height * 0.08,
        enable: enableButton,
        margin: margin ?? EdgeInsets.all(10),
        color: color,
        onPressed: onPressed,
        child: Text(
          "$text",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  Widget _viewFolderIcon({
    IconData iconData = Icons.folder,
    Color iconColor = Colors.orangeAccent,
  }) {
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(top: height * 0.42),
      child: Icon(iconData, color: iconColor, size: height * 0.12),
    );
  }

  BoxDecoration _viewBoxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.15),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 1),
      ),
    ],
  );
}
