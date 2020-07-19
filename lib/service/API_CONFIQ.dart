import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:http/http.dart' as http;
import 'package:shoppingapp/modal/Config_Model.dart';

class APICONFIQ{
  static String Base_url='https://d2.woo2.app/';
  static String url=Base_url+'/wp-json/wc/v3';
  static String consumer_key='ck_24b1dd0facc11dd602d29c37caea43f72d68394e';
  static String consumer_secret='cs_c10599bd4dc55e7f10a1bad03d299a9ad60e0ade';
  static String Key='consumer_key=$consumer_key&consumer_secret=$consumer_secret';
  static String   kGoogleApiKey = "AIzaSyBb0GpBvrtNExsQHDb55DcVVnmUgL85w4U";

  //getCategories
  static String getAllCategories=url+'/products/categories?per_page=100&'+Key;
  static String getMainCategories=url+'/products/categories?per_page=100&parent=0&'+Key;
  static String getSubCategories=url+'/products/categories?per_page=100&'+Key;

  //getproducts
  static String getproducts=url+'/products?per_page=100&';
  //getproductsHomepadge
  static String getproductsHome=url+'/products?per_page=6&'+Key;

  //getOrders
  static String getOrder=url+'/orders?'+Key;
  static String Register=url+'/customers?'+Key;
  static String Ubdateplofile=url+'/customers';

  static String setReview=url+'/products/reviews';

  //getPayment
  static String getPayment=url+'/payment_gateways?'+Key;

  ///getShipping
  static String getShipping=url+'/shipping/zones?'+Key;
  static String getCopons=url+'/coupons?';

  //Login
  static String getOrders=url+'/orders?';
  static String Login=Base_url+'/api/auth/generate_auth_cookie/';
  //Register

  static Future<Config_Model> getNewConfiq() async {
    var client = new http.Client();
    var dio = Dio();
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl:
    'https://woo2.app/7l/d3/get_config_3.php'
    )).interceptor);

    Config_Model config_model;
    try {

      var response = await client.get(
        'https://woo2.app/7l/d3/get_config_3.php',
      );
      print(response.body);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        config_model = new Config_Model.fromJson(data);
      } else {
        print('Somthing went wrong');
      }
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
    return config_model;
  }


}