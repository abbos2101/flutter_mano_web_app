import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  final int BOTTOM_MENU_LESSON = 0;
  final int BOTTOM_MENU_LEARN = 1;
  final int BOTTOM_MENU_SAVED = 2;
  final int BOTTOM_MENU_SETTINGS = 2;

  bool isLoading;
  int bottomMenuIndex = 0;

  void onChangedBottomMenu(int index) {
    bottomMenuIndex = index;
    notifyListeners();
  }
}
