import 'dart:async';

import 'package:shoppingapp/modal/Address_shiping.dart';
import 'package:shoppingapp/modal/category.dart';



class Constatnt{

 static Address_shiping address;

 static List<Category> maincat,subcats;


 static bool Cartstaks=false;
 static bool RegisterState=false;

 static bool islogin=false;
 static String username;
 static String email;
 static int id;


 static int contCart;


  static final _themeController = StreamController<bool>();

  static get changeTheme => _themeController.sink.add;

  static get darkThemeEnabled => _themeController.stream;



}