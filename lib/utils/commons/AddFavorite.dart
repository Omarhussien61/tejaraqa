// ignore: file_names

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/modal/cart.dart';
import 'package:shoppingapp/modal/Favorite.dart';
import 'package:shoppingapp/modal/productmodel.dart';
import 'package:shoppingapp/utils/util/sql_favorite.dart';
import 'package:shoppingapp/utils/util/sql_helper.dart';

import '../theme_notifier.dart';


Future<bool> Favorite(ProductModel productModel) async {
  print('insa');

  favorite_sql helper = favorite_sql();
  double myInt = await double.parse(productModel.price);
  myInt=num.parse(myInt.toStringAsFixed(2));
  FavoriteModel favorite= new FavoriteModel(  productModel.id,productModel.name, productModel.categories[0].name, myInt,
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




