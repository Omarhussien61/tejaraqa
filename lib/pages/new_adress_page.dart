import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/pages/credit_cart_page.dart';
import 'package:shoppingapp/utils/drop_down_menu/find_dropdown.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/new_adress_input.dart';

class NewAddressPage extends StatefulWidget {
  @override
  _NewAddressPageState createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage> {
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
            child: Text("add"),
            value: "add",
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
        bottomNavigationBar: InkWell(
          onTap: () {
            Nav.routeReplacement(context, CreditCartPage());
          },
          child: Container(
            margin: EdgeInsets.only(left: 14, right: 14),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Save",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
            height: 42,
            decoration: BoxDecoration(
                color: themeColor.getColor(),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32))),
          ),
        ),
        backgroundColor: Color(0xFFFCFCFC),
        body: Container(
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "My address",
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
                      labelText: "Address Title",
                      hintText: '',
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
                      labelText: "Name Surname",
                      hintText: '',
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
                        items: ["Heu", "Medicina", "Byssus", "Locus"],
                        onChanged: (String item) => print(item),
                        selectedItem: "City",
                        isUnderLine: true),
                    SizedBox(
                      height: 32,
                    ),
                    FindDropdown(
                        items: ["Heu", "Medicina", "Byssus", "Locus"],
                        onChanged: (String item) => print(item),
                        selectedItem: "District",
                        isUnderLine: true),
                    SizedBox(
                      height: 32,
                    ),
                    FindDropdown(
                        items: ["Heu", "Medicina", "Byssus", "Locus"],
                        onChanged: (String item) => print(item),
                        selectedItem: "Neighborhood",
                        isUnderLine: true),
                    SizedBox(
                      height: 16,
                    ),
                    NewAddressInput(
                      labelText: "Address",
                      hintText: '',
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
                      labelText: "Invoice Code",
                      hintText: '',
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
                      labelText: "Mobile Phone",
                      hintText: '',
                      isEmail: true,
                      validator: (String value) {},
                      onSaved: (String value) {
//                        model.email = value;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Invoice Type",
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: Color(0xFF5D6A78)),
                        ),
                        Row(
                          children: <Widget>[
                            GFButton(
                              child: Text(
                                "Individual",
                                style: GoogleFonts.poppins(fontSize: 12),
                              ),
                              type: GFButtonType.solid,
                              color: themeColor.getColor(),
                              onPressed: () {},
                            ),
                            SizedBox(
                              width: 14,
                            ),
                            GFButton(
                              child: Text(
                                "Enterprise",
                                style: GoogleFonts.poppins(
                                    fontSize: 12, color: Color(0xFF5D6A78)),
                              ),
                              type: GFButtonType.outline,
                              color: Color(0xFF5D6A78),
                              onPressed: () {},
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
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
}
