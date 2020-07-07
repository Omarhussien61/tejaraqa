import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static setUserId(int userId) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setInt('user_id', userId);
  }

  static getUserId() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getInt('user_id') ?? 0;
  }

  static getUsername() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.getString('user_nicename') ?? 'user';
  }


  static getpassword() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.getString('password') ?? 'password';
  }

  static getEmail() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.getString('user_email') ?? '';
  }


  static getname() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.getString('user_displayname') ?? 'Guest';
  }
  static setUserimage(String image) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString('image_url', image);
  }
  static getphone() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.getString('phone') ?? 'no phone';
  }
  static getUserimage() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('image_url') ??
        'https://lh3.googleusercontent.com/proxy/q-bXPBHZ6sx5wVanVMfz41o9yL0OrKeU922Y15sXottrteKXQi796o_Q7peL06gtz9INbvg_-IBwG7KPrHXLe1laonsSKasNGkdON-TsZeQwfY0v_9y5w7jlPovlxJtO7q_1fzTNiQ';
  }

  static setCookie(String cookie) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString('token', cookie);
  }

  static getCookie() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
  static cleanlocal() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.clear();
  }
}