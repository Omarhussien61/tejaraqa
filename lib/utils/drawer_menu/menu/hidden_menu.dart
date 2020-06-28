import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/pages/about_page.dart';
import 'package:shoppingapp/pages/change_password_page.dart';
import 'package:shoppingapp/pages/contact_page.dart';
import 'package:shoppingapp/pages/profile_settings_page.dart';
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
      this.typeOpen = TypeOpen.FROM_LEFT})
      : super(key: key);

  @override
  _HiddenMenuState createState() => _HiddenMenuState();
}

class _HiddenMenuState extends State<HiddenMenu> {
  int _indexSelected;
  bool isconfiguredListern = false;

  @override
  void initState() {
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
                  "Jon Doe",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/man.png"),
                ),
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
                      ItemHiddenMenu(
                        icon: Icon(
                          Feather.type,
                          size: 19,
                          color: Colors.white,
                        ),
                        name: 'Language',
                        baseStyle: GoogleFonts.poppins(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 19.0),
                        colorLineSelected: Colors.orange,
                      ),
                      InkWell(
                        onTap: () {
                          _themeChanger.openFullMaterialColorPicker(themeColor);
                        },
                        child: ItemHiddenMenu(
                          icon: Icon(
                            Feather.check_square,
                            size: 19,
                            color: Colors.white,
                          ),
                          name: 'Themes',
                          baseStyle: GoogleFonts.poppins(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 19.0),
                          colorLineSelected: Colors.orange,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Nav.route(context, ChangePasswordPage());
                        },
                        child: ItemHiddenMenu(
                          icon: Icon(
                            Feather.lock,
                            size: 19,
                            color: Colors.white,
                          ),
                          name: 'Reset Password',
                          baseStyle: GoogleFonts.poppins(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 19.0),
                          colorLineSelected: Colors.orange,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Nav.route(context, MyProfileSettings());
                        },
                        child: ItemHiddenMenu(
                          icon: Icon(
                            Feather.mail,
                            size: 19,
                            color: Colors.white,
                          ),
                          name: 'Email Settings',
                          baseStyle: GoogleFonts.poppins(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 19.0),
                          colorLineSelected: Colors.orange,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                  height: 28,
                  margin: EdgeInsets.only(left: 24, right: 48),
                  child: Divider(
                    color: Colors.white.withOpacity(0.5),
                  )),
              Container(
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
                        child: ItemHiddenMenu(
                          icon: Icon(
                            Feather.list,
                            size: 19,
                            color: Colors.white,
                          ),
                          name: 'F.A.Q',
                          baseStyle: GoogleFonts.poppins(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 19.0),
                          colorLineSelected: Colors.orange,
                        ),
                        onTap: () {
                          Nav.route(context, AboutPage());
                        },
                      ),
                      InkWell(
                        onTap: () {
                          Nav.route(context, ContactPage());
                        },
                        child: ItemHiddenMenu(
                          icon: Icon(
                            Icons.call,
                            size: 19,
                            color: Colors.white,
                          ),
                          name: 'Contact',
                          baseStyle: GoogleFonts.poppins(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 19.0,
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

  void confListern() {
    SimpleHiddenDrawerProvider.of(context)
        .getPositionSelectedListener()
        .listen((position) {
      setState(() {
        _indexSelected = position;
      });
    });
  }
}
