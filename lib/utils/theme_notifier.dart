import 'package:flutter/material.dart';
import 'package:shoppingapp/modal/Theme.dart';

class ThemeNotifier with ChangeNotifier {
  Color _themeData;
  String local ;
  String Currancy ='';
  Color color;
  ThemeModel themeModel;
  int theme_index = 1;
  int countCart = 1;
  bool isLogin = false;

  ThemeNotifier(this._themeData);

  getColor() => _themeData;
  getlocal() => local;

  setColor(Color themeData) async {
    _themeData = themeData;
    notifyListeners();
  }

  setLogin( bool isLog) {
    isLogin = isLog;
    notifyListeners();
  }


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

  intcountCart(int st) {
    countCart = st;
    notifyListeners();
  }

  setLocal(String st) {
    local = st;
    notifyListeners();
  }
  setCurrancy(String currancy) {
    Currancy = currancy;
    notifyListeners();
  }


}
