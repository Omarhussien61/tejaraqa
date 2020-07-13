import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shoppingapp/modal/Profilefacebook.dart';
import 'package:shoppingapp/modal/usermodal.dart';
import 'package:shoppingapp/service/loginservice.dart';
import 'package:shoppingapp/utils/keyboard.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
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
              onPressed: () {_login(context);},
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
      UserM user=new UserM(email: _googleSignIn.currentUser.email,
          displayname: _googleSignIn.currentUser.displayName,
          firstname: _googleSignIn.currentUser.displayName,
          avatar: _googleSignIn.currentUser.photoUrl
      );
      LoginService().Login_Social(user,context);
     // Navigator.push(context, MaterialPageRoute(builder: (context) => NextRegisterPage(user)));
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
        UserM user=new UserM(email:profile.email,
            firstname: profile.name,
            displayname: profile.name,
            avatar: profile.picture.data.url
        );

        LoginService().Login_Social(user,context);

        break;

      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        break;
    }

  }
}
