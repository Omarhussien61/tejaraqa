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
import 'package:shoppingapp/utils/util/sql_address.dart';
import 'package:sqflite/sqflite.dart';

class AddressPage extends StatefulWidget {


  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {

  List<Address_shiping> addressList;
  SQL_Address helper = new SQL_Address();

  @override
  void initState() {
    updateListView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (addressList == null) {
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

        bottomNavigationBar: InkWell(
          onTap: () {
            Nav.routeReplacement(context, NewAddressPage());
          },
          child: Container(
            margin: EdgeInsets.only(left: 14, right: 14),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Add new address",
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
        body: Container(
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "My address",
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
                  margin: EdgeInsets.all(8),
                  child: Container(
                    height: ScreenUtil.getHeight(context),
                    child: ListView.builder(
                      itemCount: addressList.length,
                      itemBuilder: (BuildContext context, int index) {
                       return buildAddressItem(context,addressList[0]);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildAddressItem(BuildContext context, Address_shiping address) {
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
                address.Country,
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF5D6A78)),
              ),
              InkWell(onTap: () => _delete(context,address),
                  child: Icon(Icons.delete_forever, color:Provider.of<ThemeNotifier>(context).getColor() ,))
            ],
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
                    "Invoice",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF5D6A78)),
                  ),
                  Text(
                    "Id No",
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
                    "Individual",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF5D6A78)),
                  ),
                  Text(
                    "xxx xxxx xxx xxx ",
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
        });
      });
    });
  }

  void _delete(BuildContext context, Address_shiping student) async {
    int ressult = await helper.deleteStudent(student.id);
    if (ressult != 0) {
      updateListView();
    }
  }
}
