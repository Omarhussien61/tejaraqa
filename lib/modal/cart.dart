

import 'package:scoped_model/scoped_model.dart';

class Cart extends Model{

  int _id;
  int _idVariation;

  String _name;
  int _quantity;
  double _pass;
  String _date;
  String _image;
  String _Currancy;


  Cart(this._id, this._name, this._quantity, this._pass, this._date,
      this._image,this._Currancy);

  Cart.withId(this._id, this._name, this._quantity, this._pass,
      this._date,this._image,[this._idVariation]);
  String get image => _image;

  String get date => _date;

  String get Currancy => _Currancy;

  set Currancy(String value) {
    _Currancy = value;
  }

  int get idVariation => _idVariation;

  set idVariation(int value) {
    _idVariation = value;
  }

  double get pass => _pass;

  int get quantity => _quantity;

  String get name => _name;

  int get id => _id;


  set id(int value) {
    _id = value;
  }

  set name(String value) {
    if (value.length <= 255) {
      _name = value;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = this._id;
    map["idvar"] = this._idVariation;
    map["name"] = this._name;
    map["quantity"] = this.quantity;
    map["prise"] = this._pass;
    map["date"] = this._date;
    map["image"] = this._image;
    map["currancy"] = this._Currancy;

    return map;
  }

  Cart.getMap(Map<String, dynamic> map){
    this._id = map["id"];
    this._idVariation = map["idvar"];
    this._name = map["name"];
    this._quantity = map["quantity"];
    this._pass = map["prise"];
    this._date = map["date"];
    this._image = map["image"];
    this._Currancy = map["currancy"];

  }

  set quantity(int value) {
    _quantity = value;
  }

  set pass(double value) {
    _pass = value;
  }

  set date(String value) {
    _date = value;
  }

  set image(String value) {
    _image = value;
  }

}