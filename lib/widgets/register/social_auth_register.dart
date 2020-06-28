import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/types/gf_button_type.dart';
import 'package:shoppingapp/utils/keyboard.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_change.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

class SocialRegisterButtons extends StatelessWidget {
  final ThemeNotifier themeColor;

  const SocialRegisterButtons({Key key, this.themeColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = ThemeChanger(context);
    return Container(
      padding: EdgeInsets.only(
          right: 36,
          left: 48,
          bottom: KeyboardUtil.isKeyboardShowing(context)
              ? ScreenUtil.getHeight(context) / 2.2
              : 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GFButton(
              icon: SvgPicture.asset("assets/icons/google_icon.svg",
                  semanticsLabel: 'Acme Logo'),
              buttonBoxShadow: true,
              boxShadow: BoxShadow(
                color: themeColor.getColor().withOpacity(0.6),
                blurRadius: 6,
                offset: Offset(0, 0),
              ),
              color: themeColor.getColor(),
              onPressed: () {
                _themeChanger.openFullMaterialColorPicker(themeColor);
              },
              text: "     Google     "),
          GFButton(
              icon: SvgPicture.asset("assets/icons/facebook_icon.svg",
                  semanticsLabel: 'Acme Logo'),
              type: GFButtonType.solid,
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
