import 'package:flutter/material.dart';

class WTextField extends StatelessWidget {
  final Key key;
  final TextStyle style;
  final int maxLines;
  final TextAlign textAlign;
  final TextEditingController controller;
  final bool obscureText;
  final bool readOnly;
  final String hint;
  final EdgeInsets contentPadding;
  final Function onChanged;
  final TextCapitalization textCapitalization;

  const WTextField({
    this.key,
    this.style,
    this.maxLines,
    this.textAlign = TextAlign.start,
    this.controller,
    this.obscureText = false,
    this.readOnly = false,
    this.hint = "",
    this.contentPadding,
    this.onChanged,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) => _widgetTextField();

  Widget _widgetTextField() => TextField(
      key: key,
      style: style,
      maxLines: obscureText == false ? maxLines : 1,
      textAlign: textAlign,
      readOnly: readOnly,
      textCapitalization: textCapitalization,
      onChanged: (value) {
        if (onChanged != null) onChanged(value);
      },
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        filled: true,
        hintText: hint,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.orangeAccent, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Color.fromRGBO(196, 195, 200, 1),
            width: 1.0,
          ),
        ),
        border: OutlineInputBorder(),
        contentPadding: contentPadding ?? EdgeInsets.only(left: 10, right: 10),
      ));
}
