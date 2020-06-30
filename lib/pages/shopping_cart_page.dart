import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';
import 'package:getflutter/types/gf_button_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/Provider/counter.dart';
import 'package:shoppingapp/modal/cart.dart';
import 'package:shoppingapp/modal/createOrder.dart';
import 'package:shoppingapp/pages/order_page.dart';
import 'package:shoppingapp/util/sql_helper.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/homepage/search_box.dart';
import 'package:shoppingapp/widgets/shopping_cart/shopping_cart_item.dart';
import 'package:sqflite/sqflite.dart';

class ShoppingCartPage extends StatefulWidget {
  ShoppingCartPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new HomeWidgetState();
  }
}

class HomeWidgetState extends State<ShoppingCartPage>
    with SingleTickerProviderStateMixin {
  List<Cart> CartList;
  SQL_Helper helper = new SQL_Helper();
  static double total=0;
  int count = 0;
  List<LineItems> items;

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
    if (CartList == null) {
      CartList = new List<Cart>();
      updateListView();
    }
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

                Container(
                    height:400,
                    child: getCartList())
              ],
            )),
          ],
        ),
      ),
    );
  }
  ListView getCartList() {
    return ListView.builder(
        itemCount:CartList.length,
        itemBuilder: (BuildContext context, int position) {
          double x= this.CartList[position].pass*this.CartList[position].quantity;
          return ShoppingCartItem(
            productModel: CartList[position],
             themeColor:Provider.of<ThemeNotifier>(context), imageUrl: "prodcut1.png");
        });
  }
  void updateListView() {
    final Future<Database> db = helper.initializedDatabase();
    db.then((database) {
      Future<List<Cart>> students = helper.getStudentList();
      students.then((theList) {
        setState(() {
          this.CartList = theList;
          total=0;
          items = new List<LineItems>();
          for (int i = 0; i <=  theList.length-1 ; i++){
            print(this.CartList[i].idVariation);
            total+=this.CartList[i].quantity*this.CartList[i].pass;
            if (this.CartList[i].idVariation==null)
            { items.add(new LineItems(
              productId: this.CartList[i].id,
              quantity: this.CartList[i].quantity,

            ));}
            else{ items.add(new LineItems(
                productId: this.CartList[i].id,
                quantity: this.CartList[i].quantity,
                variationId: this.CartList[i].idVariation
            ));}

          }

        });
      });
    });
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
          Text(Provider.of<counter>(context).countCart.toString()+" products",
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
                total.toString(),
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
