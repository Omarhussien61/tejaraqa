import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingapp/pages/login_page.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';

import '../config.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({Key key}) : super(key: key);

  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final int _totalPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  Widget _buildPageIndicator(bool isCurrentPage) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? mainColor : Colors.grey[300],
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  void initState() {
    saveOnboardPageShared();
    super.initState();
  }

  Future saveOnboardPageShared() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool("onboard", true);
//    print(sp.getBool("onboard"));
//    if(sp.getBool("aaa") != null){
//      print("Null değil");
//    }else{
//      print("Nullııı");
//    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        child: Container(
          child: PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              _currentPage = page;
              setState(() {});
            },
            children: <Widget>[
              _buildPageContent(
                  image: 'assets/images/onb1.png',
                  title: 'Easy to Use',
                  body:
                      'Quickly find the product you want to its easy interface.'),
              _buildPageContent(
                  image: 'assets/images/onb2.png',
                  title: 'High Level Security',
                  body:
                      'Your information is safe with advanced encryption feature.'),
              _buildPageContent(
                  image: 'assets/images/onb3.png',
                  title: '7-24 Support',
                  body:
                      'Any problem you can quickly support team immediately.'),
            ],
          ),
        ),
      ),
      bottomSheet: _currentPage != 2
          ? Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      _pageController.animateToPage(2,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.linear);
                      setState(() {});
                      Nav.routeReplacement(context, LoginPage());
                    },
                    splashColor: Colors.blue[50],
                    child: Text(
                      'SKIP',
                      style: GoogleFonts.poppins(color: Colors.blueGrey),
                    ),
                  ),
                  Container(
                    child: Row(children: [
                      for (int i = 0; i < _totalPages; i++)
                        i == _currentPage
                            ? _buildPageIndicator(true)
                            : _buildPageIndicator(false)
                    ]),
                  ),
                  FlatButton(
                    onPressed: () {
                      _pageController.animateToPage(_currentPage + 1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.linear);
                      setState(() {});
                    },
                    splashColor: Colors.blue[50],
                    child: Text(
                      'NEXT',
                      style: GoogleFonts.poppins(color: mainColor),
                    ),
                  )
                ],
              ),
            )
          : Container(
              color: Colors.white,
              height: 60,
              child: Align(
                child: Container(
                  height: 42,
                  width: ScreenUtil.getWidth(context) / 2,
                  child: GFButton(
                    color: mainColor,
                    fullWidthButton: true,
                    type: GFButtonType.outline,
                    shape: GFButtonShape.pills,
                    onPressed: () {
                      Nav.routeReplacement(context, LoginPage());
                    },
                    child: Text(
                      "GET STARTED",
                      style: GoogleFonts.poppins(
                          color: mainColor, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildPageContent({
    String image,
    String title,
    String body,
  }) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset(
              image,
              height: 180,
            ),
          ),
          SizedBox(height: 32),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 16, height: 2.0, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10),
          Text(
            body,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 14, height: 2.0),
          ),
        ],
      ),
    );
  }
}
