import 'package:flutter/material.dart';
import 'package:shoppingapp/modal/Favorite.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class favorite_sql {

  static favorite_sql dbHelper;
  static Database _database;

  favorite_sql._createInstance();

  factory favorite_sql() {

    if (dbHelper == null) {
      dbHelper = favorite_sql._createInstance();
    }
    return dbHelper;
  }

  String tableFavorite = "favorite_table";
  String _id = "id";
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
    var studentDB = await openDatabase(path, version: 1, onCreate: createDatabase);
    return studentDB;
  }

  void createDatabase(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableFavorite($_id INTEGER PRIMARY KEY ,"
            " $__nameFavorite TEXT, $__priseFavorite TEXT," +
            " $__Categoryname TEXT, $__imageFavorite TEXT  )");
  }

  Future<List<Map<String, dynamic>>> getStudentMapList() async {
    Database db = await this.database;
    //var result1 =  await db.rawQuery("SELECT * FROM $tableName ORDER BY $_id ASC");
    var result = await db.query(tableFavorite, orderBy: "$_id ASC");
    return result;
  }


  Future<bool> checkDatabase() async {
    Database db = await this.database;
    //var result1 =  await db.rawQuery("SELECT * FROM $tableName ORDER BY $_id ASC");
    var  result = await db.query(tableFavorite);
    return (result.isEmpty)?true:false;
  }

  Future<bool> checkItem(int id) async {
    Database db = await this.database;
    //var result1 =  await db.rawQuery("SELECT * FROM $tableName ORDER BY $_id ASC");
    var  result = await db.query(tableFavorite, where: "$_id = ?", whereArgs: [id]);
    return (result.isEmpty)?true:false;
  }

  Future<int> insertAddress(FavoriteModel student) async {
    Database db = await this.database;
    var result = await db.insert(tableFavorite, student.toMap());
    return result;
  }
  Future<int> updateAddress(FavoriteModel student) async{
    Database db = await this.database;
    var result = await db.update(tableFavorite, student.toMap(), where: "$_id = ?", whereArgs: [student.id]);
    print(result);
    return result;
  }
  Future<int> deleteAddress(int id) async {
    var db = await this.database;
    int result = await db.rawDelete("DELETE FROM $tableFavorite WHERE $_id = $id");
    return result;
  }
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> all = await db.rawQuery("SELECT COUNT (*) FROM $tableFavorite");
    int result = Sqflite.firstIntValue(all);
    return result;
  }


  Future<List<FavoriteModel>> getStudentList() async{

    var studentMapList = await getStudentMapList();
    int count = studentMapList.length;

    List<FavoriteModel> students = new List<FavoriteModel>();

    for (int i = 0; i <= count -1; i++){
      students.add(FavoriteModel.getMap(studentMapList[i]));
      print(studentMapList.length);
    }

    return students;
  }


  void deleteall() async {
    var db = await this.database;
    int result = await db.rawDelete("DELETE FROM $tableFavorite ");
  }

}