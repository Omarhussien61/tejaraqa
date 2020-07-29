

import 'package:scoped_model/scoped_model.dart';

class FavoriteModel extends Model{

  int _id;
  String _name;
  String _category;
  String _price;
  String _image;


  FavoriteModel( this._id, this._name, this._category, this._price,
      this._image);


  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = this._id;
    map["name"] = this._name;
    map["category"] = this._category;
    map["prise"] = this._price;
    map["image"] = this._image;
    return map;
  }

  FavoriteModel.getMap(Map<String, dynamic> map){
    this._id = map["id"];
    this._name = map["name"];
    this._category = map["category"];
    this._price =map["prise"];
    this._image = map["image"];
  }




  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get price => _price;

  set price(String value) {
    _price = value;
  }

  String get category => _category;

  set category(String value) {
    _category = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}