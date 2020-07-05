import 'dart:async';
import 'dart:convert';

import 'package:shoppingapp/modal/ConfirmOrder.dart';
import 'package:shoppingapp/modal/PaymentModel.dart';
import 'package:shoppingapp/modal/ShippingModel.dart';
import 'package:shoppingapp/modal/cart.dart';
import 'package:shoppingapp/modal/coupons.dart';
import 'package:shoppingapp/modal/createOrder.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:shoppingapp/service/API_CONFIQ.dart';
import 'package:shoppingapp/utils/util/sql_helper.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';


class OrderService {

  List<PaymentModel> payments;
  static Future<List<PaymentModel>> getAllPayment() async {
    List<PaymentModel> payments;
    var dio = Dio();
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: APICONFIQ.getPayment)).interceptor);
    var completer = new Completer<List<PaymentModel>>();
    try {
      var response = await dio.get(
          APICONFIQ.getPayment,
        options: buildCacheOptions(Duration(days: 7), forceRefresh: true),

      );
      if (response.statusCode == 200) {
        print(response.data);
        var list = response.data as List;
        completer.complete(payments = list
            .map<PaymentModel>((i) => PaymentModel.fromJson(i))
            .where((data) => data.enabled)
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


  List<ShippingModel> shippingZone;
  static Future<List<ShippingModel>> getAllshippingZone() async {
    List<ShippingModel> shippingZone;
    var dio = Dio();
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: APICONFIQ.getShipping)).interceptor);    var completer = new Completer<List<ShippingModel>>();
    try {
      var response = await dio.get(
          APICONFIQ.getShipping,
        options: buildCacheOptions(Duration(days: 7), forceRefresh: true),
      );
      if (response.statusCode == 200) {
        var list = response.data as List;
        completer.complete(shippingZone = list
            .map<ShippingModel>((i) => ShippingModel.fromJson(i))
            .where((data) => data.id!=0)
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

  List<Coupons> coupons;
  static Future<double> getCoupons(String code) async {
    List<Coupons> coupons;
    var dio = Dio();
    String URL=APICONFIQ.getCopons+APICONFIQ.Key+'&code=$code';
        dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: APICONFIQ.getCopons)).interceptor);
    Coupons coupon;
    try {
      var response = await dio.get(URL,
        options: buildCacheOptions(Duration(days: 7), forceRefresh: true),
      );
      if (response.statusCode == 200) {
        var list = response.data as List;
         coupon = new Coupons.fromJson(list[0]);
         print(list[0]);
        var moonLanding = DateTime.parse(coupon.dateExpires);
        if(moonLanding.difference(DateTime.now()).inHours>=1)
          return double.parse(coupon.amount);else return 0;

      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;

    } finally {
      dio.close();
    }
  }




  List<Cart> studentsList;
  int count = 0;
  static Future<ConfirmOrder> createorder(List<LineItems> items,
      String custId,String city,String address,String phone,
      String name,String country,String email,
  String paymentMethod,String paymentMethodTitle,String coponCode) async {
    SQL_Helper helper = new SQL_Helper();
    createOrder order;
    Billing billing;
    Shippings shipping;
    List<ShippingLines>  shippingLines=new List<ShippingLines> ();
    List<coupon_lines>  coupon_line=new List<coupon_lines> ();

    billing=new Billing(
        firstName: name,
        address2: '',
        country: country,
        email: email,
        lastName: '',
        postcode: '',
        address1: address,
        phone: phone,
        city: city,
        state: '');

    shipping=new Shippings(
        state: '',city: city,
        address1: address,
        postcode: '',
        country: country,
        lastName: '',
        firstName: name,
        address2: '');
    shippingLines.add(new ShippingLines(methodId: 'flat_rate',methodTitle: "سعر ثابت",total:'100'));
    coupon_line.add(new coupon_lines(code: coponCode));

    order=new createOrder(
      paymentMethod: paymentMethod,
      paymentMethodTitle:  paymentMethodTitle,
      customer_id: custId,
      lineItems: items,
      shipping: shipping,
      billing: billing,
      shippingLines: shippingLines,
      coupon_line: coupon_line
    );
    var dio = Dio();

ConfirmOrder confirmOrder;
    try {
      print(order.toJson());
      Response response = await dio.post(
          APICONFIQ.getOrder,
          data:order.toJson());
      if (response.statusCode==201){
        print(response.data);
        confirmOrder = new ConfirmOrder.fromJson(response.data);
        helper.deleteall();
        return confirmOrder;
      }
    } catch (e) {
      print(e);
    } finally {
      dio.close();
    }
  }
}

