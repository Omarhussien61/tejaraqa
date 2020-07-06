import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/service/loginservice.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/commons/shadow_button.dart';
import 'package:shoppingapp/widgets/register/register_form_model.dart';
import 'package:validators/validators.dart' as validator;

import '../../main.dart';
import '../Show_dialg.dart';
import '../commons/custom_textfield.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  Model model = Model();
  bool passwordVisible = false;
  bool _isLoading = false;



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
          padding: EdgeInsets.only(top: 14, right: 36, left: 48),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  child: MyTextFormField(
                    labelText: "First Name",
                    hintText: 'First Name',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter your first name';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      model.firstName = value;
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: MyTextFormField(
                    labelText: "Last Name",
                    hintText: 'Last Name',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter your last name';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      model.lastName = value;
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: MyTextFormField(
                    labelText: "User Name",
                    hintText: 'User Name',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter your User name';
                      } else if (value.length < 7) {
                        return 'Enter your User name';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      model.userName = value;
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: MyTextFormField(
                    labelText: "Phone number",
                    hintText: 'Phone number',
                    isPhone: true,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter your Phone number';
                      } else if (value.length < 10) {
                        return 'Enter your Phone number';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      model.Phone = value;
                    },
                  ),
                ),

                MyTextFormField(
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
                    model.email = value;
                  },
                ),
                MyTextFormField(
                  labelText: "Password",
                  hintText: 'Password',
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
                    if (value.length < 7) {
                      return 'Password should be minimum 7 characters';
                    }

                    _formKey.currentState.save();

                    return null;
                  },
                  onSaved: (String value) {
                    model.password = value;
                  },
                ),
                Container(
                  height: 48,
                  width: ScreenUtil.getWidth(context),
                  margin: EdgeInsets.only(top: 12, bottom: 0),
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
                          var result =  await LoginService().Register(
                             model );
                        if(result.runtimeType==String)
                          {
                            setState(() => _isLoading = false);
                            showAlertDialog(result.toString(),'Alart');

                          }
                        else
                          {
                            setState(() => _isLoading = false);
                            Nav.routeReplacement(context, InitPage());
                          }

                        }
                      },
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.poppins(
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
