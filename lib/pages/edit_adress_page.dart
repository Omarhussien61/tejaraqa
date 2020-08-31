
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

class EditAddressPage extends StatefulWidget {
Address_shiping address_shiping;
EditAddressPage(this.address_shiping);

  @override
  _EditAddressPageState createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
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
            child: Text("add"),
            value: "add",
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
if(widget.address_shiping!=null){
  setState(() {
    _nameController.text=widget.address_shiping.title;
    _cityController.text=widget.address_shiping.city;
    _CountryController.text=widget.address_shiping.Country;
    _streeetController.text=widget.address_shiping.street;
    _AddressController.text=widget.address_shiping.addres1;
    _buildingController.text=widget.address_shiping.buildingNo;
  });
}

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
                    Container(
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
                        NewAddressInput(
                          controller: _CountryController,
                          labelText: getTransrlate(context, 'Countroy'),
                          hintText: '',
                          isEmail: true,
                          validator: (String value) {
                            if (value.isEmpty){
                              return  getTransrlate(context, 'Countroy');
                            }
                          },
                          onSaved: (String value) {
                          },
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        NewAddressInput(
                          controller: _cityController,
                          labelText: getTransrlate(context, 'City'),
                          hintText: '',
                          isEmail: true,
                          validator: (String value) {
                            if (value.isEmpty){
                              return getTransrlate(context, 'City');
                            }
                          },
                          onSaved: (String value) {
                          },
                        ),
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
                              labelText: getTransrlate(context, 'Street'),
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
                                  labelText: getTransrlate(context, 'Building')
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
            _AddressController.text,lang: widget.address_shiping==null?
            0.0:widget.address_shiping.lang,lat:widget.address_shiping==null?
        0.0:widget.address_shiping.lat,id: widget.address_shiping== null?null:widget.address_shiping.id);
        int result;

        if (widget.address_shiping==null) {

          result = await helper.insertAddress(address);
          Navigator.pop(context);
        } else {

          if (widget.address_shiping.id==null) {
            result = await helper.insertAddress(address);
            Navigator.pop(context);
          }else {
            result = await helper.updateAddress(address);
            Navigator.pop(context);

          }

        }
        if (result == 0) {
          print('error');
        } else {

        }
      }
    }
  }
  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    address = new Address_shiping(
        _CountryController.text,
        _cityController.text,
        _nameController.text,
        _streeetController.text,
        _buildingController.text,
        _AddressController.text,lang: widget.address_shiping.lang,lat:widget.address_shiping.lat,id: widget.address_shiping.id );
    print(address.lat.toString()+' ----- '+address.lang.toString());
     await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MapSample(address_shiping: address))
    );

    Navigator.pop(context);

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

}