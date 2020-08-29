import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

class ProductListTitleBar extends StatelessWidget {
  const ProductListTitleBar({
    Key key,
    @required this.themeColor,
    this.title,
    this.isCountShow,
  }) : super(key: key);

  final ThemeNotifier themeColor;
  final String title;
  final bool isCountShow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding:  EdgeInsets.only(left: 12, right: 12,),
            child: Text(
              title,
              style: GoogleFonts.cairo(
                fontSize: 15,
                color: Color(0xFF5D6A78),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          !this.isCountShow
              ? Container()
              : Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 6, bottom: 6),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.2),
                          blurRadius: 5.0, // soften the shadow
                          spreadRadius: 0.0, //extend the shadow
                          offset: Offset(
                            0.0, // Move to right 10  horizontally
                            3.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ]),
                  child: CountdownTimer(
                    endTime: 1594829147719,
                    defaultDays: "==",
                    defaultHours: "--",
                    defaultMin: "**",
                    defaultSec: "++",
                    daysSymbol: "",
                    hoursSymbol: ":",
                    minSymbol: ":",
                    secSymbol: "",
                    textStyle: GoogleFonts.cairo(
                      fontSize: 12,
                      color: themeColor.getColor(),
                      fontWeight: FontWeight.w300,
                    ),
                  ))
        ],
      ),
    );
  }
}
