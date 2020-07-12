
class Address_shiping {

  int id;
  String _title;
  String _Country;
  String _city;
  double lat;
  double lang;
  String _street;
  String _buildingNo;
  String _addres1;


  Address_shiping(this._Country, this._city,
      this._title, this._street, this._buildingNo, this._addres1,
  {this.lat, this.lang,this.id});



  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = this.id;
    map["title"] = this._title;
    map["country"] = this._Country;
    map["city"] = this._city;
    map["street"] = this._street;
    map["bilidingNo"] = this._buildingNo;
    map["addres1"] = this._addres1;
    map["lat"] = this.lat;
    map["lang"] = this.lang;
    return map;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  Address_shiping.getMap(Map<String, dynamic> map){
    this.id = map["id"];
    this._title = map["title"];
    this._Country = map["country"];
    this._city = map["city"];
    this._street = map["street"];
    this._buildingNo = map["bilidingNo"];
    this._addres1 = map["addres1"];
    this.lat = map["lat"];
    this.lang = map["lang"];
  }

  String get addres1 => _addres1;

  set addres1(String value) {
    _addres1 = value;
  }

  String get buildingNo => _buildingNo;

  set buildingNo(String value) {
    _buildingNo = value;
  }

  String get street => _street;

  set street(String value) {
    _street = value;
  }



  String get city => _city;

  set city(String value) {
    _city = value;
  }

  String get Country => _Country;

  set Country(String value) {
    _Country = value;
  }




}