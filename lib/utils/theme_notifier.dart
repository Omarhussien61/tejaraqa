import 'package:flutter/material.dart';
import 'package:shoppingapp/modal/Config_Model.dart';
import 'package:shoppingapp/modal/Theme.dart';

class ThemeNotifier with ChangeNotifier {
  Color _themeData;
  String local ;
  String Currancy ='';
  Color color;
  ThemeModel themeModel;
  int Plan_index = 1;
  int countCart = 1;
  bool isLogin = false;
  Config_Model config_model;
  ThemeNotifier(this._themeData);

  getColor() => _themeData;
  getlocal() => local;
  getPlan_index() => Plan_index;

  setColor(Color themeData) async {
    _themeData = themeData;
    notifyListeners();
  }

  setLogin( bool isLog) {
    isLogin = isLog;
    notifyListeners();
  }

  setConfig_model(Config_Model config) {
    config_model = config;
    notifyListeners();
  }
  setTheme(ThemeModel Model) {
    themeModel = Model;
    notifyListeners();
  }

  intcnt(int st) {
    Plan_index = st;
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
