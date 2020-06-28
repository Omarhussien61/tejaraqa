import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:shoppingapp/utils/keyboard.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({
    Key key,
    @required this.themeColor,
  }) : super(key: key);

  final ThemeNotifier themeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 12,
          right: 48,
          left: 48,
          bottom: KeyboardUtil.isKeyboardShowing(context)
              ? ScreenUtil.getHeight(context) / 2.2
              : 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GFButton(
              icon: SvgPicture.asset(
                "assets/icons/google_icon.svg",
                semanticsLabel: 'Acme Logo',
//                color: themeColor.getColor(),
                color: Colors.white,
              ),
              buttonBoxShadow: true,
              boxShadow: BoxShadow(
                color: themeColor.getColor().withOpacity(0.6),
                blurRadius: 6,
                offset: Offset(0, 0),
              ),
              color: themeColor.getColor(),
//              type: GFButtonType.outline,
              onPressed: () {},
              text: "     Google     "),
          GFButton(
              icon: SvgPicture.asset(
                "assets/icons/facebook_icon.svg",
                semanticsLabel: 'Acme Logo',
//                color: themeColor.getColor(),
                color: Colors.white,
              ),
//              type: GFButtonType.outline,
              buttonBoxShadow: true,
              boxShadow: BoxShadow(
                color: themeColor.getColor().withOpacity(0.6),
                blurRadius: 6,
                offset: Offset(0, 0),
              ),
              color: themeColor.getColor(),
              onPressed: () {},
              text: "     Facebook     "),
        ],
      ),
    );
  }
}
