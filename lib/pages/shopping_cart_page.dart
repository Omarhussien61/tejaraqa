import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';
import 'package:getflutter/types/gf_button_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/modal/cart.dart';
import 'package:shoppingapp/modal/createOrder.dart';
import 'package:shoppingapp/pages/order_page.dart';
import 'package:shoppingapp/utils/commons/add_to_cart.dart';
import 'package:shoppingapp/utils/commons/show_dialog.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';
import 'package:shoppingapp/utils/util/sql_helper.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/shopping_cart/shopping_cart_item.dart';
import 'package:sqflite/sqflite.dart';

import 'login_page.dart';

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
  static double total = 0;
  int count = 0;
  bool connected;
  List<LineItems> items;
  final scaffoldKey = GlobalKey<ScaffoldState>();
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
        key: scaffoldKey,
        bottomNavigationBar:shoppingCartBottomSummary(themeColor),
        backgroundColor: whiteColor,
        body: OfflineBuilder(
          connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
              ) {
            connected = connectivity != ConnectivityResult.none;
            return Stack(
              children: <Widget>[
                SingleChildScrollView(
                    child:CartList.length!=0? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 26,
                        ),
                        shoppingCartInfo(),
                        SizedBox(
                          height: 12,
                        ),
                        Container(height: ScreenUtil.getHeight(context)/1.6, child: getCartList())
                      ],
                    ):Center(
                      child: Hero(
                        tag: 'icon',
                        child: CachedNetworkImage(
                            errorWidget: (context, url, error) => Icon(Icons.error),
                            imageUrl:
                            'https://d2.woo2.app/wp-content/uploads/2020/07/Capture.png'),
                      ),
                    )),
              ],
            );
          },

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                'There are no bottons to push :)',
              ),
              new Text(
                'Just turn off your internet.',
              ),
            ],
          ),
        ),
      ),
    );
  }
  ListView getCartList() {
    return ListView.builder(
        itemCount: CartList.length,
        itemBuilder: (BuildContext context, int position) {
          double x =
              this.CartList[position].pass * this.CartList[position].quantity;
          return Container(
            margin: EdgeInsets.only(top: 8, left: 24, bottom: 8, right: 24),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[200],
                      blurRadius: 5.0,
                      spreadRadius: 1,
                      offset: Offset(0.0, 1)),
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ShoppingCartItem(
                    productModel: CartList[position],
                    themeColor: Provider.of<ThemeNotifier>(context),
                    ),
                Column(
                  children: [
                    Container(
                      width: ScreenUtil.getWidth(context) / 2.5,
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          AutoSizeText(
                            CartList[position].name,
                            style: GoogleFonts.cairo(
                              fontSize: 12,
                              color: Color(0xFF5D6A78),
                              fontWeight: FontWeight.w300,
                            ),
                            maxLines: 2,
                            minFontSize: 11,
                          ),
                          Text(
                            CartList[position].pass.toString()+" "+ CartList[position].Currancy ,
                            style: GoogleFonts.cairo(
                                color: Provider.of<ThemeNotifier>(context).getColor(),
                                fontSize: 18,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 50,
                      margin: EdgeInsets.only(top: 26),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child:  Container(
                          padding: EdgeInsets.only(
                              left: 8, right: 8, top: 4, bottom: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Provider.of<ThemeNotifier>(context).getColor(),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (this.CartList[position].quantity != 1) {
                                        this.CartList[position].quantity--;
                                        helper.updateCart(this.CartList[position]);
                                      }
                                    });

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0,left: 8.0),
                                    child: Text(
                                      "-",
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.white),
                                    ),
                                  )),
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(18),
                                    color: Color(0xFF707070),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding:
                                    const EdgeInsets.all(8.0),
                                    child: Text(this.CartList[position].quantity.toString(),
                                        style: GoogleFonts.cairo(
                                            color: Colors.white,
                                            fontSize: 16)),
                                  )),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      this.CartList[position].quantity++;
                                    });
                                    helper.updateCart(this.CartList[position]);

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0,left: 8.0),
                                    child: Text("+",
                                        style: TextStyle(
                                            color: Colors.white)),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Feather.trash,
                    size: 18,
                    color: Color(0xFF5D6A78),
                  ),
                  onPressed: () {
                    delete(context,CartList[position]);
                  },
                ),
              ],
            ),
          );
        });
  }
  void updateListView() {
    final Future<Database> db = helper.initializedDatabase();
    db.then((database) {
      Future<List<Cart>> students = helper.getDataList();
      students.then((theList) {
        setState(() {
          this.CartList = theList;
          total = 0;
          items = new List<LineItems>();
          for (int i = 0; i <= theList.length - 1; i++) {
            print(this.CartList[i].idVariation);
            total += this.CartList[i].quantity * this.CartList[i].pass;
            if (this.CartList[i].idVariation == null) {
              items.add(new LineItems(
                productId: this.CartList[i].id,
                quantity: this.CartList[i].quantity,
              ));
            } else {
              items.add(new LineItems(
                  productId: this.CartList[i].id,
                  quantity: this.CartList[i].quantity,
                  variationId: this.CartList[i].idVariation));
            }
          }
        });
      });
    });
  }
  Widget shoppingCartInfo() {
    return Container(
      margin: EdgeInsets.only(left: 24,right: 24),
      child: Row(
        children: <Widget>[
          Text(
            getTransrlate(context, 'ShoppingCart'),
            style: GoogleFonts.cairo(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Color(0xFF5D6A78)),
          ),
          SizedBox(
            width: 16,
          ),
          Text(Provider.of<ThemeNotifier>(context).countCart.toString()+' '+ getTransrlate(context, 'product'),
              style: GoogleFonts.cairo(
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
      height: 90,
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                getTransrlate(context, 'total'),
                style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold, color: themeColor.getColor()),
              ),
              Text(
                CartList.isNotEmpty?calculateTotal().toString():"",
                style: GoogleFonts.cairo(color: themeColor.getColor()),
              ),
            ],
          ),
          GFButton(
            color: themeColor.getColor(),
            child: Text(
              getTransrlate(context, 'Confirm'),
              style: GoogleFonts.cairo(color: whiteColor, fontSize: 16),
            ),
            onPressed: () {
              if(connected) {
                if (CartList.length == 0 ||
                    CartList.isEmpty ||
                    CartList == null) {
                  final snackbar = SnackBar(
                    content: Text(getTransrlate(context, 'CartEmpty')),
                  );
                  scaffoldKey.currentState.showSnackBar(snackbar);
                } else {
                  if(!themeColor.config_model.doneOrderScreen){
                    show_Dialog(context);
                  }else {
                    Provider
                        .of<ThemeNotifier>(context)
                        .isLogin ?
                    Nav.route(context, OrderPage(CartList, total)) :
                    showLogintDialog(getTransrlate(context, 'login'),
                        getTransrlate(context, 'notlogin'), context);
                  }
                }
              }
              else{
                Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor: themeColor.getColor(),
                    content: Text(getTransrlate(context, 'NotConnection'))));}
            },
            type: GFButtonType.solid,
            shape: GFButtonShape.pills,
          )
        ],
      ),
    );
  }
  void delete(BuildContext context, Cart student) async {
    int ressult = await helper.deleteCart(student.id);
    if (ressult != 0) {
      updateListView();
      countCart(context);

    }
  }
  String calculateTotal() {
    setState(() {
      total = 0;
      CartList.forEach((f) {
        total += f.quantity * f.pass;
      });
    });
    return num.parse(total.toStringAsFixed(10)).toString()+'  '+CartList[0].Currancy;
  }
}
