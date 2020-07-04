import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/modal/Orders_model.dart';
import 'package:shoppingapp/service/productdervice.dart';
import 'package:shoppingapp/utils/util/shared_preferences_helper.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/orders_detail/order_item.dart';

class OrdersDetailPage extends StatefulWidget {
  @override
  _OrdersDetailPageState createState() => _OrdersDetailPageState();
}

class _OrdersDetailPageState extends State<OrdersDetailPage> {
  List<Orders_model> orders;
  List<LineItemsOrder> items;

  @override
  void initState() {
    getorders();
    // TODO: implement initState
    super.initState();
  }

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
            leading: InkWell(
              onTap:() {Navigator.pop(context);},
              child: Icon(
                Icons.chevron_left,
                color: textColor,
                size: 32,
              ),
            ),
          ),
        ),
        backgroundColor: greyBackground,
        key: _drawerKey, // assign key to Scaffold
        body: orders!=null?
        Container(
          height: ScreenUtil.getHeight(context)-45,
          child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (BuildContext context, int index) {
              return  OrderItem(
                  themeColor: themeColor, orders_model:orders[index] );
            },
          ),
        ):
        Center(child:
        CircularProgressIndicator(
            valueColor:  AlwaysStoppedAnimation<Color>(themeColor.getColor()))),
      ),
    );
  }

  Future<void> getorders() async {
    int id =await SharedPreferencesHelper.getUserId();
     ProductService().getOrdersDetails(id).then((value) {
       setState(() {
         orders=value;
       });
     });
  }
}
