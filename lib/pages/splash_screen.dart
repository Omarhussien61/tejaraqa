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
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        MyApp.setlocal(context, Locale(Provider.of<ThemeNotifier>(context).local,'')));

    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Provider.of<ThemeNotifier>(context).config_model!=null?
        Provider.of<ThemeNotifier>(context).config_model.active? _auth():null:null
    );
  }

  @override
  Widget build(BuildContext context) {
    final themecolor=Provider.of<ThemeNotifier>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: themecolor.getColor(),
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    return Scaffold(
      backgroundColor: Provider.of<ThemeNotifier>(context).getColor(),
      body:themecolor.config_model!=null? themecolor.config_model.active?Center(
        child: Container(
          height: 400,
          width: ScreenUtil.getWidth(context) /1.7,
          child: CachedNetworkImage(
            imageUrl:  Provider.of<ThemeNotifier>(context).themeModel==null?
            '':Provider.of<ThemeNotifier>(context).themeModel.imageSplash,
          ),
        ),
      ):
      Center(
          child: Container(
              height: ScreenUtil.getHeight(context),
            color: Colors.white,
              child: Image.asset(
                'assets/images/not_found_smile.PNG',
              ),
          )):Container(),
    );
  }
  void _auth() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (null != prefs.getString("token")) {
      Provider.of<ThemeNotifier>(context).setLogin(true);
    } else {

      Provider.of<ThemeNotifier>(context).setLogin(false);

    }
    if (null != prefs.getString("instance")) {
      Nav.routeReplacement(context, InitPage());
    } else {

      Provider.of<ThemeNotifier>(context).setLogin(false);
      if(Provider.of<ThemeNotifier>(context).config_model.startScreen){
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => OnboardingPage()));}
      else{
        Nav.routeReplacement(context, InitPage());
      }
    }
  }
}
