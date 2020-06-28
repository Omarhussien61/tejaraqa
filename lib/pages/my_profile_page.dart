import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/pages/about_page.dart';
import 'package:shoppingapp/pages/contact_page.dart';
import 'package:shoppingapp/pages/favorite_products_page.dart';
import 'package:shoppingapp/pages/orders_detail_page.dart';
import 'package:shoppingapp/pages/product_detail.dart';
import 'package:shoppingapp/pages/product_detail_page_.dart';
import 'package:shoppingapp/pages/profile_settings_page.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Color(0xFFFCFCFC),
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFCFCFC),
        body: Container(
          padding: EdgeInsets.only(right: 24, left: 24, top: 8, bottom: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "My Profile",
                  style: GoogleFonts.poppins(
                      fontSize: 18, color: Color(0xFF5D6A78)),
                ),
                Container(
                    width: 28,
                    child: Divider(
                      color: themeColor.getColor(),
                      height: 3,
                      thickness: 2,
                    )),
                SizedBox(
                  height: 12,
                ),
                ListTile(
                  onTap: () {
                    Nav.route(context, OrdersDetailPage());
                  },
                  leading: Icon(
                    Feather.box,
                    color: Color(0xFF5D6A78),
                  ),
                  title: Text("My Orders",
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: Color(0xFF5D6A78))),
                ),
                SizedBox(
                  height: 12,
                ),
                ListTile(
                  onTap: () {
                    Nav.route(context, ProductDetailPageAlternative());
                  },
                  leading: Image.asset("assets/icons/ic_comment.png",
                      width: 22, color: Color(0xFF5D6A78)),
                  title: Text("Product ratings",
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: Color(0xFF5D6A78))),
                ),
                SizedBox(
                  height: 12,
                ),
                ListTile(
                  onTap: () {
                    Nav.route(context, ContactPage());
                  },
                  leading: Image.asset("assets/icons/ic_user.png",
                      width: 22, color: Color(0xFF5D6A78)),
                  title: Text("Support",
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: Color(0xFF5D6A78))),
                ),
                SizedBox(
                  height: 12,
                ),
                ListTile(
                  onTap: () {
                    Nav.route(context, FavoriteProductsPage());
                  },
                  leading: Image.asset("assets/icons/ic_heart_profile.png",
                      width: 22, color: Color(0xFF5D6A78)),
                  title: Text("My Favorites",
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: Color(0xFF5D6A78))),
                ),
                SizedBox(
                  height: 12,
                ),
                ListTile(
                  onTap: () {
                    Nav.route(context, AboutPage());
                  },
                  leading: Image.asset("assets/icons/ic_question.png",
                      width: 20, color: Color(0xFF5D6A78)),
                  title: Text("Frequently Asked Questions",
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: Color(0xFF5D6A78))),
                ),
                SizedBox(
                  height: 12,
                ),
                ListTile(
                  onTap: () {
                    Nav.route(context, ProductDetailPage());
                  },
                  leading: Image.asset("assets/icons/ic_ticket.png",
                      width: 22, color: Color(0xFF5D6A78)),
                  title: Text("Coupons",
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: Color(0xFF5D6A78))),
                ),
                SizedBox(
                  height: 12,
                ),
                ListTile(
                  onTap: () {
                    Nav.route(context, MyProfileSettings());
                  },
                  leading: Image.asset("assets/icons/ic_search.png",
                      width: 22, color: Color(0xFF5D6A78)),
                  title: Text("Profile Settings",
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: Color(0xFF5D6A78))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
