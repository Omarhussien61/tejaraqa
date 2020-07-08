import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

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
      backgroundColor: Provider.of<ThemeNotifier>(context).getColor(),
      body: Center(
        child: Container(
          height: 400,
          width: ScreenUtil.getWidth(context) /1.7,
          child: CachedNetworkImage(
            imageUrl:  Provider.of<ThemeNotifier>(context).themeModel==null?
            '':Provider.of<ThemeNotifier>(context).themeModel.imageSplash,
          ),
        ),
      ),
    );
  }
  void _auth() async {
    MyApp.setlocal(context, Locale(Provider.of<ThemeNotifier>(context).local,''));

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (null != prefs.getString("token")) {
      Provider.of<ThemeNotifier>(context).setLogin(true);
      Nav.routeReplacement(context, InitPage());
    } else {
      Provider.of<ThemeNotifier>(context).setLogin(false);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => OnboardingPage()));
    }
  }
}
