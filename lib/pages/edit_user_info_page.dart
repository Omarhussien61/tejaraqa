import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/drop_down_menu/find_dropdown.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/new_adress_input.dart';

class EditUserInfoPage extends StatefulWidget {
  @override
  _EditUserInfoPageState createState() => _EditUserInfoPageState();
}

class _EditUserInfoPageState extends State<EditUserInfoPage> {
  bool asTabs = false;
  String selectedValue;
  String preselectedValue = "dolor sit";
  List<int> selectedItems = [];
  final List<DropdownMenuItem> items = [];

  final String loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqu";

  @override
  void initState() {
    @override
    String wordPair = "";
    loremIpsum
        .toLowerCase()
        .replaceAll(",", "")
        .replaceAll(".", "")
        .split(" ")
        .forEach((word) {
      if (wordPair.isEmpty) {
        wordPair = word + " ";
      } else {
        wordPair += word;
        if (items.indexWhere((item) {
              return (item.value == wordPair);
            }) ==
            -1) {
          items.add(DropdownMenuItem(
            child: Text("sfsdf"),
            value: "sdfsdfsdf",
          ));
        }
        wordPair = "";
      }
    });
    super.initState();

    super.initState();
  }

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
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "User information",
                  style: GoogleFonts.poppins(
                      fontSize: 18, color: Color(0xFF5D6A78)),
                ),
                Container(
                    width: 28,
                    child: Divider(
                      color: themeColor.getColor(),
                      height: 3,
                      thickness: 2,
                    )),
                SizedBox(
                  height: 16,
                ),
                Column(
                  children: <Widget>[
                    NewAddressInput(
                      labelText: "Name surname",
                      hintText: 'Name surname',
                      isEmail: true,
                      validator: (String value) {},
                      onSaved: (String value) {
//                        model.email = value;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    NewAddressInput(
                      labelText: "E-mail address",
                      hintText: 'example@example.com',
                      isEmail: true,
                      validator: (String value) {},
                      onSaved: (String value) {
//                        model.email = value;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
//                    NewAddressInput(
//                      labelText: "E Posta Adresi",
//                      hintText: 'example@example.com',
//                      isEmail: true,
//                      validator: (String value) {
//
//                      },
//                      onSaved: (String value) {
////                        model.email = value;
//                      },
//                    ),
                    NewAddressInput(
                      labelText: "Mobile phone",
                      hintText: 'xxxx xxx xxx xx',
                      isEmail: true,
                      validator: (String value) {},
                      onSaved: (String value) {
//                        model.email = value;
                      },
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    FindDropdown(
                        items: ["Male", "Woman", "I do not want to specify"],
                        onChanged: (String item) => print(item),
                        selectedItem: "Gender",
                        isUnderLine: true),
                    SizedBox(
                      height: 32,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildAddressItem(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.2),
              blurRadius: 6.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: Offset(
                0.0, // Move to right 10  horizontally
                1.0, // Move to bottom 10 Vertically
              ),
            )
          ]),
      height: ScreenUtil.getHeight(context) / 3.1,
      width: ScreenUtil.getWidth(context),
      margin: EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "My Home Address",
            style: GoogleFonts.poppins(
                fontSize: 16, fontWeight: FontWeight.w300, color: textColor),
          ),
          Container(width: 64, child: Divider()),
          Expanded(
              child: Text(
            "Salvus devatios ducunt ad apolloniates. ducunt ad apolloniates.",
            style: GoogleFonts.poppins(
                fontSize: 14, fontWeight: FontWeight.w300, color: textColor),
          )),
          Container(width: 64, child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Invoice",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: textColor),
                  ),
                  Text(
                    "ID No",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: textColor),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Individual",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: textColor),
                  ),
                  Text(
                    "xxx xxxx xxxx xx",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: textColor),
                  ),
                ],
              )
            ],
          )
        ],
      ),
      padding: EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 24),
    );
  }
}
