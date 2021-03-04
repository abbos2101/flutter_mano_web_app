import 'package:flutter/material.dart';
import 'package:polygon_clipper/polygon_border.dart';

class WButtonShape extends StatelessWidget {
  final Key key;
  final Function onPressed;
  final int sides;
  final double size;
  final double width;
  final double height;
  final double rotate;
  final EdgeInsets margin;
  final Color color;
  final bool active;
  final double borderWidth;
  final Widget child;
  final bool showShadow;

  WButtonShape({
    this.key,
    this.onPressed,
    this.sides = 6,
    this.size = 35,
    this.width,
    this.height,
    this.rotate = 90,
    this.margin,
    this.color = Colors.orangeAccent,
    this.active = false,
    this.borderWidth,
    this.child,
    this.showShadow = false,
  });

  @override
  Widget build(BuildContext context) => _viewShape();

  Widget _viewShape() => Container(
        width: width,
        height: height ?? size,
        margin: margin,
        decoration: showShadow == true
            ? BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 30,
                  ),
                ],
              )
            : BoxDecoration(),
        child: MaterialButton(
          padding: EdgeInsets.all(0),
          child: child,
          shape: PolygonBorder(
            sides: sides,
            rotate: rotate,
            border: BorderSide(width: borderWidth ?? size / 15, color: color),
          ),
          color: active == true ? color.withOpacity(0.4) : Colors.white,
          disabledColor: active == true ? color.withOpacity(0.4) : Colors.white,
          onPressed: onPressed,
          highlightColor: color.withOpacity(0.3),
          splashColor: color.withOpacity(0.3),
        ),
      );
}
