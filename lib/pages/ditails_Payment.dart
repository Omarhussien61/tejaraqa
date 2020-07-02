
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/modal/ConfirmOrder.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

import '../main.dart';
import 'home_page.dart';


class DetailScreen extends StatelessWidget {
ConfirmOrder confirmOrder;
double deviceHeight;
double deviceWidth;
DetailScreen(this.confirmOrder);

@override
  Widget build(BuildContext context) {
  deviceHeight = MediaQuery.of(context).size.height;
  deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 36,
              right: 20,
              child: GestureDetector(
                  onTap: () =>Nav.routeReplacement(context, InitPage()),

                  child: Icon(Icons.close,color:
                  Provider.of<ThemeNotifier>(context).getColor(),)),
            ),
            Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 101,
                      height: 101,
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.all(Radius.circular(50.5)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 31,
                            child: Icon(Icons.check,size: deviceHeight/20,
                              color: Provider.of<ThemeNotifier>(context).getColor(),),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'Order Done',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Provider.of<ThemeNotifier>(context).getColor(),
                              fontWeight: FontWeight.w400,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top: 30),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: Icon(
                                  Icons.check_circle,
                                  color:Provider.of<ThemeNotifier>(context).getColor(),
                                  size: deviceHeight/20,
                                ),
                                title: Text(
                                  'total Shipping',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                                subtitle: Text(
                                  'Txn ID:'+confirmOrder.id.toString(),
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0),
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Text(
                                    setTotal().toString()+confirmOrder.currencySymbol,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0),
                                  ),
                                ),
                              ),
                              Container(
                                width: 300.0,
                                height: 1.0,
                                color: Colors.grey,
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.check_circle,
                                  color:Provider.of<ThemeNotifier>(context).getColor(),
                                  size: deviceHeight/20,
                                ),
                                title: Text(
                                  'total Order',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                                subtitle: Text(
                                  'Txn ID: '+confirmOrder.shippingLines[0].id.toString(),
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0),
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Text(
                                    confirmOrder.shippingTotal+confirmOrder.currencySymbol,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0),
                                  ),
                                ),
                              ),
                              Container(
                                width: 300.0,
                                height: 1.0,
                                color: Colors.grey,
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.check_circle,
                                  color:Provider.of<ThemeNotifier>(context).getColor(),
                                  size: deviceHeight/20,
                                ),
                                title: Text(
                                  'total',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Text(
                                    confirmOrder.total+confirmOrder.currencySymbol,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),

                ],
              ),
            ),
          ],
        ),
      )
    );
  }
  setTotal(){
    var shippingTotal = double.parse(confirmOrder.shippingTotal);
    assert(shippingTotal is double);
    var total = double.parse(confirmOrder.total);
    assert(total is double);
    double totals=total-shippingTotal;
    return totals;
  }
}


