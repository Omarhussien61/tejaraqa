import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/pages/register_page.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';
import 'package:shoppingapp/widgets/commons/auth_header.dart';
import 'package:shoppingapp/widgets/login/login_form.dart';

import '../config.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              AuthHeader(
                  headerTitle: getTransrlate(context, 'login'),
                  headerBigTitle: getTransrlate(context, 'New'),
                  isLoginHeader: true),
              SizedBox(
                height: 36,
              ),
              LoginForm(),
              SizedBox(
                height: 8,
              ),
              routeRegisterWidget(themeColor, context),

            ],
          ),
        ),
      ),
    );
  }
  routeRegisterWidget(ThemeNotifier themeColor, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 42, left: 42, bottom: 12),
      child: Row(
        children: <Widget>[
          Text(
            getTransrlate(context, 'haveanaccount'),
            style: GoogleFonts.cairo(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w200,
            ),
          ),
          FlatButton(
            child: Text(
              getTransrlate(context, 'Register'),
              style: GoogleFonts.cairo(
                fontSize: 14,
                color: themeColor.getColor(),
                fontWeight: FontWeight.w300,
              ),
            ),
            onPressed: () {
              Nav.route(context, RegisterPage());
            },
          )
        ],
      ),
    );
  }

}
