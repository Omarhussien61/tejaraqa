
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../modal/cart.dart';
import '../../modal/productmodel.dart';
import '../util/sql_helper.dart';
import '../theme_notifier.dart';


void save(ProductModel productModel,int id,String name,String price,BuildContext context) async {
  SQL_Helper helper = new SQL_Helper();
  double myInt = await double.parse(price==' '?'0':price);
  myInt=num.parse(myInt.toStringAsFixed(2));
  Cart cart= new Cart(  id, name, 1, myInt,
      DateFormat.yMMMd().format(DateTime.now()),productModel.images[0].src,productModel.Currancy);
  int result;
  if (await helper.checkItem(cart.id) == true) {
    result =  await helper.insertCart(cart);
  } else {
    cart=await helper.updateCartCount(cart.id);
    cart.quantity++;
    result = await helper.updateCart(cart);
}
  if (result == 0)
  {

  } else {
    countCart(context);

  }
}

void countCart(BuildContext context) async {
  SQL_Helper helper = new SQL_Helper();
  helper.getCount().then((value) {
    Provider.of<ThemeNotifier>(context).intcountCart(value);
  });

}



