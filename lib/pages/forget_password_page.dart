import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/pages/register_page.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/commons/auth_header.dart';
import 'package:shoppingapp/widgets/commons/custom_textfield.dart';
import 'package:shoppingapp/widgets/commons/shadow_button.dart';
import 'package:validators/validators.dart' as validator;

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: themeColor.getColor(),
      ),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                AuthHeader(
                    headerTitle: "Forget",
                    headerBigTitle: "Password",
                    isLoginHeader: false),
                SizedBox(
                  height: 36,
                ),
                Container(
                  margin: EdgeInsets.all(24),
                  child: MyTextFormField(
                    labelText: "Email",
                    hintText: 'Email',
                    isEmail: true,
                    validator: (String value) {
                      if (!validator.isEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (String value) {
//                    model.email = value;
                    },
                  ),
                ),
                Container(
                  height: 42,
                  width: ScreenUtil.getWidth(context),
                  margin: EdgeInsets.only(
                      top: 32,
                      bottom: ScreenUtil.getHeight(context) / 2,
                      right: 24,
                      left: 24),
                  child: ShadowButton(
                    borderRadius: 12,
                    height: 40,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                      ),
                      color: themeColor.getColor(),
                      child: Text(
                        'Send',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onPressed: () {},
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

  routeRegisterWidget(ThemeNotifier themeColor, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 42, left: 42, bottom: 12),
      child: Row(
        children: <Widget>[
          Text(
            "Do you have an account?",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w300,
            ),
          ),
          FlatButton(
            child: Text(
              "Register",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: themeColor.getColor(),
                fontWeight: FontWeight.w300,
              ),
            ),
            onPressed: () {
              Nav.routeReplacement(context, RegisterPage());
            },
          )
        ],
      ),
    );
  }
}
