import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WExitApp extends StatelessWidget {
  final Key key;
  final String title;
  final String content;
  final String yesText;
  final String noText;
  final Widget child;
  final bool canExit;

  const WExitApp({
    this.key,
    this.title = "Tasdiqlang",
    this.content = "Dasturdan chiqmoqchimisiz?",
    this.yesText = "Ha",
    this.noText = "Yo'q",
    this.child,
    this.canExit = false,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        key: this.key,
        child: this.child,
        onWillPop: () {
          if (this.canExit == true) SystemNavigator.pop();
          return showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(this.title),
                  content: Text(this.content),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(this.yesText),
                      onPressed: () => SystemNavigator.pop(),
                    ),
                    FlatButton(
                      child: Text(this.noText),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                );
              });
        });
  }
}
