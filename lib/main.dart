import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'MapMarkers.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LatLng _location = const LatLng(43.6425701, -79.3892455);

  GoogleMapController mapController;
  void _myMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void getCurrentLocation() async {
    final Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            forceAndroidLocationManager: true)
        .catchError((err) => print(err));

    final CameraPosition MyLocation = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      bearing: 45.0,
      tilt: 50.0,
      zoom: 11.0,
    );

    setState(() async {
      final GoogleMapController controller = await mapController;

      controller.animateCamera(
        CameraUpdate.newCameraPosition(MyLocation),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maps Sample App'),
        ),
        body: GoogleMap(
          //Mengatur tipe map
          //mapType: MapType.hybrid,

          //cnTowerkarker
          markers: {cnTowerkarker},

          onMapCreated: _myMapCreated,
          initialCameraPosition: CameraPosition(target: _location, zoom: 13.0),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: getCurrentLocation,
          label: Text('To My Location'),
          icon: Icon(Icons.directions_boat),
        ),
      ),
    );
  }
}
