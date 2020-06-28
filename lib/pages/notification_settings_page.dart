import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

class NotificationSettingsPage extends StatefulWidget {
  @override
  _NotificationSettingsPageState createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool isAllNotifications = false;
  bool isOrderNotifications = true;
  bool isFaqNotifications = true;
  bool isReminderNotifications = true;
  bool isShoppingCartReminderNotifications = true;
  bool isDiscountReminderNotifications = true;
  bool isCustomizeUserDiscountReminderNotifications = true;
  bool isUpdateReminderNotifications = true;

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
        body: Container(
          padding: EdgeInsets.only(left: 0, right: 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 16, top: 24),
                  child: Text(
                    "My address",
                    style: GoogleFonts.poppins(
                        fontSize: 18, color: Color(0xFF5D6A78)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16),
                  width: 28,
                  child: Divider(
                    color: themeColor.getColor(),
                    height: 3,
                    thickness: 2,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(6),
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      SwitchListTile(
                        onChanged: (bool value) {
                          setState(() {
                            isAllNotifications = !isAllNotifications;
                          });
                        },
                        value: isAllNotifications,
                        title: Text(
                          "Allow Notifications",
                          style: GoogleFonts.poppins(
                            color: Color(0xFF5D6A78),
                          ),
                        ),
                        activeColor: themeColor.getColor(),
                      ),
                      SwitchListTile(
                        onChanged: (bool value) {
                          setState(() {
                            isOrderNotifications = !isOrderNotifications;
                          });
                        },
                        value: isOrderNotifications,
                        title: Text(
                          "Order",
                          style: GoogleFonts.poppins(
                            color: Color(0xFF5D6A78),
                          ),
                        ),
                        subtitle: Text(
                          "Keep Track of Your Time Order",
                          style: GoogleFonts.poppins(
                              color: Color(0xFF5D6A78),
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                        activeColor: themeColor.getColor(),
                      ),
                      SwitchListTile(
                        onChanged: (bool value) {
                          setState(() {
                            isFaqNotifications = !isOrderNotifications;
                          });
                        },
                        value: isFaqNotifications,
                        title: Text(
                          "Store Q & A",
                          style: GoogleFonts.poppins(
                            color: Color(0xFF5D6A78),
                          ),
                        ),
                        subtitle: Text(
                          "Easy Communication With Dry Store",
                          style: GoogleFonts.poppins(
                              color: Color(0xFF5D6A78),
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                        activeColor: themeColor.getColor(),
                      ),
                      SwitchListTile(
                        onChanged: (bool value) {
                          setState(() {
                            isReminderNotifications = !isReminderNotifications;
                          });
                        },
                        value: isReminderNotifications,
                        title: Text(
                          "Reminder Cart",
                          style: GoogleFonts.poppins(
                            color: Color(0xFF5D6A78),
                          ),
                        ),
                        subtitle: Text(
                          "Shopping Cart Reminder",
                          style: GoogleFonts.poppins(
                              color: Color(0xFF5D6A78),
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                        activeColor: themeColor.getColor(),
                      ),
                      SwitchListTile(
                        onChanged: (bool value) {
                          setState(() {
                            isShoppingCartReminderNotifications =
                                !isShoppingCartReminderNotifications;
                          });
                        },
                        value: isShoppingCartReminderNotifications,
                        title: Text(
                          "Opportunities and Campaigns",
                          style: GoogleFonts.poppins(
                            color: Color(0xFF5D6A78),
                          ),
                        ),
                        subtitle: Text(
                          "Benefit from Mobile Special Offer",
                          style: GoogleFonts.poppins(
                              color: Color(0xFF5D6A78),
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                        activeColor: themeColor.getColor(),
                      ),
                      SwitchListTile(
                        onChanged: (bool value) {
                          setState(() {
                            isDiscountReminderNotifications =
                                !isDiscountReminderNotifications;
                          });
                        },
                        value: isDiscountReminderNotifications,
                        title: Text(
                          "Special Benefits for Persons",
                          style: GoogleFonts.poppins(
                            color: Color(0xFF5D6A78),
                          ),
                        ),
                        subtitle: Text(
                          "You Special Discounts",
                          style: GoogleFonts.poppins(
                              color: Color(0xFF5D6A78),
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                        activeColor: themeColor.getColor(),
                      ),
                      SwitchListTile(
                        onChanged: (bool value) {
                          setState(() {
                            isCustomizeUserDiscountReminderNotifications =
                                !isCustomizeUserDiscountReminderNotifications;
                          });
                        },
                        value: isCustomizeUserDiscountReminderNotifications,
                        title: Text(
                          "Updates",
                          style: GoogleFonts.poppins(
                            color: Color(0xFF5D6A78),
                          ),
                        ),
                        subtitle: Text(
                          "Notify Me of New Features",
                          style: GoogleFonts.poppins(
                              color: Color(0xFF5D6A78),
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                        activeColor: themeColor.getColor(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
