import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/modal/Theme.dart';

class counter with ChangeNotifier {
  int theme_index = 1;

  String local = 'ar';
  Color color;
  ThemeModel themeModel;


  setTheme(ThemeModel Model) {
    themeModel = Model;
    notifyListeners();
  }


  intcnt(int st) {
    theme_index = st;
    if (theme_index == 1) {
      setColor(Color(int.parse(themeModel.primaryCoustom)));
    } else if (theme_index == 2) {
      setColor(Colors.blueAccent);
    }
    else {
      setColor(Colors.amber);
    }
    notifyListeners();
  }

  setLocal(String st) {
    local = st;
    notifyListeners();
  }

  setColor(Color c) {
    color = c;

    notifyListeners();
  }
}
