import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shoppingapp/modal/Address_shiping.dart';


import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/pages/Edit_adress_page.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';
import 'package:shoppingapp/utils/util/sql_address.dart';

class MapSample extends StatefulWidget {
Address_shiping address_shiping;

MapSample({this.address_shiping});

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
      BitmapDescriptor.fromAssetImage(configuration, 'assets/images/.png')
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
      backgroundColor: Provider.of<ThemeNotifier>(context).getColor(),
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
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:15.0),
            child: GoogleMap(
              myLocationEnabled: true,

              onTap: (pos) {
                print(pos);
                m = Marker(markerId: MarkerId('1'), icon: customIcon, position: pos);
                setState(() {
                  _markers.add(m);
                  getUserLocationAddress(pos);
//                  PlacesService().getPlaces(pos.latitude, pos.longitude).then((value) => {
//                  setState(() {
//                  places=value;
//                  })
//                  });
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
          ),
          Positioned(
              right: 5,
              top: 80,
              child: button(getUserLocation, Icons.location_searching)),

        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: DialogButton(
          width: ScreenUtil.getWidth(context)/1.3,
          onPressed: () async {
            _save();
           // Constatnt.address=address_shiping;
          },
          child: Text(getTransrlate(context, 'SaveNaw'),style: TextStyle(color: Colors.white,fontSize: 16)),
         color:  Provider.of<ThemeNotifier>(context).getColor(),
        ),
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
        address_shiping=new Address_shiping(
            first.countryName,first.adminArea,'',
            first.featureName, '', first.addressLine,lang:latLng.longitude,
            lat: latLng.latitude,id: widget.address_shiping==null?null:widget.address_shiping.id);

      return first;

    } catch (e) {
      print(e);
    }

  }
  getUserLocation() async {
    print('fooooo');
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
  getUserinformation() async {
    //call this async method from whereever you need
    String error;
    Location location = new Location();


    LatLng latLng=new LatLng(widget.address_shiping.lat, widget.address_shiping.lang);
    setState(() {
      _markers.add(Marker(markerId: MarkerId('1'), icon: customIcon, position:latLng ));
    });
    _goToPosition1(widget.address_shiping.lat, widget.address_shiping.lang);
    getUserLocationAddress(latLng);
  }

  @override
  void initState() {
    widget.address_shiping==null?getUserLocation():getUserinformation();
    _buildingController = TextEditingController();
    _streeetController = TextEditingController();
  }
  Future<void> _save()  async {
   // Nav.routeReplacement(context, EditAddressPage(address_shiping));
    _navigateAndDisplaySelection(context);
  }
  _navigateAndDisplaySelection(BuildContext context) async {

    address_shiping= await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditAddressPage(address_shiping))
    );
    Navigator.pop(context);


  }

}