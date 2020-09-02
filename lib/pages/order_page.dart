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
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';
import 'package:shoppingapp/utils/util/shared_preferences_helper.dart';
import 'package:shoppingapp/utils/util/sql_address.dart';
import 'package:sqflite/sqflite.dart';

import 'ditails_payment.dart';
import 'new_adress_page.dart';

class OrderPage extends StatefulWidget {
  List<Cart> items;
  double total;

  OrderPage(this.items, this.total);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool state = false;
  double copon = 0;
  double totalbeforedesc = 0;
  String code;
  bool coponState = true;
  TextEditingController _CoponController;
  List<Address_shiping> addressList;
  Address_shiping address;
  SQL_Address helper = new SQL_Address();
  int count = 0;
  int countItem = 0;

  int checkboxValueA =0, checkboxValueB=0;
  List<PaymentModel> PaymentList;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  bool _isedit = false;

  String _coponButton;

  String phone;
  String username, name, email;
  int id;

  @override
  void initState() {
    totalbeforedesc=widget.total;
    fetchUserId();
    OrderService.getAllPayment().then((onValue) {
      setState(() {
        PaymentList = onValue;
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
    return Scaffold(
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
                      getTransrlate(context, 'addressShipping'),
                      style: GoogleFonts.cairo(
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
                      getTransrlate(context, 'paymentMethod'),
                      style: GoogleFonts.cairo(
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
                              PaymentList != null
                                  ? Container(
                                      height: PaymentList == null
                                          ? 50
                                          : PaymentList.length *
                                              50.toDouble(),
                                      child: ListView.builder(
                                          itemCount: PaymentList == null
                                              ? 0
                                              : PaymentList.length,
                                          itemBuilder: (BuildContext context,
                                              int pos) {
                                            return buildPayMethodItem(
                                                context,
                                                PaymentList[pos].title,
                                                themeColor,
                                                pos);
                                          }),
                                    )
                                  : Center(
                                      child: CircularProgressIndicator()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  phone == null
                      ? Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, top: 16, bottom: 8),
                              child: Text(
                                getTransrlate(context, 'phone'),
                                style: GoogleFonts.cairo(
                                    fontSize: 12, color: Color(0xFF5D6A78)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: 8, right: 8, left: 8),
                              child: ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.grey.withOpacity(.2),
                                            blurRadius:
                                                6.0, // soften the shadow
                                            spreadRadius:
                                                0.0, //extend the shadow
                                            offset: Offset(
                                              0.0, // Move to right 10  horizontally
                                              1.0, // Move to bottom 10 Vertically
                                            ),
                                          )
                                        ]),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: themeColor
                                                          .getColor()),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: textColor),
                                                ),
                                                labelStyle: new TextStyle(
                                                    color: const Color(
                                                        0xFF424242)),
                                                hintText:
                                                    getTransrlate(context, 'hintphone'),
                                                hintStyle:
                                                    GoogleFonts.cairo(
                                                        fontSize: 12,
                                                        color: textColor)),
                                            onChanged: (String value) {
                                              phone = value;
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
                        )
                      : Container(),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, top: 16, bottom: 8),
                    child: Text(
                      getTransrlate(context, 'OrderNote'),
                      style: GoogleFonts.cairo(
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: themeColor.getColor()),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: textColor),
                                  ),
                                  labelStyle: new TextStyle(
                                      color: const Color(0xFF424242)),
                                  hintText: getTransrlate(context, 'OrderHint'),
                                  hintStyle: GoogleFonts.cairo(
                                      fontSize: 12, color: textColor)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding:  EdgeInsets.only(right: 16,left: 16,top: 8,bottom: 8),
                            child: TextFormField(
                              onChanged: (value) {
                                code = value;
                              },
                              controller: _CoponController,
                              enabled: !_isedit,
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: themeColor.getColor()),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: textColor),
                                  ),
                                  labelStyle: new TextStyle(
                                      color: const Color(0xFF424242)),
                                  hintText: getTransrlate(context, 'couponcode'),
                                  hintStyle: GoogleFonts.cairo(
                                      fontSize: 12, color: textColor)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: FlatButton.icon(
                              onPressed: () async {
                                if(_isedit)
                                  {
                                    setState(() {
                                      _isedit=false;
                                      widget.total=totalbeforedesc;
                                      copon=0;
                                      countItem=0;
                                    });
                                  }
                                else{
                                  _isedit=true;
                                   _coponButton= getTransrlate(context, 'edit');
                                    _isLoading = true;
                                  widget.items.forEach((f) {
                                    countItem += f.quantity ;
                                  });
                                  copon = await OrderService.getCoupons(code,id,widget.total,countItem);
                                  print('copoun = '+copon.toString());
                                  if (copon == 0) {
                                    final snackbar = SnackBar(
                                      content: Text(getTransrlate(
                                          context, 'codeInveild')),
                                    );
                                    scaffoldKey.currentState
                                        .showSnackBar(snackbar);
                                    setState(() {
                                      _isLoading = false;

                                    });
                                    // _CoponController.clear();
                                  }
                                  else {
                                    setState(() {
                                      _isLoading = false;

                                    });
                                    final snackbar = SnackBar(
                                      content: Text(
                                          getTransrlate(context, 'codeUsage')),
                                    );
                                    final snackbarconfirmed = SnackBar(
                                      content: Text(
                                          getTransrlate(context, 'codeDone')),
                                    );
                                    coponState
                                        ? setState(() {
                                      copon = copon + 0;
                                      widget.total =
                                      (widget.total - copon < 0)
                                          ? 0
                                          : widget.total - copon;
                                      coponState = false;
                                      _isLoading = false;
                                      scaffoldKey.currentState
                                          .showSnackBar(
                                          snackbarconfirmed);
                                    })
                                        : scaffoldKey.currentState
                                        .showSnackBar(snackbar);
                                  }
                                }
                              },
                              icon: Icon(
                                Icons.local_offer,
                                size: 15,
                              ),
                              label: Text(
                                  _isedit?getTransrlate(context, 'edit'):getTransrlate(context, 'couponApplay') ,
                                style: TextStyle(fontSize: 15),
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
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
                    width: ScreenUtil.divideWidth(context),
                    child: Column(
                      children: [
                        Row(
                          children: <Widget>[
                            Text(
                              getTransrlate(context, 'totalOrder')+' : ',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                letterSpacing: 0.7,
                              ),
                            ),
                            Text(
                              totalbeforedesc.toString()+' '+widget.items[0].Currancy,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                letterSpacing: 0.7,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                             getTransrlate(context, 'totaldiscount')+ ' : ',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                letterSpacing: 0.7,
                              ),
                            ),
                            Text(
                              copon == null ? '0.0'+' '+widget.items[0].Currancy
                                  : copon.toString()+' '+widget.items[0].Currancy,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                letterSpacing: 0.7,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              getTransrlate(context, 'total')+' : ',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                letterSpacing: 0.7,
                              ),
                            ),
                            Text(
                              widget.total.toString()+' '+widget.items[0].Currancy,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                letterSpacing: 0.7,
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:34, right:34),
                    child: GFButton(
                      borderShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          6,
                        ),
                      ),
                      child: Text(getTransrlate(context, 'ORDERCOMPLETE'),style: GoogleFonts.cairo(fontSize: 18),),
                      color: themeColor.getColor(),
                      onPressed: () {
                        //Nav.route(context, CreditCartPage());
                        if (phone != null) {
                          if (checkboxValueA == null) {
                            final snackbar = SnackBar(
                              content: Text(getTransrlate(context, 'addressSelected')),
                            );
                            scaffoldKey.currentState.showSnackBar(snackbar);
                          }
                          else {
                            create_New_order(phone);
                            setState(() {
                              _isLoading = true;
                            });
                          }
                        }
                        else {
                          final snackbar = SnackBar(
                            content: Text(getTransrlate(context, 'SelectPhone')),
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
          _isLoading
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black45,
                  child: Center(
                      child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(themeColor.getColor()),
                  )))
              : Container()
        ],
      ),
    );
  }

  buildPayMethodItem(
      BuildContext context, String title, themeColor, int index) {
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
                  checkboxValueB = value;
                });
              },
            ),
            Text(
              title,
              style: GoogleFonts.cairo(
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
            height:
                addressList == null ? 50 : addressList.length * 60.toDouble(),
            child: ListView.builder(
                itemCount: count,
                itemBuilder: (BuildContext context, int position) {
                  return buildItemRadio(
                      context, themeColor, addressList[position], position);
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14.0, right:14,bottom: 10, top: 24),
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
                onPressed: () async {
                  _navigateAndDisplaySelection(context);
                },
                child: Text(getTransrlate(context, 'Addnaw')),
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

  buildItemRadio(BuildContext context, themeColor,
      Address_shiping address_shiping, int position) {
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
            style: GoogleFonts.cairo(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Color(0xFF5D6A78)),
          )),
          IconButton(
            onPressed: () {
              _delete(context, addressList[position]);
            },
            icon: Icon(Icons.delete, color: Colors.red),
          )
        ],
      ),
    );
  }

  void _delete(BuildContext context, Address_shiping student) async {
    int ressult = await helper.deleteAddress(student.id);
    if (ressult != 0) {
      updateListView();
    }
  }

  create_New_order(String phone) async {
    fetchUserId();
    if (checkboxValueA == null) {
      final snackbar = SnackBar(
        content: Text(getTransrlate(context, 'addressSelected')),
      );
      scaffoldKey.currentState.showSnackBar(snackbar);
      setState(() {
        _isLoading = false;
      });
    } else {
      ConfirmOrder confirmOrder = await OrderService.createorder(
          setItemlins(widget.items),
          id.toString(),
          addressList[checkboxValueA].city,
          addressList[checkboxValueA].addres1,
          phone,
          name,
          addressList[checkboxValueA].Country,
          email,
          PaymentList[checkboxValueB].id,
          PaymentList[checkboxValueB].title,
          copon==0?null:code);
      if (confirmOrder == null) {
        final snackbar = SnackBar(
          content: Text(getTransrlate(context, 'OrderError')),
        );
        setState(() {
          _isLoading = false;
        });
        scaffoldKey.currentState.showSnackBar(snackbar);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => DetailScreen(confirmOrder)),
            ModalRoute.withName("/home"));
      }
    }
  }
  Future fetchUserId() async {
    email = await SharedPreferencesHelper.getEmail();
    name = await SharedPreferencesHelper.getname();
    username = await SharedPreferencesHelper.getUserimage();
    name = await SharedPreferencesHelper.getname();
    id = await SharedPreferencesHelper.getUserId();
    phone = await SharedPreferencesHelper.getphone();
  }

  List<LineItems> setItemlins(List<Cart> items) {
    List<LineItems> item = new List<LineItems>();
    for (int i = 0; i <= items.length - 1; i++) {
      if (items[i].idVariation != null) {
        item.add(new LineItems(
          productId: items[i].id,
          quantity: items[i].quantity,
          variationId: items[i].idVariation,
        ));
      } else {
        item.add(
            new LineItems(productId: items[i].id, quantity: items[i].quantity));
      }
      print(items[i].idVariation);
    }
    return item;
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    checkboxValueA = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewAddressPage()),
    );
    updateListView();
  }
}
