import 'dart:async';
import 'dart:convert';

import 'package:shoppingapp/modal/category.dart';
import 'package:shoppingapp/modal/productmodel.dart';
import 'package:shoppingapp/service/API_CONFIQ.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class CategoryService {
  List<Category> category;
  List<Category> Subcategory;
  List<ProductModel> categoryList;
  Future<List<Category>> getAllCategory() async {
    var completer = new Completer<List<Category>>();
    var dio = Dio();
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl:  APICONFIQ.getAllCategories)).interceptor);
    try {
      var response = await dio.get(APICONFIQ.getAllCategories,
        options: buildCacheOptions(Duration(days: 7), forceRefresh: true),
      );
      if (response.statusCode == 200) {
        var list = response.data as List;
        completer.complete(category =
            list.map<Category>((i) => Category.fromJson(i)).toList());
      }
    } catch (e) {
      print(e);
    }
    return completer.future;
  }



  Future<List<Category>> getMainCategory() async {
    var completer = new Completer<List<Category>>();
    var dio = Dio();
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl:  APICONFIQ.getMainCategories)).interceptor);
    try {
     var response = await dio.get(APICONFIQ.getMainCategories,
       options: buildCacheOptions(Duration(days: 7), forceRefresh: true),
     );
      if (response.statusCode == 200) {
        var list = response.data as List;
        completer.complete(category =
            list.map<Category>((i) => Category.fromJson(i)).toList());
      }
    } catch (e) {
      print(e);
    }
    return completer.future;
  }
  Future<List<Category>> getSubCategory() async {
    var completer = new Completer<List<Category>>();
    var dio = Dio();
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl:  APICONFIQ.getSubCategories)).interceptor);
    try {
      var response = await dio.get(APICONFIQ.getSubCategories,
        options: buildCacheOptions(Duration(days: 7), forceRefresh: true),
      );
      if (response.statusCode == 200) {
        var list = response.data as List;
        completer.complete(category = list.map<Category>((i) => Category.fromJson(i))
            .where((data) => data.parent!=0)
            .toList());
      }
    } catch (e) {
      print(e);
    }
    return completer.future;
  }

  Future<List<Category>> getCategoryDetails(int id) async {
    var completer = new Completer<List<Category>>();
    var dio = Dio();

    String url = APICONFIQ.url+'/products/categories?per_page=100&parent=$id&'+APICONFIQ.Key;
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: url)).interceptor);
    try {
      var response = await dio.get(
        url,
        options: buildCacheOptions(Duration(days: 7), forceRefresh: true),
      );
      if (response.statusCode == 200) {
        var list = response.data as List;
        completer.complete(Subcategory =
            list.map<Category>((i) => Category.fromJson(i)).toList());
      }
    } catch (e) {
      print(e);
    }
    return completer.future;
  }

  Future<List<ProductModel>> getSubCategoryDetails(int id, int currentPage,String url) async {
    var completer = new Completer<List<ProductModel>>();
    var dio = Dio();

    String baseurl=APICONFIQ.getproducts+'category=$id'+url+'&'+APICONFIQ.Key;

    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: baseurl)).interceptor);    var response;
    try {
      var response = await dio.get(
       baseurl,
        options: buildCacheOptions(Duration(days: 7), forceRefresh: true),
      );
      print(response.data);
      if (response.statusCode == 200) {
        var list = response.data as List;
        completer.complete(categoryList =
            list.map<ProductModel>((i) => ProductModel.fromJson(i)).toList());
      }
    } catch (e) {
      print(e);
    }
    return completer.future;
  }
}
