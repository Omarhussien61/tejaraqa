import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/screen.dart';

class MyTextFormFieldLine extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final Function validator;
  final Function onSaved;
  final IconButton suffixIcon;
  final bool isPassword;
  final bool isEmail;
  final bool enabled;

  MyTextFormFieldLine({
    this.hintText,
    this.enabled,
    this.controller,
    this.validator,
    this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
    this.labelText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getWidth(context),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(color: textColor),
          contentPadding: EdgeInsets.all(15.0),
          border: new UnderlineInputBorder(
              borderSide: new BorderSide(color: textColor)),
          labelText: labelText,
          filled: true,
          suffixIcon: this.suffixIcon,
          fillColor: Color(0xFFFCFCFC),
        ),
        obscureText: isPassword ? true : false,
        validator: validator,
        controller:controller,
        onSaved: onSaved,
        enabled: enabled,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
