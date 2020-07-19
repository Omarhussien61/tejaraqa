import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingapp/service/API_CONFIQ.dart';
import 'package:shoppingapp/service/loginservice.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/shared_preferences_helper.dart';
import 'package:shoppingapp/widgets/commons/textfield_bottomline.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:validators/validators.dart' as validator;

import '../main.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  String email, password, oldPassword,confirmPassword, Newpassword;
  int id;
  bool passwordVisible = true;
  final _formKey = GlobalKey<FormState>();
TextEditingController emailController;
  @override
  void initState() {
    emailController=TextEditingController();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        email = prefs.getString('user_email');
        emailController.text=email;
        password = prefs.getString('password');
        print(password);
        id = prefs.getInt('user_id');
      });
    });
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
        bottomNavigationBar: Builder(
          builder: (context) => InkWell(
            onTap: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                oldPassword == password ?
                ubdate(Newpassword,context): Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('password invalid')));
              }
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
        ),
        backgroundColor: Color(0xFFFCFCFC),
        body: Container(
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Change Password",
                  style: GoogleFonts.poppins(fontSize: 18, color: textColor),
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
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        MyTextFormFieldLine(
                          controller: emailController,
                          labelText: "Email",
                          enabled: false,
                          hintText: 'Email',
                          isEmail: true,
                          validator: (String value) {
                            if (!validator.isEmail(value)) {
                              return 'Please enter a valid email';
                            }
                            _formKey.currentState.save();
                            return null;
                          },
                          onSaved: (String value) {},
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        MyTextFormFieldLine(
                          labelText: "Password",
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: themeColor.getColor(),
                            ),
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                          isPassword: passwordVisible,
                          validator: (String value) {
                            if (value!=password) {
                              return 'invaild Password';
                            }
                            _formKey.currentState.save();
                            return null;
                          },
                          onSaved: (String value) {
                            setState(() {
                              oldPassword = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        MyTextFormFieldLine(
                          labelText: "New Password",
                          hintText: 'New Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: themeColor.getColor(),
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                          isPassword: passwordVisible,
                          validator: (String value) {
                            if (value.length < 7) {
                              return 'Password should be minimum 7 characters';
                            }

                            _formKey.currentState.save();

                            return null;
                          },
                          onSaved: (String value) {
                            Newpassword = value;
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        MyTextFormFieldLine(
                          labelText: "Confirm Password",
                          hintText: 'Confirm Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: themeColor.getColor(),
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                          isPassword: passwordVisible,
                          validator: (String value) {
                            if (value!=Newpassword) {
                              return 'Password should be match';
                            }
                            _formKey.currentState.save();

                            return null;
                          },
                          onSaved: (String value) {
                            confirmPassword = value;
                          },
                        ),
                    Padding(
                      padding:  EdgeInsets.only(top: 10),
                      child: InkWell(
                        onTap: _launchInBrowser,
                        child: Text('Lost Password',
                        style: TextStyle(decoration: TextDecoration.underline,
                        color: themeColor.getColor(),
                        fontSize: 16),),
                      ),
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
  Future<void> _launchInBrowser() async {
   String  url = APICONFIQ.Base_url+'my-account-2/lost-password/';
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
  ubdate(String newpassword,BuildContext context) async {
    var result = await LoginService().ubdatePassword(id, newpassword);
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        if (newpassword == prefs.getString('password')) {
          Nav.routeReplacement(context, InitPage());
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('password Changed')));
        } else {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('password Not Changed')));
        }
      });
    });
  }

}
