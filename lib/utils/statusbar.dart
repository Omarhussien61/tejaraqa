import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBarConfig {
  static void setStatusbarConfig(
      Color statusbarColor, Brightness statusbarBrightness) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: statusbarColor,
        systemNavigationBarIconBrightness: statusbarBrightness,
        statusBarIconBrightness: statusbarBrightness,
        statusBarBrightness: statusbarBrightness));
  }
}
