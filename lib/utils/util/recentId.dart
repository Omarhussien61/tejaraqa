
import 'package:shoppingapp/modal/Recentview.dart';
import 'package:shoppingapp/utils/util/sql_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class SQL_Rercent {

  static SQL_Rercent dbHelper;
  static Database _database;

  SQL_Rercent._createInstance();

  factory SQL_Rercent() {
    if (dbHelper == null) {
      dbHelper = SQL_Rercent._createInstance();
    }
    return dbHelper;
  }
  String tableName = "Recent_table";
  String _idRecent = "id";
  String _idCount = "count";

  Future<Database> get database async {
    SQL_Helper helper = new SQL_Helper();

    if (_database == null){
      _database = await helper.initializedDatabase();
    }
    return _database;
  }



  Future<List<Map<String, dynamic>>> getStudentMapList() async {
    Database db = await this.database;
    //var result1 =  await db.rawQuery("SELECT * FROM $tableName ORDER BY $_id ASC");
    var result = await db.query(tableName, orderBy: "$_idCount ASC");
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
    var  result = await db.query(tableName, where: "$_idRecent = ?", whereArgs: [id]);
    return (result.isEmpty)?true:false;
  }

  Future<int> insertRecentView(Recentview student) async {
    Database db = await this.database;
    var result = await db.insert(tableName, student.toMap());
    return result;
  }
  Future<int> updateRecentView(Recentview student) async{
    Database db = await this.database;
    var result = await db.update(tableName, student.toMap(), where: "$_idRecent = ?", whereArgs: [student.id]);
    return result;
  }
  Future<int> deleteRecentView(int id) async {
    var db = await this.database;
    int result = await db.rawDelete("DELETE FROM $tableName WHERE $_idRecent = $id");
    return result;
  }
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> all = await db.rawQuery("SELECT COUNT (*) FROM $tableName");
    int result = Sqflite.firstIntValue(all);
    return result;
  }


  Future<List<Recentview>> getRecentViewList() async{

    var studentMapList = await getStudentMapList();
    int count = studentMapList.length;

    List<Recentview> students = new List<Recentview>();

    for (int i = 0; i <= count -1; i++){
      students.add(Recentview.getMap(studentMapList[i]));
    }

    return students;
  }


  void deleteall() async {
    var db = await this.database;
    int result = await db.rawDelete("DELETE FROM $tableName ");
  }

}