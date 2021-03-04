import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final Widget child;

  const HomeScreen({this.child});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final double childWidth = width > height ? height * 0.5 : width;
    final double childHeight = width > height ? height : width * 2;

    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Center(
        child: SizedBox(
          width: childWidth,
          height: childHeight,
          child: this.child,
        ),
      ),
    );
  }
}
