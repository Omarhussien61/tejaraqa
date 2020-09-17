import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/modal/contact_model.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';
import 'package:shoppingapp/widgets/commons/shadow_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/service/information_servics.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {



  final _formKey = GlobalKey<FormState>();


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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Image.network('https://tejaraqa.com/wp-content/uploads/2020/08/1-e1598682256275.png'),
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
                                      Text('0097477377735'),
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
                                    _launchURL('sms:'+'0097477377735');
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
                                        _launchURL('tel:'+'0097477377735');
                                      },
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
                              Text('T.jara@hotmail.com'),
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
                              _launchURL('mailto:'+'T.jara@hotmail.com');
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: themeColor.getColor(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              getTransrlate(context, 'Contact'),
                              style: GoogleFonts.cairo(
                                fontSize: 17,
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: const Icon(Icons.person),
                                title: new TextField(
                                  decoration: new InputDecoration(
                                    hintText: getTransrlate(context, 'name'),
                                      hintStyle:  GoogleFonts.cairo(color: textColor)

                                  ),
                                ),
                              ),
                              ListTile(
                                leading: const Icon(Icons.phone),
                                title: new TextField(
                                  decoration: new InputDecoration(
                                    hintText: getTransrlate(context, 'phone'),
                                      hintStyle:  GoogleFonts.cairo(color: textColor)

                                  ),
                                ),
                              ),
                              ListTile(
                                leading: const Icon(Icons.email),
                                title: new TextField(
                                  decoration: new InputDecoration(
                                    hintText: getTransrlate(context, 'Email'),
                                      hintStyle:  GoogleFonts.cairo(color: textColor)

                                  ),
                                ),
                              ),
                              ListTile(
                                leading: const Icon(Icons.edit),
                                title: new TextField(
                                  decoration: new InputDecoration(
                                    hintText: getTransrlate(context, 'Content'),
                                    hintStyle:  GoogleFonts.cairo(color: textColor)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          height: 42,
                          width: ScreenUtil.getWidth(context)/2,
                          margin: EdgeInsets.only(top: 20, bottom: 12),
                          child: ShadowButton(
                            borderRadius: 12,
                            height: 40,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(8.0),
                              ),
                              color: themeColor.getColor(),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                //  setState(() => _isLoading = true);
                                }
                              },
                              child: Text(
                                getTransrlate(context, 'Submit'),
                                style: GoogleFonts.cairo(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  getTransrlate(context, 'ThankYou'),
                  style: GoogleFonts.cairo(
                    fontSize: 17,
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
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
          getTransrlate(context, 'Contact'),
        style: GoogleFonts.cairo(
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
              style: GoogleFonts.cairo(color: Color(0xFF707070)),
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
                style: GoogleFonts.cairo(color: textColor),
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
