import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/pages/about_page.dart';
import 'package:shoppingapp/pages/contact_page.dart';
import 'package:shoppingapp/pages/favorite_products_page.dart';
import 'package:shoppingapp/pages/login_page.dart';
import 'package:shoppingapp/pages/orders_detail_page.dart';
import 'package:shoppingapp/pages/product_detail.dart';
import 'package:shoppingapp/pages/product_detail_page_.dart';
import 'package:shoppingapp/pages/profile_settings_page.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';

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
        body:themeColor.isLogin? Container(
          padding: EdgeInsets.only(right: 24, left: 24, top: 8, bottom: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                 getTransrlate(context, 'MyProfile'),
                  style: GoogleFonts.cairo(
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
                  title: Text(getTransrlate(context, 'Myorders'),
                      style: GoogleFonts.cairo(
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
                  title: Text(getTransrlate(context, 'productRateing'),
                      style: GoogleFonts.cairo(
                          fontSize: 15, color: Color(0xFF5D6A78))),
                ),
                SizedBox(
                  height: 12,
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
                  title: Text(getTransrlate(context, 'MyFav'),
                      style: GoogleFonts.cairo(
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
                  title: Text(getTransrlate(context, 'ProfileSettings'),
                      style: GoogleFonts.cairo(
                          fontSize: 15, color: Color(0xFF5D6A78))),
                )
              ],
            ),
          ),
        ):Center(
          child: Container(
            height:400  ,
            child: Center(child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),

                Center(child: Text(getTransrlate(context, 'PleaseLogin'))),
                SizedBox(
                  height: 100,
                ),
                GFButton(
                  onPressed: (){
                    Nav.route(context, LoginPage());
                  },
                  text: getTransrlate(context, 'login'),
                  color: themeColor.getColor(),
                  textStyle: GoogleFonts.cairo(
                      fontSize: 18
                  ),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
