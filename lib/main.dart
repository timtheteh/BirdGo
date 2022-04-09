import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:googlemapstry/widget_copy/textfield_general_widget.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'src/locations.dart' as locations;
import 'mappage.dart';
import 'search.dart';
// import 'src/specificBirdGallery.dart';
// import 'src/topThreeBirds.dart';
// import 'src/allBirds.dart';
import 'list of bird.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'globals.dart' as globals;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

Future<void> main() async {
  globals.slide_spec_bird;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late BitmapDescriptor pinLocationIcon;

  // final int num_species = 401;
  // final items = List<String>.generate(10000, (i) => "Item $i");

  @override
  void initState() {
    super.initState();
    setCustomMapPin();
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/marker.png');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          //fit: StackFit.expand,
          children: [
            MapPage(streamController.stream),
            // @Bryan
          ],
        ),
        // @Bryan
        /*drawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 155.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    // color: Colors.blue.shade100,
                    image: DecorationImage(fit:BoxFit.fitWidth, image: AssetImage('assets/canva-photo-editor.png')),
                  ),
                  padding: const EdgeInsets.fromLTRB(16.0,30.0,16.0,5.0),
                  child: Flexible(
                    child: new Text(
                      "ALL BIRDS IN SINGAPORE (${num_species})",
                      softWrap: true,
                      textAlign: TextAlign.left,
                      style: new TextStyle(fontSize: 30, color: Colors.white),
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ),
                ),
              Expanded(child: BirdList()),
            ],
          ),
        ),*/
      ),
    );
  }
}
