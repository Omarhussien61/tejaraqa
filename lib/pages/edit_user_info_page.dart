import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/modal/user_login.dart';
import 'package:shoppingapp/service/loginservice.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/drop_down_menu/find_dropdown.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';
import 'package:shoppingapp/utils/util/shared_preferences_helper.dart';
import 'package:shoppingapp/widgets/new_adress_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String email,name,last_name,phone;
      int id;
  TextEditingController _frist_nameController,_Last_nameController,_EmailController,_PhoneController;
  UserLogin userModal;
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    getInfo();
    _frist_nameController=TextEditingController();
    _Last_nameController=TextEditingController();

    _EmailController=TextEditingController();
    _PhoneController=TextEditingController();

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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    getTransrlate(context, 'MyProfileInfo'),
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
                        controller:_frist_nameController ,
                        labelText: getTransrlate(context, 'Firstname'),
                        hintText: getTransrlate(context, 'Firstname'),
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
                        controller:_Last_nameController ,
                        labelText: getTransrlate(context, 'Lastname'),
                        hintText: getTransrlate(context, 'Lastname'),
                        isEmail: true,
                        validator: (String value) {},
                        onSaved: (String value) {
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      NewAddressInput(
                        controller:_EmailController ,
                        labelText: getTransrlate(context, 'Email'),
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
                      NewAddressInput(
                        controller: _PhoneController,
                        labelText: getTransrlate(context, 'phone'),
                        hintText: 'xxxx xxx xxx xx',
                        validator: (String value) {
                          if (value.length < 10) {
                            return getTransrlate(context, 'shorterphone');
                          }
                        },
                        onSaved: (String value) {
                        },
                      ),
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
        bottomNavigationBar: Builder(
          builder: (context) => InkWell(
            onTap: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                ubdate(context);
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: 14, right: 14),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  getTransrlate(context, 'save'),
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

  getInfo() async {
    email = await SharedPreferencesHelper.getEmail();
    name = await SharedPreferencesHelper.getname();
    last_name = await SharedPreferencesHelper.getLast_name();
    phone = await SharedPreferencesHelper.getphone();
    id = await SharedPreferencesHelper.getUserId();
    setState(() {
      _frist_nameController.text=name;
      _Last_nameController.text=last_name;
      _EmailController.text=email;
      _PhoneController.text=phone;
    });
  }

  ubdate(BuildContext context) async {
    var result = await LoginService().ubdateProfile(
        id,_EmailController.text,_frist_nameController.text,_Last_nameController.text,_PhoneController.text);
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        if (name == prefs.getString('user_displayname')) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text(getTransrlate(context, 'profileChanged'))));
        } else {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text(getTransrlate(context, 'profileChanged'))));
        }
      });
    });
  }

}
