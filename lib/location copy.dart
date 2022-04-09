import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';

class GeoListenPage extends StatefulWidget {
  @override
  _GeoListenPageState createState() => _GeoListenPageState();
}

class _GeoListenPageState extends State<GeoListenPage> {

  Geolocator geolocator = Geolocator();

  Position? userLocation;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getLocation().then((position) {
      userLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       backgroundColor: Color(0xfffeaa9c),
       title: Text("Upload Location",
       style: TextStyle(color: Colors.white)),
       iconTheme: IconThemeData(
       color: Colors.white, //change your color here
     )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            userLocation == null
                ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffFEAA9C)))
                : Text("Your Location:\n Latitude: " +
                userLocation!.latitude.toString() +
                "\n Longitude: " +
                userLocation!.longitude.toString(),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: RaisedButton(
                onPressed: () {
                  _getLocation().then((value) {
                    setState(() {
                      userLocation = value;
                    });
                  });
                },
                color: Color(0xffFEAA9C),
                child: Text(
                  "Get Location",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: RaisedButton(
                onPressed:(){
                  Navigator.pop(context);
    },
                color: Color(0xffFEAA9C),
                child: Text(
                  "Done",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Position> _getLocation() async {
    var currentLocation;
    try {
       currentLocation = await Geolocator.getCurrentPosition();
    // Position position*/ currentLocation = await Geolocator.getCurrentPosition();
     // debugPrint('location: ${currentLocation.latitude}');
     /* final coordinates = new Coordinates(
      currentLocation.latitude, currentLocation.longitude);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(
          coordinates);
      var first = addresses.first;
      print("${first.featureName} : ${first.addressLine}");*/
      // desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

}
