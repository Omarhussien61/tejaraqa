// ignore: file_names

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

import '../theme_notifier.dart';

void showPhoneDialog(BuildContext context){
  Alert(
      context: context,
      image: Image.network('https://d2.woo2.app/wp-content/uploads/2020/08/21638066-removebg-preview.png'),
      title:getTransrlate(context, 'PleaseLogin'),
      desc:getTransrlate(context, 'PleaseLogin') ,
      content: Form(
        child: TextField(
          onChanged: (value) {
            //this.smsOTP = value;
          },

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
          child: Text(getTransrlate(context, 'Confirm'),
            style:  TextStyle(
              color: Colors.black,
              fontSize:15,
            ),
          ),
          onPressed: () {
          //  signIn();
          },
        )
      ]).show();

}




