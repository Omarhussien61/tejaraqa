import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingapp/pages/category_page.dart';
import 'package:shoppingapp/pages/favorite_products_page.dart';
import 'package:shoppingapp/pages/home_navigator.dart';
import 'package:shoppingapp/pages/my_profile_page.dart';
import 'package:shoppingapp/pages/shopping_cart_page.dart';
import 'package:shoppingapp/pages/splash_screen.dart';
import 'package:shoppingapp/service/API_CONFIQ.dart';
import 'package:shoppingapp/service/productdervice.dart';
import 'package:shoppingapp/service/theameservice.dart';
import 'package:shoppingapp/utils/drawer_menu/hidden_drawer/hidden_drawer_menu.dart';
import 'package:shoppingapp/utils/drawer_menu/hidden_drawer/screen_hidden_drawer.dart';
import 'package:shoppingapp/utils/drawer_menu/menu/item_hidden_menu.dart';
import 'package:shoppingapp/utils/drawer_menu/simple_hidden_drawer/animated_drawer_content.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/AppLocalizations.dart';
import 'package:shoppingapp/utils/util/sql_helper.dart';

import 'config.dart';
import 'modal/Theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences.getInstance().then((prefs) {
    Color color = mainColor;
    if (prefs.getInt('color') != null) {
      color = Color(prefs.getInt('color'));
    }
    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(color),

        child: Phoenix(
          child: MyApp(),
        ),
      ),
    );
  });
}

class MyApp extends StatefulWidget {

  static void setlocal(BuildContext context,Locale locale)
  {
    _MyAppState state =context.findAncestorStateOfType<_MyAppState>();
    state.setlocal(locale);
  }
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  Locale _locale;
  void setlocal(Locale locale){
    setState(() {
      _locale=locale;
    });
  }
  @override
  void initState() {
    theameservice.getNewTheme().then((onValue){
      Provider.of<ThemeNotifier>(context).setTheme(onValue);
      Provider.of<ThemeNotifier>(context).setColor(Color(int.parse(onValue.primaryCoustom)));

      SharedPreferences.getInstance().then((prefs){
        prefs.setInt('color', int.parse(onValue.primaryCoustom));
      });
    });
    APICONFIQ.getNewConfiq().then((onValue){
      setState(() {
        APICONFIQ.Base_url=onValue.baseUrl;
        APICONFIQ.consumer_key=onValue.consumerKey;
        APICONFIQ.consumer_secret=onValue.consumerSecret;
        APICONFIQ.kGoogleApiKey=onValue.kGoogleApiKey;
        Provider.of<ThemeNotifier>(context).setLocal(onValue.local);
        Provider.of<ThemeNotifier>(context).setConfig_model(onValue);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping App',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      localeResolutionCallback: (devicelocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == devicelocale.languageCode &&
              locale.countryCode == devicelocale.countryCode) {
            return devicelocale;
          }
        }
        return supportedLocales.first;
      },
      supportedLocales: [
        Locale("en", ""),
        Locale("ar", ""),
      ],
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
        primaryColor: themeColor.getColor(),
      ),
      home:SplashScreen(),
      );
  }
}
class InitPage extends StatefulWidget {

  @override
  _InitPageState createState() => _InitPageState();
}
class _InitPageState extends State<InitPage> {
  List<ScreenHiddenDrawer> items = new List();
  SQL_Helper helper = new SQL_Helper();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        MyApp.setlocal(context,
            Locale(Provider.of<ThemeNotifier>(context).getlocal(),'')));
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

    helper.getCount().then((value) {
      Provider.of<ThemeNotifier>(context).intcountCart(value);
    });
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
      tittleAppBar: CachedNetworkImage(
        height: 30,
        width: 150,
        fit: BoxFit.fill,
        imageUrl: 'https://d2.woo2.app/wp-content/uploads/2020/04/log-new-1.png',
      ),
      actionsAppBar: <Widget>[
      ],
      backgroundColorMenu: Colors.blueGrey,
      screens: items,
      //    typeOpen: TypeOpen.FROM_RIGHT,
      enableScaleAnimin: true,

      //    enableCornerAnimin: true,
      slidePercent: 70.0,
      verticalScalePercent: 90.0,
      contentCornerRadius: 16.0,
      typeOpen:themeColor.local=='ar'?TypeOpen.FROM_RIGHT: TypeOpen.FROM_LEFT,

    );
  }
}
