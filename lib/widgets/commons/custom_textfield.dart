import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final Function validator;
  final Function onSaved;

  final IconButton suffixIcon;
  final bool isPassword;
  final bool isEmail;
  final bool enabled;
  final bool isPhone;
  final Widget prefix;

  final String intialLabel;


  MyTextFormField({
    this.hintText,
    this.validator,
    this.enabled,
    this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
    this.isPhone = false,
    this.labelText,
    this.suffixIcon,
    this.prefix,
    this.intialLabel
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: TextFormField(

        initialValue: intialLabel==null?'':intialLabel,
        decoration: InputDecoration(
          prefixIcon:prefix,
          hintText: hintText,
          hintStyle: GoogleFonts.cairo(),
          labelStyle: GoogleFonts.cairo(),
          contentPadding: EdgeInsets.all(15.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          labelText: labelText,
          filled: true,
          suffixIcon: this.suffixIcon,
          fillColor: Color(0xFFEEEEF3),
        ),
        obscureText: isPassword ? true : false,
        validator: validator,
        onSaved: onSaved,
        enabled: enabled,
        keyboardType: isEmail ?isPhone?TextInputType.number :TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
