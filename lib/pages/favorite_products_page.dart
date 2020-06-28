import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/homepage/search_box.dart';
import 'package:shoppingapp/widgets/wish_list/rounded_tab_bar.dart';
import 'package:shoppingapp/widgets/wish_list/wish_list_item.dart';

class FavoriteProductsPage extends StatefulWidget {
  FavoriteProductsPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new HomeWidgetState();
  }
}

class HomeWidgetState extends State<FavoriteProductsPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SearchBox(),
            SizedBox(
              height: 26,
            ),
            RoundedTabBar(themeColor: themeColor),
            SizedBox(
              height: 16,
            ),
            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
                WishListItem(themeColor: themeColor, imageUrl: "prodcut9.png"),
                WishListItem(themeColor: themeColor, imageUrl: "prodcut8.png"),
                WishListItem(themeColor: themeColor, imageUrl: "prodcut7.png"),
                WishListItem(themeColor: themeColor, imageUrl: "prodcut1.png"),
                WishListItem(themeColor: themeColor, imageUrl: "prodcut5.png"),
                WishListItem(themeColor: themeColor, imageUrl: "prodcut4.png"),
                WishListItem(themeColor: themeColor, imageUrl: "prodcut3.png"),
              ],
            )
          ],
        )),
      ),
    );
  }
}
