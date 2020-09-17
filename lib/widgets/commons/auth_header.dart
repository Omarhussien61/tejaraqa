import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/pages/login_page.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

class AuthHeader extends StatelessWidget {
  final String headerTitle;
  final String headerBigTitle;
  final bool isLoginHeader;

  AuthHeader({this.headerTitle, this.headerBigTitle, this.isLoginHeader});

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    return Container(
      padding: EdgeInsets.all(16),
      height: ScreenUtil.getHeight(context) * 0.3,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 100,
              ),
              Text(
                headerTitle,
                style: GoogleFonts.cairo(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),

            ],
          ),

          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 8,
              top: 100),
              child: CachedNetworkImage(
                height: 200,
                width: 200,
                imageUrl:  'https://tejaraqa.com/wp-content/uploads/2020/08/1-e1598682256275.png',
              ),
            ),
          )
        ],
      ),
    );
  }
}
