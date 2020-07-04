import 'package:flutter/material.dart';
import 'package:shoppingapp/modal/Address_shiping.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class SQL_Address {

  static SQL_Address dbHelper;
  static Database _database;

  SQL_Address._createInstance();

  factory SQL_Address() {

    if (dbHelper == null) {
      dbHelper = SQL_Address._createInstance();
    }
    return dbHelper;
  }

  String tableName = "address_table";
  String _id = "id";
  String __country = "country";
  String __city = "city";
  String __street = "street";
  String __bilidingNo = "bilidingNo";
  String __ApratNo = "addres1";
  String __lat = "lat";
  String __lang = "lang";

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
        "CREATE TABLE $tableName($_id INTEGER PRIMARY KEY, $__country TEXT, $__city INTEGER," +
            " $__street DOUBLE, $__bilidingNo TEXT , $__ApratNo TEXT, $__lat DOUBLE , $__lang DOUBLE )");
  }

  Future<List<Map<String, dynamic>>> getStudentMapList() async {
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

  Future<int> insertStudent(Address_shiping student) async {
    Database db = await this.database;
    var result = await db.insert(tableName, student.toMap());
    return result;
  }
  Future<int> updateStudent(Address_shiping student) async{
    Database db = await this.database;
    var result = await db.update(tableName, student.toMap(), where: "$_id = ?", whereArgs: [student.id]);
    return result;
  }
  Future<int> deleteStudent(int id) async {
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


  Future<List<Address_shiping>> getStudentList() async{

    var studentMapList = await getStudentMapList();
    int count = studentMapList.length;

    List<Address_shiping> students = new List<Address_shiping>();

    for (int i = 0; i <= count -1; i++){
      students.add(Address_shiping.getMap(studentMapList[i]));
    }

    return students;
  }


  void deleteall() async {
    var db = await this.database;
    int result = await db.rawDelete("DELETE FROM $tableName ");
  }

}