import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/modal/Address_shiping.dart';
import 'package:shoppingapp/pages/credit_cart_page.dart';
import 'package:shoppingapp/utils/commons/country.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';
import 'package:shoppingapp/utils/util/sql_address.dart';
import 'package:shoppingapp/utils/drop_down_menu/find_dropdown.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/new_adress_input.dart';

import 'map_sample.dart';

class NewAddressPage extends StatefulWidget {


  @override
  _NewAddressPageState createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage> {
  bool asTabs = false;
  String selectedValue;
  String preselectedValue = "dolor sit";
  List<int> selectedItems = [];
  TextEditingController _nameController,_cityController, _CountryController;
  TextEditingController _AddressController, _buildingController, _streeetController;
  List<String> city = new List<String>();
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Address_shiping address_shiping;

  final List<DropdownMenuItem> items = [];
  Address_shiping address;
  SQL_Address helper = new SQL_Address();
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
            child: Text('new'),
            value: 'new',
          ));
        }

        wordPair = "";
      }
    });
    _nameController = TextEditingController();
    _CountryController = TextEditingController();
    _cityController = TextEditingController();
    _AddressController = TextEditingController();
    _buildingController = TextEditingController();
    _streeetController = TextEditingController();
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
        key: scaffoldKey,
        bottomNavigationBar: InkWell(
          onTap: () {
            _save();
          },
          child: Container(
            margin: EdgeInsets.only(left: 14, right: 14),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                getTransrlate(context, 'save'),
                style: GoogleFonts.cairo(color: Colors.white),
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                getTransrlate(context, 'MyAddress'),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 24,right: 8,left: 8),
                      child: InkWell(
                        focusColor:  Provider.of<ThemeNotifier>(context).getColor(),
                        splashColor: Provider.of<ThemeNotifier>(context).getColor(),
                        onTap: () {
                          //Nav.routeReplacement(context, MapSample());
                          _navigateAndDisplaySelection(context);
                        },
                        child: Icon(Icons.location_on),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        NewAddressInput(
                          controller: _nameController,
                          labelText: getTransrlate(context, 'AddressTitle'),
                          hintText: '',
                          isEmail: true,
                          validator: (String value) {
                            if (value.isEmpty){
                              return getTransrlate(context, 'AddressTitle');
                            }
                          },
                          onSaved: (String value) {
//                        model.email = value;
                          },
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        FindDropdown(
                            items: ['Egypt','Saudi Arabia'],
                            onChanged: (String item) {
                              setState(() {
                                _CountryController.text=item;
                              });
                              get_City(item);
                            },
                            validate: (String value) {
                              if (value.isEmpty){
                                return getTransrlate(context, 'Countroy');
                              }
                            },
                            selectedItem: getTransrlate(context, 'Countroy'),
                            isUnderLine: true),
                        SizedBox(
                          height: 32,
                        ),
                        FindDropdown(
                            items: city,
                            onChanged: (String item) {
                              setState(() {
                                _cityController.text=item;
                              });
                            },
                            validate: (String value) {
                              if (value.isEmpty){
                                return getTransrlate(context, 'City');
                              }
                            },
                            selectedItem: getTransrlate(context, 'City'),
                            isUnderLine: true),
                        SizedBox(
                          height: 32,
                        ),
                        NewAddressInput(
                          controller: _AddressController,

                          labelText: getTransrlate(context, 'Address'),
                          hintText: '',
                          isEmail: true,
                          validator: (String value) {
                            if (value.isEmpty){
                              return getTransrlate(context, 'Address');
                            }
                          },
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
                          Container(
                            width: ScreenUtil.divideWidth(context)/3,

                            child: TextFormField(
                              controller: _streeetController,
                              validator: (String value) {
                                if (value.isEmpty){
                                  return getTransrlate(context, 'Street');
                                }
                              },
                            decoration: InputDecoration(
                                hintText: getTransrlate(context, 'Street'),
                                labelStyle: GoogleFonts.cairo(fontSize: 12),
                                helperStyle: GoogleFonts.cairo(fontSize: 12),
                                hintStyle: GoogleFonts.cairo(fontSize: 12),
                            ),

                        ),
                          ),
                          Container(
                              width: ScreenUtil.divideWidth(context)/3,

                              child: TextFormField(
                                controller: _buildingController,
                                validator: (String value) {
                                  if (value.isEmpty){
                                    return getTransrlate(context, 'Building');
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: getTransrlate(context, 'Building'),
                                  labelStyle: GoogleFonts.cairo(fontSize: 12),
                                  helperStyle: GoogleFonts.cairo(fontSize: 12),
                                  hintStyle: GoogleFonts.cairo(fontSize: 12),
                                ),

                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _save() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if(_CountryController.text.isEmpty||_cityController.text.isEmpty)
      {
        scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: Provider.of<ThemeNotifier>(context).getColor(),
            content: Text(getTransrlate(context, 'countrySelected'))));
      }else{
        address = new Address_shiping(
            _CountryController.text,
            _cityController.text,
            _nameController.text,
            _streeetController.text,
            _buildingController.text,
            _AddressController.text);

        int result;
        result = await helper.insertAddress(address);
        if (result == 0) {

        } else {
          Navigator.pop(context);
        }
      }
    }
  }
 get_City(String country) {
    if (country == 'Egypt')
      setState(() {
        city=Egypt;
      });
    else if (country == 'Saudi Arabia')
      setState(() {
        city=SaudiArabia;
      });
  }
  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
   address_shiping= await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapSample())
    );

    Navigator.pop(context);

  }

}