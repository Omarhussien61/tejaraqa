
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/modal/cart.dart';
import 'package:shoppingapp/modal/productmodel.dart';
import 'package:shoppingapp/utils/util/sql_helper.dart';

import '../theme_notifier.dart';

void save(ProductModel productModel) async {
  SQL_Helper helper = new SQL_Helper();

  double myInt = await double.parse(productModel.price);
  myInt=num.parse(myInt.toStringAsFixed(2));
  Cart cart= new Cart(await productModel.id, productModel.name, 1, myInt,
      DateFormat.yMMMd().format(DateTime.now()),productModel.images[0].src);
  int result;
  if (await helper.checkItem(cart.id) == true) {
    result =  await helper.insertCart(cart);
  } else {
    result = await helper.updateCart(cart);
  }
  if (result == 0) {

  } else {

  }
}

void countCart(BuildContext context) async {
  SQL_Helper helper = new SQL_Helper();
  helper.getCount().then((value) {
    Provider.of<ThemeNotifier>(context).intcountCart(value);
  });

}



