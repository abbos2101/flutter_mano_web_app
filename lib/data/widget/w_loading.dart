import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WLoading extends StatelessWidget {
  final Key key;
  final double size;
  final double width;
  final double height;
  final Color color;
  final Color backgroundColor;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final bool visible;

  const WLoading({
    this.key,
    this.size = 50,
    this.width,
    this.height,
    this.color = Colors.orangeAccent,
    this.backgroundColor,
    this.margin,
    this.padding,
    this.visible = true,
  });

  @override
  Widget build(BuildContext context) {
    return this.visible == false
        ? Container(width: width, height: height, color: backgroundColor)
        : Container(
            width: width,
            height: height,
            color: backgroundColor,
            margin: margin ?? EdgeInsets.all(0),
            padding: padding ?? EdgeInsets.all(0),
            child: SpinKitFadingCircle(key: key, color: color, size: size),
          );
  }
}
