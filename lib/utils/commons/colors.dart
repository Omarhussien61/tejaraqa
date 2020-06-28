import 'package:flutter/material.dart';

//const Color mainColor = Color(0xFF0055FF);

Color textColor = Color(0xFFA1B1C2);
Color subTextColor = Color(0xFF707070);
Color greyBackground = Color.fromARGB(255, 252, 252, 252);

Color whiteColor = Colors.white;

Color textFieldFillColor = Colors.grey[50];
const Color textFieldIconColor = Color(0xFF5D6A78);
const Color categoryIconColor = Color(0xFFB3C0C8);

Color colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}
