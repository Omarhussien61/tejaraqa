import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shoppingapp/main.dart';
import 'package:shoppingapp/pages/FAQ.dart';
import 'package:shoppingapp/pages/about_page.dart';
import 'package:shoppingapp/pages/change_password_page.dart';
import 'package:shoppingapp/pages/contact_page.dart';
import 'package:shoppingapp/pages/Support_page.dart';
import 'package:shoppingapp/pages/login_page.dart';
import 'package:shoppingapp/pages/profile_settings_page.dart';
import 'package:shoppingapp/utils/commons/add_favorite.dart';
import 'package:shoppingapp/utils/commons/show_dialog.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';
import 'package:shoppingapp/utils/util/shared_preferences_helper.dart';
import 'package:shoppingapp/utils/drawer_menu/simple_hidden_drawer/animated_drawer_content.dart';
import 'package:shoppingapp/utils/drawer_menu/simple_hidden_drawer/provider/simple_hidden_drawer_provider.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

import '../../theme_change.dart';
import 'item_hidden_menu.dart';
import 'item_hidden_menu_right.dart';

// ignore: must_be_immutable
class HiddenMenu extends StatefulWidget {
  /// Decocator that allows us to add backgroud in the menu(img)
  final DecorationImage background;

  /// that allows us to add shadow above menu items
  final bool enableShadowItensMenu;

  /// that allows us to add backgroud in the menu(color)
  final Color backgroundColorMenu;

  /// Items of the menu
  final List<ItemHiddenMenu> itens;

  List<ItemHiddenMenu> itemsSecondSection;

  /// Callback to recive item selected for user
  final Function(int) selectedListern;

  /// position to set initial item selected in menu
  final int initPositionSelected;

  final TypeOpen typeOpen;

  HiddenMenu(
      {Key key,
      this.background,
      this.itens,
      this.selectedListern,
      this.initPositionSelected,
      this.backgroundColorMenu,
      this.enableShadowItensMenu = false,
      this.typeOpen})
      : super(key: key);

  @override
  _HiddenMenuState createState() => _HiddenMenuState();
}

class _HiddenMenuState extends State<HiddenMenu> {
  int _indexSelected;
  bool isconfiguredListern = false;
  int id;
  String username, name, last, photo;
  final facebookLogin = FacebookLogin();
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future fetchUserId() async {
    id = await SharedPreferencesHelper.getUserId();
    username = await SharedPreferencesHelper.getEmail();
    name = await SharedPreferencesHelper.getname();
    last = await SharedPreferencesHelper.getLast_name();
    photo = await SharedPreferencesHelper.getUserimage();
  }

