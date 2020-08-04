import 'package:flutter/material.dart';
import 'package:shoppingapp/modal/cart.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class SQL_Helper {

  static SQL_Helper dbHelper;
  static Database _database;

  SQL_Helper._createInstance();

  factory SQL_Helper() {
    if (dbHelper == null) {
      dbHelper = SQL_Helper._createInstance();
    }
    return dbHelper;
  }

  String tableName = "Cart_table";
  String _id = "id";
  String _idVariation = "idvar";

  String __name = "name";
  String __quantity = "quantity";
  String __pass = "prise";
  String __date = "date";
  String __image = "image";
  String _Currancy = "currancy";

  String _tableNameRecent = "Recent_table";
  String _idRecent = "id";
  String _idCount = "count";


  String _tableNameAddress = "address_table";
  String _idAddress = "id";
  String __title = "title";
  String __country = "country";
  String __city = "city";
  String __street = "street";
  String __bilidingNo = "bilidingNo";
  String __ApratNo = "addres1";
  String __lat = "lat";
  String __lang = "lang";


  String tableFavorite = "favorite_table";
  String __nameFavorite = "name";
  String __priseFavorite = "prise";
  String __Categoryname = "category";
  String __imageFavorite = "image";

  Future<Database> get database async {
      if (_database == null){
          _database = await initializedDatabase();
      }
      return _database;
  }

  Future<Database> initializedDatabase() async {

    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "database.db";

     var cartDB = await openDatabase(path, version: 1, onCreate: createDatabase);
     return cartDB;
  }

  void createDatabase(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableName($_id INTEGER PRIMARY KEY,$_idVariation INTEGER , $__name TEXT, $_Currancy TEXT, $__quantity INTEGER," +
            " $__pass DOUBLE, $__date TEXT , $__image TEXT )");
    await db.execute(
        "CREATE TABLE $_tableNameAddress($_idAddress INTEGER PRIMARY KEY, $__title TEXT, $__country TEXT, $__city TEXT," +
            " $__street TEXT, $__bilidingNo TEXT , $__ApratNo TEXT, $__lat DOUBLE , $__lang DOUBLE )");

    await db.execute(
        "CREATE TABLE $_tableNameRecent($_idRecent INTEGER PRIMARY KEY, $_idCount INTEGER)");
    await db.execute(
        "CREATE TABLE $tableFavorite($_id INTEGER PRIMARY KEY, "
            " $__nameFavorite TEXT, $__priseFavorite TEXT," +
            " $__Categoryname TEXT, $__imageFavorite TEXT  )");
  }

   Future<List<Map<String, dynamic>>> getcartMapList() async {
       Database db = await this.database;
       //var result1 =  await db.rawQuery("SELECT * FROM $tableName ORDER BY $_id ASC");
       var result = await db.query(tableName, orderBy: "$_id ASC");
       return result;
  }


  Future<bool> checkDatabase() async {
    Database db = await this.database;
    //var result1 =  await db.rawQuery("SELECT * FROM $tableName ORDER BY $_id ASC");
    var  result = await db.query(tableName);
    return (result.isEmpty)?true:false;
  }

  Future<bool> checkItem(int id) async {
    Database db = await this.database;
    //var result1 =  await db.rawQuery("SELECT * FROM $tableName ORDER BY $_id ASC");
    var  result = await db.query(tableName, where: "$_id = ?", whereArgs: [id]);
    return (result.isEmpty)?true:false;
  }

  Future<int> insertCart(Cart cart) async {
    Database db = await this.database;
    var result = await db.insert(tableName, cart.toMap());
    return result;
  }

  Future<int> updateCart(Cart cart) async{
    Database db = await this.database;
    var result = await db.update(tableName, cart.toMap(), where: "$_id = ?", whereArgs: [cart.id]);
    return result;
  }
  Future<Cart> updateCartCount(int id) async{
    Database db = await this.database;
    var result = await db.query(tableName,
        where: "$_id = ?", whereArgs: [id]);
    return Cart.getMap(result[0]);
  }

  Future<int> deleteCart(int id) async {
    var db = await this.database;
    int result = await db.rawDelete("DELETE FROM $tableName WHERE $_id = $id");
    return result;
  }
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> all = await db.rawQuery("SELECT COUNT (*) FROM $tableName");
    int result = Sqflite.firstIntValue(all);
    return result;
  }


  Future<List<Cart>> getDataList() async{
    
    var cartMapList = await getcartMapList();
    int count = cartMapList.length;
    
    List<Cart> carts = new List<Cart>();
    
    for (int i = 0; i <= count -1; i++){
      carts.add(Cart.getMap(cartMapList[i]));
    }

    return carts;
  }


  void deleteall() async {
    var db = await this.database;
    int result = await db.rawDelete("DELETE FROM $tableName ");
  }

}