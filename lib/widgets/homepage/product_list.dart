import 'package:flutter/material.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/commons/product_card.dart';
import 'package:shoppingapp/widgets/homepage/product_list_titlebar.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key key,
    @required this.themeColor,
    this.productListTitleBar,
  }) : super(key: key);

  final ThemeNotifier themeColor;
  final ProductListTitleBar productListTitleBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          productListTitleBar,
          Container(
              height: 285.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ProductCard(themeColor: themeColor, imageUrl: "prodcut1.png"),
                  ProductCard(themeColor: themeColor, imageUrl: "prodcut7.png"),
                  ProductCard(themeColor: themeColor, imageUrl: "prodcut8.png"),
                  ProductCard(themeColor: themeColor, imageUrl: "prodcut9.png"),
                  ProductCard(themeColor: themeColor, imageUrl: "prodcut4.png"),
                ],
              )),
          Container(
              height: 285.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ProductCard(themeColor: themeColor, imageUrl: "prodcut1.png"),
                  ProductCard(themeColor: themeColor, imageUrl: "prodcut2.png"),
                  ProductCard(themeColor: themeColor, imageUrl: "prodcut3.png"),
                  ProductCard(themeColor: themeColor, imageUrl: "prodcut4.png"),
                  ProductCard(themeColor: themeColor, imageUrl: "prodcut5.png"),
                ],
              )),
        ],
      ),
    );
  }
}
