import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/pages/new_password_page.dart';
import 'package:shoppingapp/pages/register_page.dart';
import 'package:shoppingapp/utils/code_input.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/commons/auth_header.dart';
import 'package:shoppingapp/widgets/commons/shadow_button.dart';

class ForgetPasswordValidatePage extends StatefulWidget {
  @override
  _ForgetPasswordValidatePageState createState() =>
      _ForgetPasswordValidatePageState();
}

class _ForgetPasswordValidatePageState
    extends State<ForgetPasswordValidatePage> {
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
                  margin: EdgeInsets.only(top: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          "Enter Code",
                          style: GoogleFonts.poppins(color: Color(0xFF5D6A78)),
                        ),
                      ),
                      CodeInput(
                        length: 4,
                        keyboardType: TextInputType.number,
                        builder: CodeInputBuilders.darkCircle(),
                        onFilled: (value) async {
                          Future.delayed(const Duration(milliseconds: 1500),
                              () {
                            setState(() {
//                            pr.hide();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewPasswordPage()),
                              );
                            });
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 42,
                  width: ScreenUtil.getWidth(context),
                  margin: EdgeInsets.only(
                      top: 32,
                      bottom: ScreenUtil.getHeight(context) / 2,
                      right: 48,
                      left: 48),
                  child: ShadowButton(
                    borderRadius: 12,
                    height: 40,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                      ),
                      color: themeColor.getColor(),
                      child: Text(
                        'Verify',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onPressed: () {
                        Nav.routeReplacement(context, NewPasswordPage());
                      },
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
