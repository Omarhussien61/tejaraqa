import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/pages/filter_page.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/widgets/homepage/search_box.dart';

class FilterDetalInnerPage extends StatefulWidget {
  @override
  _FilterDetalInnerPageState createState() => _FilterDetalInnerPageState();
}

class _FilterDetalInnerPageState extends State<FilterDetalInnerPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          return Nav.routeReplacement(context, FilterPage());
        },
        child: Scaffold(
            bottomNavigationBar: InkWell(
              onTap: () {
                Nav.routeReplacement(context, FilterPage());
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32)),
                    color: Color(0xFF5D6A78)),
                height: 42,
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Apply",
                      style: GoogleFonts.poppins(
                          fontSize: 18, color: Colors.white),
                    )),
              ),
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 12),
                    child: SearchBox(),
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      buildItem("Unbranded"),
                      buildItem("Angemiel"),
                      buildItem("Defacto"),
                      buildItem("Flo"),
                      buildItem("Special production"),
                      buildItem("Lc waikiki"),
                      buildItem("Mavi"),
                      buildItem("Sense  "),
                      buildItem("Le sille"),
                      buildItem("Mite Love"),
                      buildItem("Julian"),
                      buildItem("Sezar"),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  buildItem(String title) {
    return InkWell(
      onTap: () {
        Nav.routeReplacement(context, FilterPage());
      },
      child: Container(
        height: 40,
        child: Transform.scale(
          scale: 0.9,
          child: RadioListTile(
            value: false,
            title: Text(
              title,
              style:
                  GoogleFonts.poppins(fontSize: 14, color: Color(0xFFA1B1C2)),
            ),
            groupValue: null,
            onChanged: (bool value) {},
          ),
        ),
      ),
    );
  }
}
