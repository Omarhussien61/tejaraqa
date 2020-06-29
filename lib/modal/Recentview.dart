

import 'package:scoped_model/scoped_model.dart';

class Recentview extends Model{

  int _id;
  int _count;


  Recentview(this._id, this._count);

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = this._id;
    map["count"] = this._count;


    return map;
  }

  Recentview.getMap(Map<String, dynamic> map){
    this._id = map["id"];
    this._count = map["count"];

  }

  int get count => _count;

  set count(int value) {
    _count = value;
  }


}