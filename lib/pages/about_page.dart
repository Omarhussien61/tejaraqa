import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/modal/about_model.dart';
import 'package:shoppingapp/service/information_servics.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/commons/text.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/statusbar.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  about_model about;

  @override
  void initState() {
    information_service.get_about().then((value) {
      setState(() {
        about=value;
      });
    });    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    StatusBarConfig.setStatusbarConfig(Colors.white, Brightness.dark);
    return Scaffold(
      appBar: buildAppBar(themeColor),
      backgroundColor: greyBackground,
      body:  SingleChildScrollView(
        child:  about==null?Center(child: CircularProgressIndicator()): Column(
          children: <Widget>[
            Container(
              color: themeColor.getColor(),

              child: Image.network(about.image,
              height: ScreenUtil.getHeight(context)/4,
              fit: BoxFit.contain),
            ),
            aboutItem(about.item1[0],about.item1[1],about.item1[2]),

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
        text: getTransrlate(context, 'About'),
        color: themeColor.getColor(),
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: whiteColor,
      leading: InkWell(
        onTap: (){
          Navigator.pop(context);
        },
        child: Icon(
          Icons.chevron_left,
          color: themeColor.getColor(),
        ),
      ),
    );
  }

  Widget aboutItem(String title, String description, String secondDescription) {
    return Container(
      margin: EdgeInsets.only(bottom: 16, left: 8, right: 8, top: 8),
      height: ScreenUtil.getHeight(context)/6,
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
        padding: EdgeInsets.only(left: 12, top: 6,right: 12, bottom: 6),
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
                style: GoogleFonts.cairo(
                    color: textColor, fontWeight: FontWeight.w400),
              ),
            ),
            RichText(
              text: TextSpan(
                text: secondDescription,
                style: GoogleFonts.cairo(
                    color: textColor, fontWeight: FontWeight.w200),
              ),
            ),

          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }



}
