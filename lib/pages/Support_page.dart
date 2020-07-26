import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:provider/provider.dart';

class SupportPage extends StatefulWidget {
  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));
    final ThemeData themeData = Theme.of(context);
    final themeColor = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: buildAppBar(themeColor),
      backgroundColor: greyBackground,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              color:themeData.primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Image.network('https://d2.woo2.app/wp-content/uploads/2020/07/rosen.png'),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: themeData.dividerColor,
                      ),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('00966126505049'),
                                      Text(
                                        getTransrlate(context, 'phone'),
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    _launchURL('sms:00966126573988');
                                  },
                                  child: SizedBox(
                                    child: Icon(
                                      Icons.message,
                                      color: themeData.primaryColor,
                                    ),
                                    height: 60,
                                    width: 60,
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    InkWell(
                                      child: SizedBox(
                                        child: Icon(
                                          Icons.call,
                                          color: themeData.primaryColor,
                                        ),
                                        height: 60,
                                      ),
                                      onTap: (){
                                        _launchURL('tel:00966126505049');
                                      },
                                    )
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.start,
                                ),

                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('00966126573988'),
                                      Text(
                                        getTransrlate(context, 'phone'),
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  child: InkWell(
                                    onTap: (){
                                      _launchURL('sms:00966126573988');

                                    },
                                    child: Icon(
                                      Icons.message,
                                      color: themeData.primaryColor,
                                    ),
                                  ),
                                  height: 60,
                                  width: 60,
                                ),
                                Column(
                                  children: <Widget>[
                                    InkWell(
                                      onTap: (){
                                        _launchURL('tel:00966126573988');
                                      },
                                      child: SizedBox(
                                        child: Icon(
                                          Icons.call,
                                          color: themeData.primaryColor,
                                        ),
                                        height: 60,
                                      ),
                                    )
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.start,
                                ),

                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: IntrinsicHeight(
                child: Expanded(
                  flex: 4,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              Text('info@7lsoft.com'),
                              Text(
                                getTransrlate(context, 'Email'),
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),

                            ],
                          )),
                          InkWell(
                            onTap: (){
                              _launchURL('mailto:info@7lsoft.com');
                            },
                            child: SizedBox(
                              child: Icon(
                                Icons.email,
                                color: themeData.primaryColor,
                              ),
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              Text('info@7lsoft.com'),
                              Text(
                                getTransrlate(context, 'Email'),
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),

                            ],
                          )),
                          InkWell(
                            onTap: (){
                              _launchURL('mailto:info@7lsoft.com');
                            },
                            child: SizedBox(
                              child: Icon(
                                Icons.email,
                                color: themeData.primaryColor,
                              ),
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
        getTransrlate(context, 'Support'),
        style: GoogleFonts.poppins(
            color: themeColor.getColor(), fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
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
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
