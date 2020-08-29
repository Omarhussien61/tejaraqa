import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shoppingapp/pages/address_page.dart';
import 'package:shoppingapp/pages/change_password_page.dart';
import 'package:shoppingapp/pages/edit_user_info_page.dart';
import 'package:shoppingapp/pages/login_page.dart';
import 'package:shoppingapp/pages/notification_settings_page.dart';
import 'package:shoppingapp/utils/commons/add_favorite.dart';
import 'package:shoppingapp/utils/commons/show_dialog.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';

class MyProfileSettings extends StatefulWidget {
  @override
  _MyProfileSettingsState createState() => _MyProfileSettingsState();
}

class _MyProfileSettingsState extends State<MyProfileSettings> {
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Color(0xFFFCFCFC),
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFCFCFC),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 24,right: 8),
                child: Row(
                  children: [
                    InkWell(
                      onTap:() {Navigator.pop(context);},
                      child: Icon(
                        Icons.chevron_left,
                        color: Colors.grey,
                        size: 32,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getTransrlate(context, 'ProfileSettings'),
                          style: GoogleFonts.cairo(
                              fontSize: 18, color: Color(0xFF5D6A78)),
                        ),
                        Container(
                            width: 28,
                            child: Divider(
                              color: themeColor.getColor(),
                              height: 3,
                              thickness: 2,
                            )),

                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),

              ListTile(
                onTap: () {
                  Nav.route(context, EditUserInfoPage());
                },
                leading: Image.asset(
                  "assets/icons/ic_user.png",
                  width: 22,
                ),
                title: Text(getTransrlate(context, 'MyProfileInfo'),
                    style: GoogleFonts.cairo(
                        fontSize: 15, color: Color(0xFF5D6A78))),
              ),
              SizedBox(
                height: 16,
              ),
              ListTile(
                onTap: () {
                  themeColor.isLogin? Nav.route(context, ChangePasswordPage()):
                  showLogintDialog(getTransrlate(context, 'login'), getTransrlate(context, 'notlogin'),context);
                },
                leading: Image.asset(
                  "assets/icons/ic_lock.png",
                  width: 22,
                ),
                title: Text(getTransrlate(context, 'changePassword'),
                    style: GoogleFonts.cairo(
                        fontSize: 15, color: Color(0xFF5D6A78))),
              ),
              SizedBox(
                height: 16,
              ),
              ListTile(
                onTap: () {
                  Nav.route(context, AddressPage());
                },
                leading: Image.asset(
                  "assets/icons/ic_location.png",
                  width: 22,
                ),
                title: Text(getTransrlate(context,'MyAddress'),
                    style: GoogleFonts.cairo(
                        fontSize: 15, color: Color(0xFF5D6A78))),
              ),
              SizedBox(
                height: 16,
              ),
              ListTile(
                onTap: () {
                  Nav.route(context, NotificationSettingsPage());
                },
                leading: Image.asset(
                  "assets/icons/ic_notification.png",
                  width: 22,
                ),
                title: Text(getTransrlate(context, 'Notification'),
                    style: GoogleFonts.cairo(
                        fontSize: 15, color: Color(0xFF5D6A78))),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
