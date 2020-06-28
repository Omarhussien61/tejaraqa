import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/utils/commons/colors.dart';

class NotFound extends StatefulWidget {
  final String description;

  NotFound(this.description);

  @override
  _NotFoundState createState() => _NotFoundState();
}

class _NotFoundState extends State<NotFound> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/not_found_smile.PNG",
            height: 250,
          ),
          Text(
            widget.description,
            style: GoogleFonts.poppins(color: textColor),
          )
        ],
      ),
    );
  }
}
