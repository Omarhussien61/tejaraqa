import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/main.dart';
import 'package:shoppingapp/modal/user_login.dart';
import 'package:shoppingapp/service/loginservice.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';
import 'package:shoppingapp/widgets/Show_dialg.dart';
import 'package:shoppingapp/widgets/commons/shadow_button.dart';
import 'package:shoppingapp/widgets/login/login_form_model.dart';
import 'package:validators/validators.dart' as validator;

import '../commons/custom_textfield.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  Model model = Model();
  bool passwordVisible = false;
  bool _autovalidate = false;
  bool _isLoading = false;
  var userModal;
  submitForm() async {

  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 24, right: 42, left: 42),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                MyTextFormField(
                  labelText: getTransrlate(context, 'Email'),
                  hintText: getTransrlate(context, 'Email'),
                  isEmail: true,
                  validator: (String value) {
                    if (!validator.isEmail(value)) {
                      return getTransrlate(context, 'invalidemail');
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    model.email = value;
                  },
                ),
                MyTextFormField(
                  labelText: getTransrlate(context, 'password'),
                  hintText: getTransrlate(context, 'password'),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
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
                    if (value.length < 6) {
                      return getTransrlate(context, 'PasswordShorter');
                    }

                    _formKey.currentState.save();

                    return null;
                  },
                  onSaved: (String value) {
                    model.password = value;
                  },
                ),
                Container(
                  height: 42,
                  width: ScreenUtil.getWidth(context),
                  margin: EdgeInsets.only(top: 32, bottom: 12),
                  child: ShadowButton(
                    borderRadius: 12,
                    height: 40,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                      ),
                      color: themeColor.getColor(),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          FocusScope.of(context).requestFocus(new FocusNode());
                          setState(() => _isLoading = true);
                          try {
                            userModal = await LoginService().loginUser(model.email, model.password);
                            if (userModal.status == 'ok') {
                              setState(() => _isLoading = false);
                              Nav.routeReplacement(context, InitPage());
                              Provider.of<ThemeNotifier>(context).setLogin(true);
                            }
                            else{
                              setState(() => _isLoading = false);
                              showAlertDialog(getTransrlate(context, 'invildpassword'),getTransrlate(context, 'Alert'));
                            }
                          }
                          catch (e) {
                            print(e);
                          }
                        }
                      },
                      child: Text(
                        getTransrlate(context, 'login'),
                        style: GoogleFonts.cairo(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        _isLoading ? Container(
            height: 400,
            width: double.infinity,
            color: Colors.black45,
            child: Center(child:  CircularProgressIndicator(
                valueColor:  AlwaysStoppedAnimation<Color>(themeColor.getColor()))))
            : Container()
      ],
    );
  }
  void showAlertDialog(String title, String msg){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(msg),
          content: new Text(title),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
          ],
        );
      },
    );
  }
}
