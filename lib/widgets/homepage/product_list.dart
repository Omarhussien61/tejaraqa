import 'package:flutter/material.dart';
import 'package:shoppingapp/modal/productmodel.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/commons/product_card.dart';
import 'package:shoppingapp/widgets/homepage/product_list_titlebar.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key key,
    @required this.themeColor,
    @required this.product,
    this.productListTitleBar,
  }) : super(key: key);
  final Future<List<ProductModel>>product;
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
            child: FutureBuilder(
              future: product,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return  ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return ProductCard(
                            themeColor: themeColor, product:snapshot.data[i]);
                      });
                } else {
                  return Center(child:
                  CircularProgressIndicator(
                      valueColor:  AlwaysStoppedAnimation<Color>(themeColor.getColor())));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
