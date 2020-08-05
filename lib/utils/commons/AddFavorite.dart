// ignore: file_names

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


Future<bool> Favorite(ProductModel productModel) async {
  print(productModel.categories[0].name);

  favorite_sql helper = favorite_sql();
String price=(parse(productModel.priceHtml
    .toString()
    .trim())
    .body
    .text
    .trim()
    .length >
    0 ||
    productModel.price
        .toString()
        .trim() ==
        '')
    ? parse(productModel.priceHtml
    .toString()
    .trim())
    .body
    .text
    .trim()
    : "Best";
  FavoriteModel favorite= new FavoriteModel(  productModel.id,productModel.name, productModel.categories[0].name, price,
      productModel.images[0].src);
  int result;
  if (await helper.checkItem(favorite.id) == true) {
    result =  await helper.insertAddress(favorite);
    print('insertAddress');
    return true;
  } else {
    result=await helper.deleteAddress(favorite.id);
    print('deleteAddress');
    return false;
  }


}

Future<bool> FavoritecheckItem(ProductModel productModel) async {

  favorite_sql helper = favorite_sql();

  if (await helper.checkItem(productModel.id) == true) {
    return true;
  } else {
    return false;
  }


}
void showLogintDialog(String title, String msg,BuildContext context){
  Alert(
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




