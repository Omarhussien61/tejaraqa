import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/commons/text.dart';
import 'package:shoppingapp/utils/statusbar.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    StatusBarConfig.setStatusbarConfig(Colors.white, Brightness.dark);
    return Scaffold(
//      appBar: buildAppBar(themeColor),
      backgroundColor: greyBackground,
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 4),
        child: ListView(
          children: <Widget>[
            aboutItem(
                "Ubi est azureus mortem?",
                "Valebat, racana, et hippotoxota. Valebat, racana, et hippotoxota. Valebat, racana, et hippotoxota.",
                "rosen@gmail.com"),
            aboutItem(
                "Ubi est azureus mortem?",
                "Valebat, racana, et hippotoxota. Valebat, racana, et hippotoxota. Valebat, racana, et hippotoxota.",
                "rosen@gmail.com"),
            aboutItem(
                "Ubi est azureus mortem?",
                "Valebat, racana, et hippotoxota. Valebat, racana, et hippotoxota. Valebat, racana, et hippotoxota.",
                "rosen@gmail.com"),
            aboutItem(
                "Ubi est azureus mortem?",
                "Valebat, racana, et hippotoxota. Valebat, racana, et hippotoxota. Valebat, racana, et hippotoxota.",
                "rosen@gmail.com"),
            aboutItem(
                "Ubi est azureus mortem?",
                "Valebat, racana, et hippotoxota. Valebat, racana, et hippotoxota. Valebat, racana, et hippotoxota.",
                "rosen@gmail.com"),
            aboutItem(
                "Ubi est azureus mortem?",
                "Valebat, racana, et hippotoxota. Valebat, racana, et hippotoxota. Valebat, racana, et hippotoxota.",
                "rosen@gmail.com"),
            aboutItem(
                "Ubi est azureus mortem?",
                "Valebat, racana, et hippotoxota. Valebat, racana, et hippotoxota. Valebat, racana, et hippotoxota.",
                "rosen@gmail.com"),
            aboutItem(
                "Ubi est azureus mortem?",
                "Valebat, racana, et hippotoxota. Valebat, racana, et hippotoxota. Valebat, racana, et hippotoxota.",
                "rosen@gmail.com"),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(ThemeNotifier themeColor) {
    return AppBar(
      brightness: Brightness.light,
      elevation: 0,
      centerTitle: true,
      title: CustomText(
        text: "Hakkımızda",
        color: themeColor.getColor(),
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: whiteColor,
      leading: Icon(
        Icons.chevron_left,
        color: themeColor.getColor(),
      ),
    );
  }

  Widget aboutItem(String title, String description, String secondDescription) {
    return Container(
      margin: EdgeInsets.only(bottom: 16, left: 8, right: 8, top: 8),
      height: 96,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.2),
              blurRadius: 9.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: Offset(
                0.0, // Move to right 10  horizontally
                1.0, // Move to bottom 10 Vertically
              ),
            )
          ]),
      child: Container(
        padding: EdgeInsets.only(left: 12, top: 6, bottom: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            CustomText(
              text: title,
              color: subTextColor,
            ),
            RichText(
              text: TextSpan(
                text: description,
                style: GoogleFonts.poppins(
                    color: textColor, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
