import 'dart:async';
import 'dart:convert';
import 'package:shoppingapp/modal/Product_review.dart';
import 'package:shoppingapp/modal/Product_variations.dart';
import 'package:http/http.dart' as http;

import 'package:shoppingapp/modal/Orders_model.dart';
import 'package:shoppingapp/modal/Rat_model.dart';
import 'package:shoppingapp/modal/cart.dart';
import 'package:shoppingapp/modal/createOrder.dart';
import 'package:shoppingapp/modal/productmodel.dart';
import 'package:shoppingapp/modal/reviews.dart';
import 'package:shoppingapp/service/API_CONFIQ.dart';
import 'package:shoppingapp/utils/util/sql_helper.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/rendering.dart';

class ProductService {
  List<Review> reviews;
  List<Orders_model> orders;

  static Future<List<ProductModel>> getNewProducts() async {
    var dio = Dio();
    List<ProductModel> products;
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl:  APICONFIQ.getproductsHome)).interceptor);

    var completer = new Completer<List<ProductModel>>();

    try {
      var response = await dio.get(
        APICONFIQ.getproductsHome,
        options: buildCacheOptions(Duration(days: 7), forceRefresh: true),
      );
      if (response.statusCode == 200) {
        var data = response.data;
        var list = data as List;
        print(list.length);

        completer.complete(products = list
            .map<ProductModel>((i) => ProductModel.fromJson(i))
            .toList());

      } else {
        print('Somthing went wrong');
      }
    } catch (e) {
      print(e);
    } finally {
      dio.close();
    }
    return completer.future;
  }
  static Future<List<ProductModel>> getAllProductsSale() async {
    var dio = Dio();
    List<ProductModel> products;

    var completer = new Completer<List<ProductModel>>();
    try {

      dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl:  APICONFIQ.getproducts+APICONFIQ.Key)).interceptor);

      var response = await dio.get(
      APICONFIQ.getproducts+APICONFIQ.Key,
          options: buildCacheOptions(Duration(days: 7), forceRefresh: true),
    );
      if (response.statusCode == 200) {
        var list = response.data as List;
        completer.complete(products = list
            .map<ProductModel>((i) => ProductModel.fromJson(i))
            .where((data) => data.onSale)
            .toList());
      } else {
        print('Somthing went wrong');
      }
    } catch (e) {
      print(e);
    } finally {
      dio.close();
    }
    return completer.future;
  }
  static Future<List<ProductModel>> getAllProducts(String url) async {
    List<ProductModel> products;
    var dio = Dio();
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl:  APICONFIQ.getproducts+url+APICONFIQ.Key)).interceptor);

    var completer = new Completer<List<ProductModel>>();

    try {
      var response = await dio.get(
        APICONFIQ.getproducts+url+APICONFIQ.Key,
        options: buildCacheOptions(Duration(days: 7), forceRefresh: true),
      );
      if (response.statusCode == 200) {
        var data = response.data;
        var list = data as List;
        print(list.length);

        completer.complete(products = list
            .map<ProductModel>((i) => ProductModel.fromJson(i))
            .toList());

      } else {
        print('Somthing went wrong');
      }
    } catch (e) {
      print(e);
    } finally {
      dio.close();
    }
    return completer.future;
  }
  static Future<List<ProductModel>> getMoreSaleProducts() async {
    List<ProductModel> products;
    var dio = Dio();
    String url='&order=asc&orderby=popularity&filter[meta_key]=total_sales&status=publish&';

    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl:APICONFIQ.getproducts+'&per_page=10'+url+APICONFIQ.Key,)).interceptor);

    var completer = new Completer<List<ProductModel>>();

    try {
      var response = await dio.get(
        APICONFIQ.getproducts+'&per_page=10'+url+APICONFIQ.Key,
        options: buildCacheOptions(Duration(days: 7), forceRefresh: true),
      );
      if (response.statusCode == 200) {
        var data = response.data;
        var list = data as List;
        print(list.length);

        completer.complete(products = list
            .map<ProductModel>((i) => ProductModel.fromJson(i))
            .toList());

      } else {
        print('Somthing went wrong');
      }
    } catch (e) {
      print(e);
    } finally {
      dio.close();
    }
    return completer.future;
  }
  static Future<List<ProductModel>> getLow_Priced_Products() async {
    List<ProductModel> products;
    var dio = Dio();
    String url='&order=asc&orderby=price&filter[meta_key]=total_sales&status=publish&';

    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl:APICONFIQ.getproducts+'&per_page=10'+url+APICONFIQ.Key,)).interceptor);

    var completer = new Completer<List<ProductModel>>();

    try {
      var response = await dio.get(
        APICONFIQ.getproducts+'&per_page=10'+url+APICONFIQ.Key,
        options: buildCacheOptions(Duration(days: 7), forceRefresh: true),
      );
      if (response.statusCode == 200) {
        var data = response.data;
        var list = data as List;
        print(list.length);

        completer.complete(products = list
            .map<ProductModel>((i) => ProductModel.fromJson(i))
            .toList());

      } else {
        print('Somthing went wrong');
      }
    } catch (e) {
      print(e);
    } finally {
      dio.close();
    }
    return completer.future;
  }
  static Future<List<ProductModel>> getRecentviewProducts(String n) async {
    List<ProductModel> products;
    var dio = Dio();
    String link=APICONFIQ.url+'/products?include='+n+'&'+APICONFIQ.Key;

    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: link)).interceptor);

    var completer = new Completer<List<ProductModel>>();

    try {
      var response = await dio.get(link,
        options: buildCacheOptions(Duration(days: 7), forceRefresh: true),
      );
      if (response.statusCode == 200) {
        var data = response.data;
        var list = data as List;
        print(list.length);

        completer.complete(products = list
            .map<ProductModel>((i) => ProductModel.fromJson(i))
            .toList());

      } else {
        print('Somthing went wrong');
      }
    } catch (e) {
      print(e);
    } finally {
      dio.close();
    }
    return completer.future;
  }
  static Future<List<ProductModel>> getRelatedProducts(String n) async {
    List<ProductModel> products;
    var dio = Dio();
    String link=APICONFIQ.url+'/products?include='+n+'&'+APICONFIQ.Key;

    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: link)).interceptor);

    var completer = new Completer<List<ProductModel>>();

    try {
      var response = await dio.get(link,
        options: buildCacheOptions(Duration(days: 7), forceRefresh: true),
      );
      if (response.statusCode == 200) {
        var data = response.data;
        var list = data as List;
        print(list.length);

        completer.complete(products = list
            .map<ProductModel>((i) => ProductModel.fromJson(i))
            .toList());

      } else {
        print('Somthing went wrong');
      }
    } catch (e) {
      print(e);
    } finally {
      dio.close();
    }
    return completer.future;
  }
  static Future<List<Product_variations>> getVriationProducts(int id) async {
    List<Product_variations> products;
    var dio = Dio();
    String link=APICONFIQ.url+'/products/$id/variations?'+APICONFIQ.Key;

    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: link)).interceptor);

    var completer = new Completer<List<Product_variations>>();

    try {
      var response = await dio.get(link,
        options: buildCacheOptions(Duration(days: 7), forceRefresh: true),
      );
      if (response.statusCode == 200) {
        var data = response.data;
        var list = data as List;
        print(response.data);

        completer.complete(products = list
            .map<Product_variations>((i) => Product_variations.fromJson(i))
            .toList());

      } else {
        print('Somthing went wrong');
      }
    } catch (e) {
      print(e);
    } finally {
      dio.close();
    }
    return completer.future;
  }
  static Future<List<Product_review>> getReviewer(int id) async {
    List<Product_review> products;
    var dio = Dio();
    String link=APICONFIQ.url+'/products/reviews?product=$id&'+APICONFIQ.Key;

    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: link)).interceptor);

    var completer = new Completer<List<Product_review>>();

    try {
      var response = await dio.get(link,
        options: buildCacheOptions(Duration(days: 7), forceRefresh: true),
      );
      if (response.statusCode == 200) {
        var data = response.data;
        var list = data as List;
        print(response.data);
        completer.complete(products = list
            .map<Product_review>((i) => Product_review.fromJson(i))
            .toList());
      } else {
        print('Somthing went wrong');
      }
    } catch (e) {
      print(e);
    } finally {
      dio.close();
    }
    return completer.future;
  }
  Future<List<Orders_model>> getOrdersDetails(int id) async {
    var completer = new Completer<List<Orders_model>>();
    var dio = Dio();
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl:  APICONFIQ.getproducts)).interceptor);    var response;
    var data;
    try {
     var response = await dio.get(
          APICONFIQ.getOrders+'customer=$id&'+APICONFIQ.Key,
       options: buildCacheOptions(Duration(days: 7), forceRefresh: true),

     );
      if (response.statusCode == 200) {
        print(response.data);
        var list = response.data as List;
        completer.complete(orders =
            list.map<Orders_model>((i) => Orders_model.fromJson(i)).toList());
      }
    } catch (e) {
      print(e);
    }
    return completer.future;
  }
  static Future<Rat_model> Createrating(String name,String email,int id,double rating,String review ) async {
    var client = new http.Client();
    Rat_model rat_model;
    Map<String, dynamic> body = {
      "product_id": '$id',
      "review": review,
      "reviewer": name,
      "reviewer_email": email,
      "rating": '$rating'
    };
    Map<String, String> header = new Map();
    String username = APICONFIQ.consumer_key;
    String password = APICONFIQ.consumer_secret;

    var valore = "Basic " + base64Encode(utf8.encode('$username:$password'));
    header.putIfAbsent("Authorization", () {
      return valore;
    });
    print(body);

    try {
      var response = await client.post(
          APICONFIQ.setReview,body: body,headers: header);
      if (response.statusCode==201){
        print(response.body);
        rat_model = new Rat_model.fromJson(jsonDecode(response.body));
        return rat_model;
      }
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }
}

