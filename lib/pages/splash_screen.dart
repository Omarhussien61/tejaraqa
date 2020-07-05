import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingapp/Provider/counter.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';

import '../config.dart';
import '../main.dart';
import 'onboarding_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () =>_auth()
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: mainColor,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Container(
          height: 400,
          width: ScreenUtil.getWidth(context) /1.7,
          child: Image.asset('assets/images/rosen.png'),
        ),
      ),
    );
  }
  void _auth() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (null != prefs.getString("token")) {
      Provider.of<counter>(context).setLogin(true);
      Nav.routeReplacement(context, InitPage());
    } else {
      Provider.of<counter>(context).setLogin(false);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => OnboardingPage()));
    }
  }
}
