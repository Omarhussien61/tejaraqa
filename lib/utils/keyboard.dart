import 'package:flutter/material.dart';

class KeyboardUtil {
  static bool isKeyboardShowing(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0.0;
  }
}
