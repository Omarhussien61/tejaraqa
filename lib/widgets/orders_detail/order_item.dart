import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/modal/Orders_model.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';
import  'package:persian_number_utility/persian_number_utility.dart';

class OrderItem extends StatelessWidget {
  final Orders_model orders_model;


  OrderItem({Key key,this.orders_model, ThemeNotifier themeColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    return Container(
      margin: EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 16),
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
      width: ScreenUtil.getWidth(context) / 1.25,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AutoSizeText(
                  getTransrlate(context, 'OrderDitails')+' : '+orders_model.number,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Color(0xFF5D6A78),
                    fontWeight: FontWeight.w300,
                  ),
                  maxLines: 2,
                  minFontSize: 11,
                ),
                SizedBox(
                  height: 2,
                ),
                AutoSizeText(
                  getTransrlate(context, 'paymentMethod')+' : '+ isPymentString(orders_model.paymentMethod,context),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Color(0xFF5D6A78),
                    fontWeight: FontWeight.w300,
                  ),
                  maxLines: 2,
                  minFontSize: 11,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  getTransrlate(context, 'totalOrder')+' : '+orders_model.total +" "+orders_model.currencySymbol,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Color(0xFF5D6A78),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Text(getTransrlate(context, 'OrderState')+' : ',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Color(0xFF5D6A78),
                          fontWeight: FontWeight.w300,
                        ),),
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3),
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
                        child: Row(
                          children: <Widget>[
                            Text(
                              themeColor.local=='ar'? isPassedString(orders_model.status):orders_model.status,
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF5D6A78),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              isPassedIcon(orders_model.status),
                              size: 12,
                              color:  isPassed(orders_model.status),
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            Container(
              margin: EdgeInsets.only(left: 8, right: 8),
              child: ExpandablePanel(
//                  hasIcon: true,
//                  iconColor: themeColor.getColor(),
//                  headerAlignment: ExpandablePanelHeaderAlignment.center,
//                  iconPlacement: ExpandablePanelIconPlacement.right,
                header: Text(
                  getTransrlate(context, 'OrderContent'),
                  style: GoogleFonts.poppins(
                      color: Color(0xFF5D6A78), fontSize: 12),
                ),
                expanded: Container(
                  height:30*orders_model.lineItems.length.toDouble() ,
                  child: ListView.builder(
                    itemCount: orders_model.lineItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding:  EdgeInsets.only(right: 7,left: 10,top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              orders_model.lineItems[index].name,
                              style: TextStyle(
                                  color: themeColor.getColor(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            Text(orders_model.lineItems[index].quantity.toString()+' × '+orders_model.lineItems[index].total,
                              style: TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Color isPassed(String value) {
    switch (value) {
      case 'pending':
        return Colors.amber;
        break;
      case 'completed':
        return Colors.green;
        break;
      case 'processing':
        return Colors.red;
        break;
      default:
        return Colors.blue;
    }
  }
  String isPassedString(String value) {
    switch (value) {
      case 'pending':
        return 'الطلب معلق';
        break;
      case 'completed':
        return 'الطلب مكتمل';
        break;
      case 'processing':
        return 'الطلب تتم معالجتة';
        break;
      default:
        return 'الطلب قيد التنفيذ';
    }
  }
  String isPymentString(String value,BuildContext context) {
    switch (value) {
      case 'bacs':
        return getTransrlate(context, 'bacs');
        break;
      case 'cod':
        return getTransrlate(context, 'cod');
        break;
      case 'paypal':
        return getTransrlate(context, 'paypal');
        break;
      default:
        return 'الطلب قيد التنفيذ';
    }
  }

  IconData isPassedIcon(String value) {
    switch (value) {
      case 'pending':
        return Icons.sync_problem;
        break;
      case 'completed':
        return Icons.done;
        break;
      case 'processing':
        return Icons.sync;
        break;
      default:
        return Icons.sync;
    }
  }

}

openAlertBox(context, themeColor) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 300.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 32,
                ),
                Text("Rate",
                    style: GoogleFonts.poppins(color: Color(0xFF5D6A78))),
                SizedBox(
                  height: 16,
                ),
                RatingBar(
                  initialRating: 3,
                  itemSize: 22.0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => Container(
                    height: 12,
                    child: SvgPicture.asset(
                      "assets/icons/ic_star.svg",
                      color: Colors.red,
                      width: 9,
                    ),
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Text("You gave 4 points",
                    style: GoogleFonts.poppins(
                        fontSize: 13, color: Color(0xFF5D6A78))),
                SizedBox(
                  height: 32,
                ),
                Container(
                  width: 260,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: themeColor.getColor(),
                    child: Text(
                      "Rate",
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        );
      });


}
