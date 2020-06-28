import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

class RoundedTabBar extends StatefulWidget {
  final ThemeNotifier themeColor;

  RoundedTabBar({this.themeColor});

  @override
  _RoundedTabBarState createState() => _RoundedTabBarState();
}

class _RoundedTabBarState extends State<RoundedTabBar> {
  bool isAllSelect = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: ScreenUtil.getWidth(context) - 48,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey[200],
                blurRadius: 5.0,
                spreadRadius: 1,
                offset: Offset(0.0, 1)),
          ]),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                isAllSelect = true;
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 150),
              height: 48,
              width: (ScreenUtil.getWidth(context) - 48) / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color:
                    isAllSelect ? widget.themeColor.getColor() : Colors.white,
              ),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "All",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: isAllSelect ? Colors.white : Color(0xFF5D6A78),
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                isAllSelect = false;
              });
            },
            child: AnimatedContainer(
                curve: Curves.decelerate,
                duration: Duration(milliseconds: 150),
                height: 48,
                width: (ScreenUtil.getWidth(context) - 48) / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: !isAllSelect
                      ? widget.themeColor.getColor()
                      : Colors.white,
                ),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Discount",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: !isAllSelect ? Colors.white : Color(0xFF5D6A78),
                        fontWeight: FontWeight.w600,
                      ),
                    ))),
          )
        ],
      ),
    );
  }
}
