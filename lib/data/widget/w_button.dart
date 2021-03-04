import 'package:flutter/material.dart';

class WButton extends StatelessWidget {
  final Key key;
  final double fontSize;
  final double width;
  final double height;
  final double circular;
  final String text;
  final Function onPressed;
  final Color color;
  final Color shadowColor;
  final Color textColor;
  final Widget child;
  final bool textBold;
  final EdgeInsets margin;
  final bool shadow;
  final bool enable;
  final Border border;

  WButton({
    this.key,
    this.fontSize = 14,
    this.width = 150,
    this.height = 50,
    this.circular = 0,
    this.text = "OK",
    this.onPressed,
    this.color,
    this.shadowColor,
    this.textColor = Colors.white,
    this.child,
    this.textBold = false,
    this.margin,
    this.shadow = true,
    this.enable = true,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: this.key,
      margin: this.margin,
      width: this.width,
      height: this.height,
      decoration: BoxDecoration(
        color: (this.color ?? Theme.of(context).primaryColor).withOpacity(
          this.enable ? 1 : 0.7,
        ),
        border: this.border,
        borderRadius: BorderRadius.circular(this.circular),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(255, 255, 255, 1),
            blurRadius: 4,
            offset: Offset(-4, -4),
          ),
          BoxShadow(
            color: Color.fromRGBO(170, 170, 204, 0.25),
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
          BoxShadow(
            color: Color.fromRGBO(170, 170, 204, 0.5),
            blurRadius: 8,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: MaterialButton(
          onPressed: this.enable ? onPressed : null,
          child: this.child ??
              Text(
                this.text,
                style: TextStyle(
                  color: this.textColor,
                  fontSize: this.fontSize,
                  fontWeight:
                      this.textBold ? FontWeight.bold : FontWeight.normal,
                ),
              ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(this.circular),
          )),
    );
  }
}
