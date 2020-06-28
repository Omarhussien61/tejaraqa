import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/utils/commons/colors.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));
    return Scaffold(
//      appBar: buildAppBar(),
      backgroundColor: greyBackground,
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 4),
        child: ListView(
          children: <Widget>[
            contactItem("E Mail", "rosen@gmail.com", "rosen@gmail.com"),
            contactItem("E Mail", "rosen@gmail.com", "rosen@gmail.com"),
            contactItem("E Mail", "rosen@gmail.com", "rosen@gmail.com"),
            contactItem("E Mail", "rosen@gmail.com", "rosen@gmail.com"),
            contactItem("E Mail", "rosen@gmail.com", "rosen@gmail.com"),
            contactItem("E Mail", "rosen@gmail.com", "rosen@gmail.com"),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(themeColor) {
    return AppBar(
      brightness: Brightness.light,
      elevation: 0,
      centerTitle: true,
      title: Text(
        "Contact",
        style: GoogleFonts.poppins(
            color: themeColor.getColor(), fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      leading: Icon(
        Icons.chevron_left,
        color: themeColor.getColor(),
      ),
    );
  }

  Container contactItem(
      String title, String description, String secondDescription) {
    return Container(
      margin: EdgeInsets.only(bottom: 16, left: 8, right: 8, top: 8),
      height: 84,
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
            Text(
              title,
              style: GoogleFonts.poppins(color: Color(0xFF707070)),
            ),
            RichText(
              text: TextSpan(
                text: description,
                style: GoogleFonts.poppins(
                    color: textColor, fontWeight: FontWeight.w400),
              ),
            ),
            RichText(
              text: TextSpan(
                text: secondDescription,
                style: GoogleFonts.poppins(color: textColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
