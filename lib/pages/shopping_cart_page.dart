import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';
import 'package:getflutter/types/gf_button_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/pages/order_page.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/homepage/search_box.dart';
import 'package:shoppingapp/widgets/shopping_cart/shopping_cart_item.dart';

class ShoppingCartPage extends StatefulWidget {
  ShoppingCartPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new HomeWidgetState();
  }
}

class HomeWidgetState extends State<ShoppingCartPage>
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
        bottomSheet: shoppingCartBottomSummary(themeColor),
        backgroundColor: whiteColor,
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SearchBox(),
                SizedBox(
                  height: 26,
                ),
                shoppingCartInfo(),
                SizedBox(
                  height: 12,
                ),
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    ShoppingCartItem(
                        themeColor: themeColor, imageUrl: "prodcut1.png"),
                    ShoppingCartItem(
                        themeColor: themeColor, imageUrl: "prodcut2.png"),
                    ShoppingCartItem(
                        themeColor: themeColor, imageUrl: "prodcut3.png"),
                    ShoppingCartItem(
                        themeColor: themeColor, imageUrl: "prodcut4.png"),
                    ShoppingCartItem(
                        themeColor: themeColor, imageUrl: "prodcut5.png"),
                    ShoppingCartItem(
                        themeColor: themeColor, imageUrl: "prodcut1.png"),
                    ShoppingCartItem(
                        themeColor: themeColor, imageUrl: "prodcut7.png"),
                  ],
                )
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget shoppingCartInfo() {
    return Container(
      margin: EdgeInsets.only(left: 24),
      child: Row(
        children: <Widget>[
          Text(
            "My Shopping Cart",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Color(0xFF5D6A78)),
          ),
          SizedBox(
            width: 16,
          ),
          Text("5 products",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(0xFF5D6A78))),
        ],
      ),
    );
  }

  Widget shoppingCartBottomSummary(ThemeNotifier themeColor) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.3),
              blurRadius: 9.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: Offset(
                0.0, // Move to right 10  horizontally
                0.0, // Move to bottom 10 Vertically
              ),
            )
          ]),
      height: 80,
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Total",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, color: themeColor.getColor()),
              ),
              Text(
                "5.500 TL",
                style: GoogleFonts.poppins(color: themeColor.getColor()),
              ),
            ],
          ),
          GFButton(
            color: themeColor.getColor(),
            child: Text(
              "Confirm",
              style: GoogleFonts.poppins(color: whiteColor, fontSize: 10),
            ),
            onPressed: () {
              Nav.route(context, OrderPage());
            },
            type: GFButtonType.solid,
            shape: GFButtonShape.pills,
          )
        ],
      ),
    );
  }
}
