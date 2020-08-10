// ignore: file_names

import 'package:html/parser.dart';

import 'package:shoppingapp/modal/Favorite.dart';
import 'package:shoppingapp/modal/productmodel.dart';

import 'package:shoppingapp/utils/util/sql_favorite.dart';


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




