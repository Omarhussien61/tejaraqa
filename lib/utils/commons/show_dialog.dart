
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shoppingapp/modal/cart.dart';
import 'package:shoppingapp/modal/Favorite.dart';
import 'package:shoppingapp/modal/productmodel.dart';
import 'package:shoppingapp/pages/login_page.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';
import 'package:shoppingapp/utils/util/sql_favorite.dart';
import 'package:shoppingapp/utils/util/sql_helper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme_notifier.dart';

void show_Dialog(BuildContext context){
  Alert(
      context: context,
      image: Image.network('https://d2.woo2.app/wp-content/uploads/2020/08/user-3-not-allowed-512-removebg-preview.png'),
      title:getTransrlate(context, 'PleaseUpgrade'),
      content: Form(
        child: Column(
          children: <Widget>[
          ],
        ),
      ),
      buttons: [
        DialogButton(
          color:Colors.red,
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child:Text(getTransrlate(context, 'cancel'),
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400)),
        ),
        DialogButton(
          color:Colors.green,
          onPressed: () {
            _launchURL('https://woo2.app/');
          },
          child:Text(getTransrlate(context, 'login'),
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400),),
        )
      ]).show();
}
void showLogintDialog(String title, String msg,BuildContext context){
  Provider.of<ThemeNotifier>(context).getPlan_index()==1? Alert(
      context: context,
      image: Image.network('https://d2.woo2.app/wp-content/uploads/2020/08/user-3-not-allowed-512-removebg-preview.png'),
      title:getTransrlate(context, 'PleaseUpgrade'),
      content: Form(
        child: Column(
          children: <Widget>[
          ],
        ),
      ),
      buttons: [
        DialogButton(
          color:Colors.red,
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child:Text(getTransrlate(context, 'cancel'),
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400)),
        ),
        DialogButton(
          color:Colors.green,
          onPressed: () {
            _launchURL('https://woo2.app/');
          },
          child:Text(getTransrlate(context, 'login'),
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400),),
        )
      ]).show():Alert(
      context: context,
      image: Image.network('https://www.jmbtechnologies.com/door-login-icon--1.png'),
      title:getTransrlate(context, 'PleaseLogin'),
      content: Form(
        child: Column(
          children: <Widget>[
          ],
        ),
      ),
      buttons: [
        DialogButton(
          color:Colors.red,
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child:Text(getTransrlate(context, 'cancel'),
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400)),
        ),
        DialogButton(
          color:Colors.green,
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return LoginPage();
                });
          },
          child:Text(getTransrlate(context, 'login'),
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400),),
        )
      ]).show();
}
_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}



