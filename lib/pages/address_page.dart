import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/modal/Address_shiping.dart';
import 'package:shoppingapp/pages/new_adress_page.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';
import 'package:shoppingapp/utils/util/sql_address.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_adress_page.dart';
import 'package:shoppingapp/pages/search_page.dart';

class AddressPage extends StatefulWidget {


  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {

  List<Address_shiping> addressList;
  SQL_Address helper = new SQL_Address();
  int count = 0;

  @override
  void initState() {
    updateListView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (addressList == null||addressList.isEmpty) {
      addressList = new List<Address_shiping>();
      setState(() {
        updateListView();
      });
    }
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(42.0), // here the desired height
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text(
              getTransrlate(context, 'MyAddress'),
              style:
              GoogleFonts.poppins(color: Color(0xFF5D6A78), fontSize: 15),
            ),
            leading: InkWell(
              onTap:() {Navigator.pop(context);},
              child: Icon(
                Icons.chevron_left,
                color: Colors.grey,
                size: 32,
              ),
            ),
          ),
        ),

        bottomNavigationBar: InkWell(
          onTap: () {
            _navigateAndDisplaySelection(context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 14, right: 14),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                getTransrlate(context, 'AddNewAddress'),
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
            height: 42,
            decoration: BoxDecoration(
                color: themeColor.getColor(),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32))),
          ),
        ),
        backgroundColor: Color(0xFFFCFCFC),
        body: addressList.isNotEmpty?Container(
          padding: EdgeInsets.only(left: 24,right: 24,top: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  getTransrlate(context, 'MyAddress'),
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
                  height: 16,
                ),
                Container(
                  child: Container(
                    height: ScreenUtil.getHeight(context)-110,
                    child: ListView.builder(
                      itemCount: count,
                      itemBuilder: (BuildContext context, int index) {
                       return buildAddressItem(context,addressList[index]);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ):Center(
          child: Hero(
            tag: 'icon',
            child: Column(
              children: [
                Container(
                  height: 400,
                  child: CachedNetworkImage(
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      imageUrl:
                      'https://d2.woo2.app/wp-content/uploads/2020/08/5-removebg-preview-1.png'),
                ),
                Text(getTransrlate(context, 'noMyaddress')),
                SizedBox(
                  height: 50,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAddressItem(BuildContext context, Address_shiping address) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.2),
              blurRadius: 6.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: Offset(
                0.0, // Move to right 10  horizontally
                1.0, // Move to bottom 10 Vertically
              ),
            )
          ]),
      height: ScreenUtil.getHeight(context) / 3.1,
      width: ScreenUtil.getWidth(context),
      margin: EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                address.title,
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF5D6A78)),
              ),
              Row(
                children: <Widget>[
                  InkWell(onTap: () => _navigateSelection(context,address),
                      child: Icon(Icons.edit , color:Colors.grey)),
                  SizedBox(
                    width: 20,
                  ),
                   InkWell(onTap: () => _delete(context,address),
                      child: Icon(Icons.delete_forever, color:Provider.of<ThemeNotifier>(context).getColor() )),
                ],
              )
            ],
          ),
          Text(
            address.Country,
            style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Color(0xFF5D6A78)),
          ),
          Text(
            address.city,
            style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Color(0xFF5D6A78)),
          ),
          Container(width: 64, child: Divider()),
          Expanded(
              child: Text(
                address.addres1,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF5D6A78)),
              )),
          Container(width: 64, child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    getTransrlate(context, 'Street'),
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF5D6A78)),
                  ),
                  Text(
                    address.street,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF5D6A78)),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    getTransrlate(context, 'Building'),
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF5D6A78)),
                  ),
                  Text(
                    address.buildingNo,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF5D6A78)),
                  ),
                ],
              )
            ],
          )
        ],
      ),
      padding: EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 24),
    );
  }
  void updateListView() {
    final Future<Database> db = helper.initializedDatabase();
    db.then((database) {
      Future<List<Address_shiping>> students = helper.getStudentList();
      students.then((theList) {
        setState(() {
          this.addressList = theList;
          this.count = theList.length;
        });
      });
    });
  }
  void _delete(BuildContext context, Address_shiping student) async {
    int ressult = await helper.deleteAddress(student.id);
    if (ressult != 0) {
      updateListView();
    }
  }
  _navigateAndDisplaySelection(BuildContext context) async {
    this.count = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewAddressPage()),
    );
    updateListView();

  }

  _navigateSelection(BuildContext context,Address_shiping address_shiping) async {
    this.count = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditAddressPage(address_shiping)),
    );
    updateListView();
  }

}
