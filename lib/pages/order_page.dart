import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/main.dart';
import 'package:shoppingapp/modal/Address_shiping.dart';
import 'package:shoppingapp/modal/ConfirmOrder.dart';
import 'package:shoppingapp/modal/PaymentModel.dart';
import 'package:shoppingapp/modal/cart.dart';
import 'package:shoppingapp/modal/createOrder.dart';
import 'package:shoppingapp/pages/credit_cart_page.dart';
import 'package:shoppingapp/service/OrderService.dart';

import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/shared_preferences_helper.dart';
import 'package:shoppingapp/utils/util/sql_address.dart';
import 'package:sqflite/sqflite.dart';

import 'ditails_Payment.dart';
import 'new_adress_page.dart';

class OrderPage extends StatefulWidget {
  List<Cart> items;


  OrderPage(this.items);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  List<Address_shiping> addressList;
  Address_shiping address;
  SQL_Address helper = new SQL_Address();
  int count = 0;
  int checkboxValueA,checkboxValueB;
  List<PaymentModel> PaymentList;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  String phone;
  String username,name,email;
  int id;
  @override
  void initState() {

    fetchUserId();
  OrderService.getAllPayment().then((onValue){
    setState(() {
      PaymentList=onValue;
    });
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (addressList == null) {
      addressList = new List<Address_shiping>();
      updateListView();
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
        key: scaffoldKey,
        backgroundColor: Color(0xFFFCFCFC),
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Addresses",
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: Color(0xFF5D6A78)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          buildAddressItem(context, themeColor),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Select a payment method",
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: Color(0xFF5D6A78)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                PaymentList!=null? Container(
                                  height: PaymentList == null ? 50 :PaymentList.length*50.toDouble(),
                                  child:ListView.builder(
                                      itemCount:PaymentList == null ? 0 :PaymentList.length,
                                      itemBuilder: (BuildContext context, int pos) {
                                        return  buildPayMethodItem(context, PaymentList[pos].title, themeColor,pos);
                                      }),
                                ):Center(child: CircularProgressIndicator()),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    phone==null?Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 16, bottom: 8),
                          child: Text(
                            "Phone Number",
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: Color(0xFF5D6A78)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 8, right: 8, left: 8),
                          child: ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(

                                        decoration: InputDecoration(

                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: themeColor.getColor()),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: textColor),
                                            ),
                                            labelStyle: new TextStyle(
                                                color: const Color(0xFF424242)),
                                            hintText: "Enter the Phone Number",
                                            hintStyle: GoogleFonts.poppins(
                                                fontSize: 12, color: textColor)),
                                        onChanged: (String value){
                                          phone=value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ):Container(),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 16, bottom: 8),
                      child: Text(
                        "Order Note",
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: Color(0xFF5D6A78)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 8, right: 8, left: 8),
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: themeColor.getColor()),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: textColor),
                                        ),
                                        labelStyle: new TextStyle(
                                            color: const Color(0xFF424242)),
                                        hintText: "Enter the order Notes",
                                        hintStyle: GoogleFonts.poppins(
                                            fontSize: 12, color: textColor)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: GFButton(
                        borderShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            6,
                          ),
                        ),
                        child: Text("ORDER COMPLETE"),
                        color: themeColor.getColor(),
                        onPressed: () {
                          //Nav.route(context, CreditCartPage());
                          if(phone!=null)
                          {
                            if(checkboxValueA==null){
                              final snackbar = SnackBar(
                                content: Text('Address not Selected'),
                              );
                              scaffoldKey.currentState.showSnackBar(snackbar);
                            }else{
                              create_New_order(phone);
                              setState(() {
                                _isLoading=true;
                              });
                            }

                          }
                          else
                          {
                            final snackbar = SnackBar(
                              content: Text('Not phone'),
                            );
                            scaffoldKey.currentState.showSnackBar(snackbar);
                          }
                        },
                        type: GFButtonType.solid,
                        fullWidthButton: true,
                      ),
                    )
                  ],
                ),
              ),
            ),
            _isLoading ? Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black45,
                child: Center(child: CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(themeColor.getColor()),
                )))
                : Container()
          ],
        ),
      ),
    );
  }

  buildPayMethodItem(BuildContext context, String title, themeColor,int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Radio<int>(
              value: index,
              groupValue: checkboxValueB,
              activeColor: themeColor.getColor(),
              focusColor: themeColor.getColor(),
              hoverColor: themeColor.getColor(),
              onChanged: (int value) {
                setState(() {
                  checkboxValueB=value;
                });
              },
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF5D6A78)),
            ),
          ],
        ),
      ],
    );
  }
  buildAddressItem(BuildContext context, themeColor) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: addressList == null ? 50 :addressList.length*60.toDouble(),
            child: ListView.builder(
                itemCount: count,
                itemBuilder: (BuildContext context, int position) {
                  return buildItemRadio(context, themeColor,addressList[position], position);
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14.0, bottom: 10, top: 24),
            child: Container(
              height: ScreenUtil.getHeight(context) * 0.05,
              width: ScreenUtil.getWidth(context) * 0.30,
              child: GFButton(
                focusColor: themeColor.getColor().withOpacity(0.5),
                disabledColor: themeColor.getColor().withOpacity(0.5),
                disabledTextColor: themeColor.getColor().withOpacity(0.5),
                highlightColor: themeColor.getColor().withOpacity(0.5),
                hoverColor: themeColor.getColor().withOpacity(0.5),
                splashColor: themeColor.getColor().withOpacity(0.5),
                color: themeColor.getColor(),
                type: GFButtonType.outline,
                onPressed: () {
                  Nav.route(context, NewAddressPage());
                },
                child: Text("Add address"),
              ),
            ),
          )
        ],
      ),
    );
  }
  void updateListView() {
    final Future<Database> db = helper.initializedDatabase();
    db.then((database) {
      Future<List<Address_shiping>> addresslist = helper.getStudentList();
      addresslist.then((theList) {
        setState(() {
          this.addressList = theList;
          this.count = theList.length;
        });
      });
    });
  }
  buildItemRadio(BuildContext context, themeColor,Address_shiping address_shiping,int position) {

    return Container(
      padding: EdgeInsets.only(left: 12, right: 12, top: 12),
      width: ScreenUtil.getWidth(context),
      child: Row(
        children: <Widget>[
          Radio<int>(
            value: position,
            groupValue: checkboxValueA,
            activeColor: themeColor.getColor(),
            focusColor: themeColor.getColor(),
            hoverColor: themeColor.getColor(),
            onChanged: (int value) {
              setState(() {
                checkboxValueA = value;
              });
            },
          ),
          Expanded(
              child: Text(
                address_shiping.addres1,
            style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Color(0xFF5D6A78)),
          )),
          IconButton(
            onPressed: (){
              _delete(context, addressList[position]);
            },
            icon: Icon(Icons.delete,color:Colors.red),
          )
        ],
      ),
    );
  }



  void _delete(BuildContext context, Address_shiping student) async {

    int ressult = await helper.deleteStudent(student.id);
    if (ressult != 0) {
      updateListView();
    }
  }
  create_New_order(String phone) async{
    fetchUserId();
    if(checkboxValueA==null){
      final snackbar = SnackBar(
        content: Text('برجاء حدد عنوان'),
      );
      scaffoldKey.currentState.showSnackBar(snackbar);
      setState(() {
        _isLoading=false;
      });

    }else{

      //Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentScreen(total,addressList[checkboxValueA],setItemlins(items))));
      ConfirmOrder confirmOrder= await OrderService.createorder(
          setItemlins(widget.items), id.toString(), addressList[checkboxValueA].city,
          addressList[checkboxValueA].addres1, phone, name, addressList[checkboxValueA].Country,
          email,PaymentList[checkboxValueB].id,PaymentList[checkboxValueB].title,null);
      if(confirmOrder==null)
      {
        final snackbar = SnackBar(
          content: Text('خطأء فى الطلب'),
        );
        setState(() {
          _isLoading=false;
        });
        scaffoldKey.currentState.showSnackBar(snackbar);

      }
      else{
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DetailScreen(confirmOrder)),
            ModalRoute.withName("/home"));
      }
    }

  }
  Future fetchUserId() async{
    email = await SharedPreferencesHelper.getEmail();
    name = await SharedPreferencesHelper.getname();
    username = await SharedPreferencesHelper.getUserimage();
    name = await SharedPreferencesHelper.getname();
    id = await SharedPreferencesHelper.getUserId();
    phone=await SharedPreferencesHelper.getphone();
  }
  List<LineItems> setItemlins(List<Cart> items){
    List<LineItems> item = new List<LineItems>();
    for (int i = 0; i <= items.length-1 ; i++){
      if (items[i].idVariation!=null)
      { item.add(new LineItems(
        productId: items[i].id,
        quantity: items[i].quantity,
        variationId: items[i].idVariation,
      ));

      }else
      {
        item.add(new LineItems(
            productId: items[i].id,
            quantity: items[i].quantity));


      }
      print(items[i].idVariation);

    }
    return item;
  }


}