  @override
  void initState() {
    fetchUserId();
    _indexSelected = widget.initPositionSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    ThemeChanger _themeChanger = ThemeChanger(context);

    if (!isconfiguredListern) {
      confListern();
      isconfiguredListern = true;
    }

    return Scaffold(
      body: Container(
        height: ScreenUtil.getHeight(context),
        decoration: BoxDecoration(
          color: themeColor.getColor(),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 36,
              ),
              ListTile(
                title: Text(
                  name == null ? 'user' : name + ' ' + last,
                  style: GoogleFonts.cairo(color: Colors.white),
                ),
                leading: CircleAvatar(
                    radius: 20,
                    backgroundImage: CachedNetworkImageProvider(
                      photo == null
                          ? 'https://p.kindpng.com/picc/s/207-2074624_white-gray-circle-avatar-png-transparent-png.png'
                          : photo,
                    )),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 20.0,
                ),
                decoration: BoxDecoration(
                    boxShadow: widget.enableShadowItensMenu
                        ? [
                            new BoxShadow(
                              color: const Color(0x44000000),
                              offset: const Offset(0.0, 5.0),
                              blurRadius: 50.0,
                              spreadRadius: 30.0,
                            ),
                          ]
                        : []),
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (scroll) {
                    scroll.disallowGlow();
                    return false;
                  },
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0.0),
                      itemCount: widget.itens.length,
                      itemBuilder: (context, index) {
                        if (widget.typeOpen == TypeOpen.FROM_LEFT) {
                          return ItemHiddenMenu(
                            name: widget.itens[index].name,
                            icon: widget.itens[index].icon,
                            selected: index == _indexSelected,
                            colorLineSelected:
                                widget.itens[index].colorLineSelected,
                            baseStyle: widget.itens[index].baseStyle,
                            selectedStyle: widget.itens[index].selectedStyle,
                            onTap: () {
                              if (widget.itens[index].onTap != null) {
                                widget.itens[index].onTap();
                              }
                              SimpleHiddenDrawerProvider.of(context)
                                  .setSelectedMenuPosition(index);
                            },
                          );
                        } else {
                          return ItemHiddenMenuRight(
                            name: widget.itens[index].name,
                            selected: index == _indexSelected,
                            colorLineSelected:
                                widget.itens[index].colorLineSelected,
                            baseStyle: widget.itens[index].baseStyle,
                            selectedStyle: widget.itens[index].selectedStyle,
                            onTap: () {
                              SimpleHiddenDrawerProvider.of(context)
                                  .setSelectedMenuPosition(index);
                            },
                          );
                        }
                      }),
                ),
              ),
              Container(
                  height: 28,
                  margin: EdgeInsets.only(left: 24, right: 48),
                  child: Divider(
                    color: Colors.white.withOpacity(0.5),
                  )),
              Container(
                padding: EdgeInsets.only( right: 20),

                decoration: BoxDecoration(
                    boxShadow: widget.enableShadowItensMenu
                        ? [
                            new BoxShadow(
                              color: const Color(0x44000000),
                              offset: const Offset(0.0, 5.0),
                              blurRadius: 50.0,
                              spreadRadius: 30.0,
                            ),
                          ]
                        : []),
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (scroll) {
                    scroll.disallowGlow();
                    return false;
                  },
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(0.0),
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          themeColor.isLogin
                              ? _navigateAndDisplaySelection(context)
                              : showLogintDialog(
                                  getTransrlate(context, 'login'),
                                  getTransrlate(context, 'notlogin'),
                                  context);
                        },
                        child: ItemHiddenMenu(
                          icon: Icon(
                            Feather.user,
                            size: 25,
                            color: Colors.white,
                          ),
                          name: getTransrlate(context, 'ProfileSettings'),
                         selectedStyle:GoogleFonts.cairo(
                             color: Colors.white.withOpacity(0.6),
                             fontSize: 19.0) ,

                          baseStyle: GoogleFonts.cairo(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 19.0),
                          colorLineSelected: Colors.orange,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Provider.of<ThemeNotifier>(context).local == 'ar'
                              ? Provider.of<ThemeNotifier>(context)
                                  .setLocal('en')
                              : Provider.of<ThemeNotifier>(context)
                                  .setLocal('ar');
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InitPage()),
                              ModalRoute.withName("/home"));
                        },
                        child: ItemHiddenMenu(
                          icon: Icon(
                            Icons.language,
                            size: 25,
                            color: Colors.white,
                          ),
                          name:
                              Provider.of<ThemeNotifier>(context).local == 'ar'
                                  ? 'EN'
                                  : 'AR',
                          baseStyle: GoogleFonts.cairo(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 19.0),
                          colorLineSelected: Colors.orange,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Nav.route(context, FaqPage());
                        },
                        child: ItemHiddenMenu(
                          icon: Icon(
                            Icons.question_answer,
                            size: 25,
                            color: Colors.white,
                          ),
                          name: getTransrlate(context, 'FAQ'),
                          baseStyle: GoogleFonts.cairo(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 19.0,
                              fontWeight: FontWeight.w200),
                          colorLineSelected: Colors.orange,
                        ),
                      ),
                      InkWell(
                        child: ItemHiddenMenu(
                          icon: Icon(
                            Feather.list,
                            size: 22,
                            color: Colors.white,
                          ),
                          name: getTransrlate(context, 'About'),
                          baseStyle: GoogleFonts.cairo(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 19.0),
                          colorLineSelected: Colors.orange,
                        ),
                        onTap: () {
                          Nav.route(context, AboutPage());
                        },
                      ),
                      InkWell(
                        child: ItemHiddenMenu(
                          icon: Icon(
                            Feather.clock,
                            size: 25,
                            color: Colors.white,
                          ),
                          name: getTransrlate(context, 'Support'),
                          baseStyle: GoogleFonts.cairo(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 19.0),
                          colorLineSelected: Colors.orange,
                        ),
                        onTap: () {
                          Nav.route(context, SupportPage());
                        },
                      ),
                      InkWell(
                        onTap: () {
                          Nav.route(context, ContactPage());
                        },
                        child: ItemHiddenMenu(
                          icon: Icon(
                            Icons.call,
                            size: 25,
                            color: Colors.white,
                          ),
                          name: getTransrlate(context, 'Contact'),
                          baseStyle: GoogleFonts.cairo(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 19.0,
                              fontWeight: FontWeight.w200),
                          colorLineSelected: Colors.orange,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (!themeColor.config_model.login) {
                            show_Dialog(context);
                          } else {
                            if (themeColor.isLogin == false) {
                              themeColor.config_model.login?
                                Nav.route(context, LoginPage()):show_Dialog(context);
                            } else {
                              _logout();
                              SharedPreferencesHelper.cleanlocal();
                              Provider.of<ThemeNotifier>(context)
                                  .setLogin(false);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InitPage()),
                                  ModalRoute.withName("/main"));
                            }
                          }
                        },
                        child: ItemHiddenMenu(
                          icon: Icon(
                            Provider.of<ThemeNotifier>(context).isLogin ==
                                false?Feather.unlock:Feather.lock,
                            size: 25,
                            color: Colors.white,
                          ),
                          name: Provider.of<ThemeNotifier>(context).isLogin ==
                                  false
                              ? getTransrlate(context, 'login')
                              : getTransrlate(context, 'Logout'),
                          baseStyle: GoogleFonts.cairo(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 30.0,
                              fontWeight: FontWeight.w200),
                          colorLineSelected: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _logout() {
    _googleSignIn.signOut();
    facebookLogin.logOut();
  }

  void confListern() {
    SimpleHiddenDrawerProvider.of(context)
        .getPositionSelectedListener()
        .listen((position) {
      setState(() {
        _indexSelected = position;
      });
    });
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyProfileSettings()));
    print('object');
    fetchUserId();
  }
}
