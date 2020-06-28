import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/localization_delegate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingapp/pages/category_page.dart';
import 'package:shoppingapp/pages/favorite_products_page.dart';
import 'package:shoppingapp/pages/home_navigator.dart';
import 'package:shoppingapp/pages/my_profile_page.dart';
import 'package:shoppingapp/pages/shopping_cart_page.dart';
import 'package:shoppingapp/pages/splash_screen.dart';
import 'package:shoppingapp/utils/drawer_menu/hidden_drawer/hidden_drawer_menu.dart';
import 'package:shoppingapp/utils/drawer_menu/hidden_drawer/screen_hidden_drawer.dart';
import 'package:shoppingapp/utils/drawer_menu/menu/item_hidden_menu.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

import 'config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en_US', supportedLocales: ['en_US', 'es', 'fa', 'ar']);

  SharedPreferences.getInstance().then((prefs) {
    Color color = mainColor;
    if (prefs.getInt('color') != null) {
      color = Color(prefs.getInt('color'));
    }

    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(color),
        child: Phoenix(
          child: LocalizedApp(
            delegate,
            MyApp(),
          ),
        ),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping App',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          localizationDelegate
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          }),
          primaryColor: themeColor.getColor(),
        ),
        home: SplashScreen(),
      ),
    );
  }
}

class InitPage extends StatefulWidget {
  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  List<ScreenHiddenDrawer> items = new List();

  @override
  void initState() {
    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          icon: Icon(
            Feather.home,
            size: 19,
            color: Colors.white,
          ),
          name: "Home Page",
          baseStyle: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.6), fontSize: 19.0),
          colorLineSelected: Colors.transparent,
        ),
        HomeNavigator()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          icon: Icon(
            Feather.search,
            color: Colors.white,
            size: 19,
          ),
          name: 'Categories',
          baseStyle: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.6), fontSize: 19.0),
          colorLineSelected: Colors.orange,
        ),
        CategoryPage()));
    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          icon: Icon(
            Feather.shopping_bag,
            size: 19,
            color: Colors.white,
          ),
          name: 'Shopping Cart',
          baseStyle: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.6), fontSize: 19.0),
          colorLineSelected: Colors.orange,
        ),
        ShoppingCartPage()));
    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          icon: Icon(
            Feather.heart,
            size: 19,
            color: Colors.white,
          ),
          name: 'Favorites',
          baseStyle: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.6), fontSize: 19.0),
          colorLineSelected: Colors.orange,
        ),
        FavoriteProductsPage()));
    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          icon: Icon(
            Feather.user,
            size: 19,
            color: Colors.white,
          ),
          name: 'My Profile',
          baseStyle: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.6), fontSize: 19.0),
          colorLineSelected: Colors.orange,
        ),
        MyProfilePage()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    return HiddenDrawerMenu(
      iconMenuAppBar: Padding(
        padding: EdgeInsets.only(bottom: 6),
        child: SvgPicture.asset(
          "assets/icons/ic_menu.svg",
          height: 20,
          color: themeColor.getColor(),
        ),
      ),
      isTitleCentered: true,
      elevationAppBar: 0.0,
      backgroundColorAppBar: Color.fromARGB(255, 252, 252, 252),
      tittleAppBar: Padding(
        child: Text(
          "rosen",
          style: GoogleFonts.poppins(
            fontSize: 26,
            color: themeColor.getColor(),
            fontWeight: FontWeight.w600,
          ),
        ),
        padding: EdgeInsets.only(bottom: 18),
      ),
      actionsAppBar: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 16, top: 8),
          child: InkWell(
            onTap: () {
              Nav.route(context, ShoppingCartPage());
//
            },
            child: Badge(
              badgeColor: Color(0xFF5D6A78),
              alignment: Alignment(-0.5, -1.0),
              padding: EdgeInsets.all(4),
              badgeContent: Text(
                '3',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
              child: SvgPicture.asset(
                "assets/icons/ic_shopping_cart.svg",
                color: themeColor.getColor(),
                height: 26,
              ),
            ),
          ),
        )
      ],
      backgroundColorMenu: Colors.blueGrey,
      screens: items,
      //    typeOpen: TypeOpen.FROM_RIGHT,
      enableScaleAnimin: true,

      //    enableCornerAnimin: true,
      slidePercent: 70.0,
      verticalScalePercent: 90.0,
      contentCornerRadius: 16.0,
      //    iconMenuAppBar: Icon(Icons.menu),
      //    backgroundContent: DecorationImage((image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
      //    whithAutoTittleName: true,
      //    styleAutoTittleName: TextStyle(color: Colors.red),
      //    actionsAppBar: <Widget>[],
      //    backgroundColorContent: Colors.blue,
      //    elevationAppBar: 4.0,
      //    tittleAppBar: Center(child: Icon(Icons.ac_unit),),
      //    enableShadowItensMenu: true,
//      backgroundMenu: DecorationImage(
//          image: NetworkImage(
//              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQUQ0rrFB0d5E69Qpk55mtLAc0Wd8gsk46mbZLYSqWy0TgoZxhG&usqp=CAU'),
//          fit: BoxFit.cover),
    );
  }
}
