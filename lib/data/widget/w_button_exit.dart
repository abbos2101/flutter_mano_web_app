import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WButtonExit extends StatelessWidget {
  final Key key;
  final IconData icon;
  final double iconSize;
  final Function onPressed;
  final Color color;

  const WButtonExit({
    this.key,
    this.icon,
    this.iconSize = 40,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: iconSize + 10,
      height: iconSize + 10,
      onPressed: onPressed ?? () => Navigator.pop(context),
      padding: EdgeInsets.all(0),
      child: SvgPicture.asset(
        "assets/icon_back.svg",
        width: iconSize,
        height: iconSize,
        color: color,
      ),
      shape: CircleBorder(),
    );
  }
}
