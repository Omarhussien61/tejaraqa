import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/orders_detail/order_item.dart';

class OrdersDetailPage extends StatefulWidget {
  @override
  _OrdersDetailPageState createState() => _OrdersDetailPageState();
}

class _OrdersDetailPageState extends State<OrdersDetailPage> {
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 252, 252, 252),
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));

    GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(42.0), // here the desired height
          child: AppBar(
            backgroundColor: greyBackground,
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Order Details",
              style:
                  GoogleFonts.poppins(color: Color(0xFF5D6A78), fontSize: 15),
            ),
            leading: Icon(
              Icons.chevron_left,
              color: textColor,
              size: 32,
            ),
          ),
        ),
        backgroundColor: greyBackground,
        key: _drawerKey, // assign key to Scaffold

        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: ScreenUtil.getWidth(context),
                    margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                    padding: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[200],
                            blurRadius: 8.0,
                            spreadRadius: 1,
                            offset: Offset(0.0, 3))
                      ],
                      color: Theme.of(context).bottomAppBarColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ExpandablePanel(
                      header: Text(
                        "Order Details",
                        style: GoogleFonts.poppins(
                            color: Color(0xFF5D6A78), fontSize: 12),
                      ),
                      expanded: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil.getWidth(context) / 4,
                                  child: Text(
                                    "The unveiled blessing of harmony is to meet with dogma  ",
                                    softWrap: true,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xFF5D6A78),
                                    ),
                                  ),
                                ),
                                Text(
                                  "1",
                                  softWrap: true,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xFF5D6A78),
                                  ),
                                ),
                                Text(
                                  "\$450",
                                  softWrap: true,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xFF5D6A78),
                                  ),
                                )
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil.getWidth(context) / 4,
                                  child: Text(
                                    "The unveiled blessing of harmony is to meet with dogma  ",
                                    softWrap: true,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xFF5D6A78),
                                    ),
                                  ),
                                ),
                                Text(
                                  "1",
                                  softWrap: true,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xFF5D6A78),
                                  ),
                                ),
                                Text(
                                  "\$450",
                                  softWrap: true,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xFF5D6A78),
                                  ),
                                )
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil.getWidth(context) / 4,
                                  child: Text(
                                    "The unveiled blessing of harmony is to meet with dogma  ",
                                    softWrap: true,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xFF5D6A78),
                                    ),
                                  ),
                                ),
                                Text(
                                  "1",
                                  softWrap: true,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xFF5D6A78),
                                  ),
                                ),
                                Text(
                                  "\$331",
                                  softWrap: true,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xFF5D6A78),
                                  ),
                                )
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil.getWidth(context) / 4,
                                  child: Text(
                                    "The unveiled blessing of harmony is to meet with dogma  ",
                                    softWrap: true,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xFF5D6A78),
                                    ),
                                  ),
                                ),
                                Text(
                                  "2",
                                  softWrap: true,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xFF5D6A78),
                                  ),
                                ),
                                Text(
                                  "\$450",
                                  softWrap: true,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xFF5D6A78),
                                  ),
                                )
                              ],
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      OrderItem(
                          themeColor: themeColor, imageUrl: "prodcut1.png"),
                      OrderItem(
                          themeColor: themeColor, imageUrl: "prodcut1.png")
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
