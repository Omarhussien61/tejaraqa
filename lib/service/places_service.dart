import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shoppingapp/modal/place.dart';
import 'package:shoppingapp/service/api_config.dart';

class PlacesService {
  final key = APICONFIQ.kGoogleApiKey;
  Future<List<Place>> getPlaces(double lat, double lng) async {
    print ('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&type=parking&rankby=distance&key=$key');

    var response = await http.get('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&type=parking&rankby=distance&key=$key');
    print(response.body);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }

}
