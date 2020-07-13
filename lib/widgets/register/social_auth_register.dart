import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/types/gf_button_type.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shoppingapp/modal/Profilefacebook.dart';
import 'package:http/http.dart' as http;
import 'package:shoppingapp/modal/User.dart';
import 'dart:convert' as JSON;
import 'package:shoppingapp/modal/usermodal.dart';
import 'package:shoppingapp/pages/next_register_page.dart';
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
                _login(context);
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
              onPressed: () {
                _loginWithFB(context);
              },
              text: "     Facebook     "),
        ],
      ),
    );
  }
  _login(BuildContext context) async{
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    try{
      await _googleSignIn.signIn();
      print(_googleSignIn.currentUser);
      User user=new User(email: _googleSignIn.currentUser.email,
          firstName: _googleSignIn.currentUser.displayName,
          username: _googleSignIn.clientId,
          avatarUrl: _googleSignIn.currentUser.photoUrl
      );

        Navigator.push(context, MaterialPageRoute(builder: (context) => NextRegisterPage(user)));
    } catch (err){
      print(err);
    }
  }
  _loginWithFB(BuildContext context) async {
    final facebookLogin = FacebookLogin();
    Profile profile;
    final result = await facebookLogin.logInWithReadPermissions(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profil = JSON.jsonDecode(graphResponse.body);
        print(graphResponse.body);
        profile = new Profile.fromJson(profil);
        User user=new User(email:profile.email,
            username: profile.id,
            firstName: profile.name,
            avatarUrl:  profile.picture.data.url
        );
        print(user.username);
        Navigator.push(context, MaterialPageRoute(builder: (context) => NextRegisterPage(user)));

        break;

      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        break;
    }

  }

}
