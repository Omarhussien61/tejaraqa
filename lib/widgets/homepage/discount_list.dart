import 'package:flutter/material.dart';
import 'package:shoppingapp/modal/productmodel.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/homepage/discount_item.dart';
import 'package:shoppingapp/widgets/homepage/product_list_titlebar.dart';

class DiscountList extends StatelessWidget {
  const DiscountList({
    Key key,
    @required this.product,
    @required this.themeColor,
    this.productListTitleBar,
  }) : super(key: key);

  final Future<List<ProductModel>>product;
  final ThemeNotifier themeColor;
  final ProductListTitleBar productListTitleBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16, top: 16, bottom: 8),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          productListTitleBar,
          Container(
            height: 200,
            child: FutureBuilder(
              future: product,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return  ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                    return DiscountItem(
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
