import 'dart:async';
import 'dart:convert';


import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/main.dart';
import 'package:shoppingapp/modal/Create_user.dart';
import 'package:shoppingapp/modal/User.dart';

import 'package:shoppingapp/modal/usermodal.dart';
import 'package:shoppingapp/service/API_CONFIQ.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/Constant.dart';
import 'package:shoppingapp/utils/util/shared_preferences_helper.dart';
import 'package:shoppingapp/widgets/register/register_form_model.dart';
class LoginService {
  UserModal userInfo;
  Future<UserModal> loginUser(String user, String pass) async {
    var client = new http.Client();
    int code;
    Map<String, dynamic> body = {
      'username': user,
      'password': pass,
    };
    try {
      var response = await client.post(
          APICONFIQ.Login,body: body);
      print(response.body);
      code = response.statusCode;
      Map<String, String> header = new Map();
      String username = APICONFIQ.consumer_key;
      String password = APICONFIQ.consumer_secret;
      var valore = "Basic " + base64Encode(utf8.encode('$username:$password'));
      header.putIfAbsent("Authorization", () {
        return valore;
      });

      print(response.body);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
         userInfo = new UserModal.fromJson(data);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("user_email", userInfo.user.email);

        prefs.setString("user_Fristname", userInfo.user.firstname);
        prefs.setString("user_lastname", userInfo.user.lastname);

        prefs.setString("token", userInfo.cookie);
        prefs.setInt("user_id", userInfo.user.id);
        prefs.setString("password", pass);

        prefs.setString("user_nicename", userInfo.user.firstname+' '+userInfo.user.lastname);
        prefs.setString("image_url", userInfo.user.avatar);
        var resp =await client.get(APICONFIQ.Register+userInfo.user.id.toString(),
            headers:header);
          var da = json.decode(resp.body)['meta_data'];
          prefs.setString("phone", da[0]['value']);

        Constatnt.RegisterState=true;
        return userInfo;
      }

    } catch (e) {
      print(e);
    } finally {}
    return userInfo;
  }
  Future<dynamic>  Register(User model) async {
    var client = new http.Client();
    Map<String, String> header = new Map();
    String username = APICONFIQ.consumer_key;
    String password = APICONFIQ.consumer_secret;
    var valore = "Basic " + base64Encode(utf8.encode('$username:$password'));
    header.putIfAbsent("Authorization", () {
      return valore;
    });
    List<MetaData_user> metaData=new List<MetaData_user>();
    metaData.add(MetaData_user(
        key: 'phonenumber',
        value: model.phone));

    var body = json.encode({
      'email': model.email,
      'first_name': model.firstName,
      'last_name': model.lastName,
      'username': model.username,
      'password': model.password,
      "meta_data": metaData
    });
    var bodyWithoutPassword = json.encode({
      'email': model.email,
      'first_name': model.firstName,
      'last_name': model.lastName,
      'username': model.username,
      "meta_data": metaData
    });
    print(body.toString());

    http.Response response = await http.post(
        APICONFIQ.Register,
        body: model.password==null?bodyWithoutPassword:body,
        headers: {'Content-type': 'application/json'});

    print(response.body);
    if (response.statusCode == 201) {
      var user = new User.fromJson(jsonDecode(response.body));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("user_email", model.email);
      prefs.setString("user_Fristname", user.firstName);
      prefs.setString("user_lastname", user.lastName);
      prefs.setString("token", model.id.toString());
      prefs.setInt("user_id",  model.id);
      prefs.setString("password", model.password);
      prefs.setString("user_nicename",  model.firstName+' '+model.lastName);
      prefs.setString("phone", model.phone);
     return loginUser(model.email,model.password);
    }
    else{
      var data=jsonDecode(response.body);
      return data['message'];
    }
  }
  Future<dynamic>  Login_Social(UserM model,BuildContext context) async {

    String email=model.email;
    http.Response response = await http.get(
        APICONFIQ.Register+'&email=$email',
       );
    print(response.body);
    if (response.statusCode == 200) {
      var list = json.decode(response.body) as List;
      if(list.isEmpty){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text('Alart'),
              content: new Text('No email registered please register'),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
              ],
            );
          },
        );
      }else {
        User user = new User.fromJson(list[0]);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("user_email", user.email);
        prefs.setString("user_Fristname", user.firstName);
        prefs.setString("user_lastname", user.lastName);
        prefs.setString("token", user.id.toString());
        prefs.setInt("user_id", user.id);
        prefs.setString("user_nicename", user.firstName+' '+user.lastName);
        prefs.setString("image_url", model.avatar);
        var resp =await http.get(APICONFIQ.Ubdateplofile+'/'+user.id.toString()+'?'+ APICONFIQ.Key);
        var da = json.decode(resp.body)['meta_data'];
        prefs.setString("phone", da[0]['value']);

        Nav.routeReplacement(context, InitPage());
        Provider.of<ThemeNotifier>(context).setLogin(true);
      }
    }
    else{
      var data=jsonDecode(response.body);
      return data['message'];
    }
  }
  void ubdateProfile(int _id,String email, String f_Name, String l_Name,String phone) async {
    print(phone);
    List<MetaData_user> metaData=new List<MetaData_user>();
    metaData.add(MetaData_user(
        key: 'phonenumber',
        value: phone));
    var body =json.encode( {
      'email': email,
      'first_name': f_Name,
      'last_name': l_Name,
      "meta_data": [{"key":"phonenumber","value":"$phone"}]
    });
    print( body);
    var client = new http.Client();
    print( APICONFIQ.Ubdateplofile+'/$_id?'+ APICONFIQ.Key);
    Dio dio=new Dio();
    var response = await dio.post(
        APICONFIQ.Ubdateplofile+'/$_id?'+ APICONFIQ.Key, data: body);
    print(response.data);
    if (response.statusCode == 200) {
      var user = new User.fromJson(response.data);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("user_email", user.email);
      prefs.setString("user_Fristname", user.firstName);
      prefs.setString("user_lastname", user.lastName);
      prefs.setString("phone", user.metaData[0].value);

      // loginUser(email,passwords);
    }
    else{
    }
  }
  void ubdatePassword(int _id,String pass) async {
    Map<String, dynamic> body = {
      'password': pass,
    };
    Map<String, String> header = new Map();
    String username = APICONFIQ.consumer_key;
    String password = APICONFIQ.consumer_secret;

    var valore = "Basic " + base64Encode(utf8.encode('$username:$password'));
    header.putIfAbsent("Authorization", () {
      return valore;
    });
    print( APICONFIQ.Ubdateplofile+'/$_id');
    var client = new http.Client();

    var response = await client.post(
        APICONFIQ.Ubdateplofile+'/$_id',headers: header, body: body);
    print(response.body);
    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("password", pass);

    }
    else{
    }
  }

}
