import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shoppingapp/modal/Address_shiping.dart';


import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';
import 'package:shoppingapp/utils/util/sql_address.dart';

class MapSample extends StatefulWidget {

  MapSample();

  @override
  MapSampleState createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  SQL_Address helper = new SQL_Address();
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;
  static const kGoogleApiKey = "AIzaSyBb0GpBvrtNExsQHDb55DcVVnmUgL85w4U";
  BitmapDescriptor customIcon;
  LocationData myLocation;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  Marker m;
  TextEditingController _buildingController,_streeetController;
  Address_shiping address_shiping;
  Future<void> _goToPosition1(double latitude, double longitude) async {
    final GoogleMapController controller = await _controller.future;
    final CameraPosition _position1 = CameraPosition(
      bearing: 192.833,
      target: LatLng(latitude, longitude),
      tilt: 59.440,
      zoom: 15.0,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  createMarker(context) {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/fd.png')
          .then((icon) {
        setState(() {
          customIcon = icon;
        });
      });
    }
  }



  _onAddMarkerButtonPressed(String) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
          infoWindow: InfoWindow(
            title: 'This is a Title',
            snippet: 'This is a snippet',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });
  }

  Widget button(Function function, IconData icon) {
    return FloatingActionButton(
      heroTag: 'location',
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Provider.of<ThemeNotifier>(context).color,
      child: Icon(
        icon,
        size: 36.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      appBar: AppBar(
        title: Center(child: Text(getTransrlate(context, 'LocationSelected'))),
        backgroundColor: Provider.of<ThemeNotifier>(context).color,
        actions: <Widget>[

        ],
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onTap: (pos) {
              print(pos);
              m = Marker(markerId: MarkerId('1'), icon: customIcon, position: pos);
              setState(() {
                _markers.add(m);
                getUserLocationAddress(pos);
              });
            },
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15.0,
            ),
            mapType: _currentMapType,
            markers: _markers,
            onCameraMove: _onCameraMove,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: button(getUserLocation, Icons.location_searching),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
         // Constatnt.address=address_shiping;
        },
        tooltip: '  حفظ  ',
        label:  Text(getTransrlate(context, 'SaveNaw')),
        icon: Icon(Icons.save),
        backgroundColor: Provider.of<ThemeNotifier>(context).color,
      ),
    );
  }

  getUserLocationAddress(LatLng latLng) async {
    //call this async method from whereever you need
    try {
      final coordinates = new Coordinates(
          latLng.latitude, latLng.longitude);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(
          coordinates);
      var first = addresses.first;
      print(' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first
          .subAdminArea},${first.addressLine}, ${first.featureName},${first
          .thoroughfare}, ${first.subThoroughfare}');
      setState(() {
        address_shiping=new Address_shiping(
            first.countryName,first.countryName, first.adminArea,
            first.featureName, '', first.addressLine,lang:latLng.longitude,
            lat: latLng.latitude);
      });
      return first;

    } catch (e) {
      print(e);
    }

  }

  getUserLocation() async {
    //call this async method from whereever you need
    String error;
    Location location = new Location();
    try {
      myLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'please grant permission';
        print(error);
      }
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'permission denied- please enable it from app settings';
        print(error);
      }
      myLocation = null;
    }

    LatLng latLng=new LatLng(myLocation.latitude, myLocation.longitude);
    setState(() {
      _markers.add(Marker(markerId: MarkerId('1'), icon: customIcon, position:latLng ));
    });
    _goToPosition1(myLocation.latitude, myLocation.longitude);
    getUserLocationAddress(latLng);
  }

  @override
  void initState() {
    getUserLocation();
    _buildingController = TextEditingController();
    _streeetController = TextEditingController();
  }


  Future<void> _save()  async {
    address_shiping=new Address_shiping(address_shiping.Country,address_shiping.Country,address_shiping.city,address_shiping.street, _buildingController.text,address_shiping.addres1,
    lat: address_shiping.lat,lang: address_shiping.lang);

    int result;
    result =  await helper.insertStudent(address_shiping);


    if (result == 0) {
      //showAlertDialog(getTransrlate(context, 'sorry'), getTransrlate(context, 'notSavedAddress'));
    } else {
      //showAlertDialog(getTransrlate(context, 'Alert'), getTransrlate(context, 'SavedAddress'));
    }
  }

}