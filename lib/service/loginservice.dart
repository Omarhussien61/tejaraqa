import 'dart:async';
import 'dart:convert';


import 'package:dio/dio.dart';
import 'package:shoppingapp/modal/User.dart';
import 'package:shoppingapp/modal/productmodel.dart';
import 'package:shoppingapp/modal/usermodal.dart';
import 'package:shoppingapp/service/API_CONFIQ.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingapp/utils/util/Constant.dart';
import 'package:shoppingapp/widgets/register/register_form_model.dart';

class LoginService {
  UserModal userInfo;

  Future<UserModal> loginUser(String user, String password) async {
    var client = new http.Client();
    int code;
    Map<String, dynamic> body = {
      'username': user,
      'password': password,

    };
    try {
      var response = await client.post(
          APICONFIQ.Login,body: body);
      code = response.statusCode;
      print(response.body);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
         userInfo = new UserModal.fromJson(data);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("user_email", userInfo.user.email);
        prefs.setString("user_displayname", userInfo.user.firstname);
        prefs.setString("token", userInfo.cookie);
        prefs.setInt("user_id", userInfo.user.id);
        prefs.setString("password", password);
        prefs.setString("user_nicename", userInfo.user.nicename);
        prefs.setString("image_url", userInfo.user.avatar);
        Constatnt.RegisterState=true;
        return userInfo;
      }

    } catch (e) {
      print(e);
    } finally {}
    return userInfo;
  }
  Future<dynamic>  Register(Model model) async {
    print(model.email);
    Map<String, dynamic> body = {

    };
    Map<String, String> header = new Map();
    String username = APICONFIQ.consumer_key;
    String password = APICONFIQ.consumer_secret;
    var valore = "Basic " + base64Encode(utf8.encode('$username:$password'));
    header.putIfAbsent("Authorization", () {
      return valore;
    });
    var dio = Dio();

    var response = await dio.post(
        APICONFIQ.Register+APICONFIQ.Key,
        data: {
          'email': model.email,
          'first_name': model.firstName,
          'last_name': model.lastName,
          'username': model.userName,
          'password': model.password,
          'meta_data': [
            {
              "key": "phonenumber",
              "value": model.Phone
            }
          ],

        });
    print(response.data);
    if (response.statusCode == 201) {
     return loginUser(model.email,model.password);
    }
    else{
      var data=jsonDecode(response.data);
      return data['message'];
    }
  }


  void ubdateProfile(int _id,String email, String f_Name, String Username,String passwords) async {
    Map<String, dynamic> body = {
      'email': email,
      'first_name': f_Name,
      'nickname': Username,
    };
    Map<String, String> header = new Map();
    String username = APICONFIQ.consumer_key;
    String password = APICONFIQ.consumer_secret;

    var valore = "Basic " + base64Encode(utf8.encode('$username:$password'));
    header.putIfAbsent("Authorization", () {
      return valore;
    });
    print( APICONFIQ.Register+'/$_id');
    var response = await http.post(
        APICONFIQ.Register+'/$_id',headers: header, body: body);
    print(response.body);
    if (response.statusCode == 200) {
      loginUser(email,passwords);
    }
    else{
    }
  }
}
