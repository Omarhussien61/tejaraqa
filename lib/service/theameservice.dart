import 'dart:async';
import 'dart:convert';
import 'package:shoppingapp/modal/Theme.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class theame_service{
  static Future<ThemeModel> getNewTheme() async {
    var dio = Dio();
    String URL='https://woo2.app/7l/demo1/get_theme.php';
    dio.interceptors.add(DioCacheManager(
        CacheConfig(baseUrl:URL))
        .interceptor);
    ThemeModel theam;
    try {
      var response = await dio.get(
        URL,
        options: buildCacheOptions(Duration(days: 7)),
      );
      print(json.decode(response.data));
      if (response.statusCode == 200) {
        theam = new ThemeModel.fromJson(json.decode(response.data));
        print(int.parse(theam.primaryCoustom ));
      } else {
        //  return await SharedPreferencesHelper.getThemeColor().toString();
        print('Somthing went wrong');
      }
    } catch (e) {
      print(e);
    } finally {
      dio.close();
    }
    return theam;
  }

}