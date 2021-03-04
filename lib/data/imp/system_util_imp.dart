import 'package:flutter/services.dart';

class SystemImp {
  static void setStatus({bool visible = false}) {
    SystemChrome.setEnabledSystemUIOverlays(
      visible == false ? [] : SystemUiOverlay.values,
    );
  }
}
