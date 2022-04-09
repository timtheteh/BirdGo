import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:birdgo/predictionpage.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'src/allBirds.dart';
import 'list of bird.dart';
import 'search.dart';
import 'src/locations.dart' as locations;

//import 'src/specificBirdGallery.dart';
import 'src/topThreeBirds.dart';
import 'package:birdgo/widget_copy/textfield_general_widget.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

import 'globals.dart' as globals;

StreamController<int> streamController = StreamController<int>.broadcast();
//StreamController<int> streamController2 = StreamController<int>.broadcast();

class MapPage extends StatefulWidget {
  const MapPage(this.stream);

  final Stream<int> stream;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late BitmapDescriptor pinLocationIcon;
  late BitmapDescriptor blueLocationIcon;

  // @Bryan
  final int num_species = 401;

  bool allBirdsWidgetIsVisible = false;
  bool topThreeBirdsWidgetIsVisible = true;
  bool specificBirdGalleryWidgetIsVisible = false;

  void mySetState(int index) {
    List booleanList = [true, false];
    setState(() {
      specificBirdGalleryWidgetIsVisible = booleanList[index];
      topThreeBirdsWidgetIsVisible = booleanList[index + 1];
      allBirdsWidgetIsVisible = booleanList[index + 1];
    });
  }

  // @Bryan
  void callbackFunction() {
    setState(() {
      allBirdsWidgetIsVisible = false;
      topThreeBirdsWidgetIsVisible = false;
      specificBirdGalleryWidgetIsVisible = true;
    });
  }

  @override
  void initState() {
    super.initState();
    setCustomMapPin();
    setBlueMapPin();
    widget.stream.listen((index) {
      mySetState(index);
    });
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/marker.png');
  }

  void setBlueMapPin() async {
    blueLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/redflag.png');
  }

  void uploadCallback(double lat, double lng, String name, String desc) {
    setState(() {
      _markers[name] = Marker(
        markerId: MarkerId(name),
        position: LatLng(lat, lng),
        icon: pinLocationIcon,
        infoWindow: InfoWindow(title: name, snippet: desc),
      );
    });
  }

  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection('Birds').get();

    QuerySnapshot snap2 =
        await FirebaseFirestore.instance.collection('locations').get();

    QuerySnapshot snap3 =
        await FirebaseFirestore.instance.collection('AllBirdInfo').get();

    setState(() {
      _markers.clear();

      //uploads
      for (var i = 0; i < snap.size; i++) {
        var map = (snap.docs[i].data() as LinkedHashMap)!
            .map((a, b) => MapEntry(a as String, b.toString() as String));
        final marker = Marker(
          markerId: MarkerId(map.putIfAbsent('name', () => 'Err')),
          position: LatLng(double.parse(map.putIfAbsent('lat', () => '0')),
              double.parse(map.putIfAbsent('lng', () => '0'))),
          icon: pinLocationIcon,
          onTap: () {
            snap3.docs.forEach((doc) {
              // globals.slide_spec_bird = doc;
              if (doc["name"] == map['name']) {
                globals.slide_spec_bird = doc;
              }
            });

            setState(() {
              allBirdsWidgetIsVisible = false;
              specificBirdGalleryWidgetIsVisible = true;
              topThreeBirdsWidgetIsVisible = false;
            });
          },
          infoWindow: InfoWindow(
            title: map.putIfAbsent('name', () => 'Err'),
            snippet: map.putIfAbsent('description', () => 'Nil'),
          ),
        );
        _markers[map.putIfAbsent('name', () => 'Err')] = marker;
      }

      //ebirds
      for (var i = 0; i < snap2.size; i++) {
        var map2 = (snap2.docs[i].data() as LinkedHashMap)!
            .map((a, b) => MapEntry(a as String, b.toString() as String));
        final marker = Marker(
          markerId: MarkerId(map2.putIfAbsent('name', () => 'Err')),
          position: LatLng(double.parse(map2.putIfAbsent('lat', () => '0')),
              double.parse(map2.putIfAbsent('lng', () => '0'))),
          icon: blueLocationIcon,
          onTap: () {
            snap2.docs.forEach((doc) {
              // globals.slide_spec_bird = doc;
              if (doc["name"] == map2['name']) {
                globals.slide_flag_bird = doc;
              }
            });

            setState(() {
              allBirdsWidgetIsVisible = true;
              specificBirdGalleryWidgetIsVisible = false;
              topThreeBirdsWidgetIsVisible = false;
            });
          },
          infoWindow: InfoWindow(
            title: map2.putIfAbsent('address', () => 'Err'),
            snippet: map2.putIfAbsent('name', () => 'Err'),
          ),
        );
        _markers[map2.putIfAbsent('address', () => 'Err')] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Container(
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(1.3483, 103.6831),
              zoom: 16,
            ),
            markers: _markers.values.toSet(),
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
          ),
        ),
        Positioned(
          left: 10,
          bottom: 237,
          child: Builder(
            builder: (context) => FloatingActionButton(
                heroTag: "btn1",
                backgroundColor: Color(0xffFEAA9c),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TextfieldGeneralWidget(uploadCallback)));
                },
                child: const Icon(Icons.file_upload_outlined)),
          ),
        ),
        Positioned(
          right: 10,
          bottom: 237,
          child: Builder(
            builder: (context) => FloatingActionButton(
                heroTag: "btn2",
                backgroundColor: Color(0xffFEAA9c),
                onPressed: () {
                  // change to map page
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PredPage(streamController.stream)));
                },
                child: const Icon(Icons.lightbulb_outline_rounded)),
          ),
        ),
        Visibility(
            visible: specificBirdGalleryWidgetIsVisible,
            child: SpecificBirdGallery()),
        Visibility(visible: allBirdsWidgetIsVisible, child: AllBirds()),
        Visibility(
            visible: topThreeBirdsWidgetIsVisible, child: TopThreeBirds()),
        SearchPage(callbackFunction),
      ]),
      drawer: Drawer(
        child: Stack(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 155.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  // color: Colors.blue.shade100,
                  image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: AssetImage('assets/canva-photo-editor.png')),
                ),
                padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 5.0),
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
      ),
    );
  }
}

class PredPage extends StatefulWidget {
  // const PredPage({Key? key}) : super(key: key);
  const PredPage(this.stream);

  final Stream<int> stream;

  @override
  _PredPageState createState() => _PredPageState();
}

class _PredPageState extends State<PredPage> {
  late BitmapDescriptor pinLocationIcon;

  bool allBirdsWidgetIsVisible = false;
  bool topThreeBirdsWidgetIsVisible = true;
  bool specificBirdGalleryWidgetIsVisible = false;

  void mySetState(int index) {
    List booleanList = [true, false];
    setState(() {
      specificBirdGalleryWidgetIsVisible = booleanList[index];
      topThreeBirdsWidgetIsVisible = booleanList[index + 1];
      allBirdsWidgetIsVisible = booleanList[index + 1];
    });
  }

  // @Bryan
  void callbackFunction() {
    setState(() {
      allBirdsWidgetIsVisible = false;
      topThreeBirdsWidgetIsVisible = false;
      specificBirdGalleryWidgetIsVisible = true;
    });
  }

  void uploadCallback(double lat, double lng, String name, String desc) {
    setState(() {
      _markers[name] = Marker(
        markerId: MarkerId(name),
        position: LatLng(lat, lng),
        icon: pinLocationIcon,
        infoWindow: InfoWindow(title: name, snippet: desc),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    setCustomMapPin();
    widget.stream.listen((index) {
      mySetState(index);
    });
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/marker.png');
  }

  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection('predMax3').get();
    QuerySnapshot allBirdInfoSnap =
        await FirebaseFirestore.instance.collection('AllBirdInfo').get();

    setState(() {
      _markers.clear();
      for (var i = 0; i < snap.size; i++) {
        var map = (snap.docs[i].data() as LinkedHashMap)!
            .map((a, b) => MapEntry(a as String, b.toString() as String));
        final marker = Marker(
          markerId: MarkerId(map.putIfAbsent('name', () => 'Err')),
          position: LatLng(double.parse(map.putIfAbsent('lat', () => '0')),
              double.parse(map.putIfAbsent('lng', () => '0'))),
          icon: pinLocationIcon,
          onTap: () {
            allBirdInfoSnap.docs.forEach((doc) {
              // globals.slide_spec_bird = doc;
              if (doc["name"] == map['name']) {
                globals.slide_spec_bird = doc;
              }
            });

            setState(() {
              allBirdsWidgetIsVisible = false;
              specificBirdGalleryWidgetIsVisible = true;
              topThreeBirdsWidgetIsVisible = false;
            });
          },
          infoWindow: InfoWindow(
            title: map.putIfAbsent('name', () => 'Err'),
            snippet: map.putIfAbsent('quadPred', () => 'Err'),
          ),
        );
        _markers[map.putIfAbsent('name', () => 'Err')] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          // @Bryan : removed duplicate SearchPage
          Container(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: LatLng(1.3483, 103.6831),
                zoom: 16,
              ),
              markers: _markers.values.toSet(),
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
            ),
          ),
          Positioned(
            left: 10,
            bottom: 237,
            child: Builder(
              builder: (context) => FloatingActionButton(
                  heroTag: "btn3",
                  backgroundColor: Color(0xffFEAA9c),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TextfieldGeneralWidget(uploadCallback)));
                  },
                  child: const Icon(Icons.file_upload_outlined)),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 237,
            child: Builder(
              builder: (context) => FloatingActionButton(
                  heroTag: "btn4",
                  backgroundColor: Color(0xffFEAA9c),
                  onPressed: () {
                    // change to map page
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.remove_red_eye_outlined)),
            ),
          ),
          Visibility(
              visible: specificBirdGalleryWidgetIsVisible,
              child: SpecificBirdGallery()),
          Visibility(visible: allBirdsWidgetIsVisible, child: AllBirds()),
          Visibility(
              visible: topThreeBirdsWidgetIsVisible, child: TopThreeBirds()),
          SearchPage(callbackFunction),
        ]));
  }
}

// class SpecificBirdGallery extends StatefulWidget {
class SpecificBirdGallery extends StatelessWidget {
  Stream<QuerySnapshot> all_bird_species = FirebaseFirestore.instance
      .collection('AllBirdInfo')
      .orderBy('rarity', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: all_bird_species,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return Text('Error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('...Loading...');
          }

          final data = snapshot.requireData;

          return SlidingUpPanel(
              minHeight: 220,
              maxHeight: 630,
              panel: Stack(
                children: <Widget>[
                  Column(
                    children: [
                      Icon(Icons.drag_handle),
                      Row(
                        children: <Widget>[
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                margin: EdgeInsets.all(10),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image(
                                        image: NetworkImage(globals
                                            .slide_spec_bird
                                            .get('imgurl')),
                                        // image: NetworkImage(
                                        //     data.docs[birdIndex]['imgurl']),
                                        fit: BoxFit.cover))),
                          ),
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Center(
                                    child: Center(
                                      child: Text(
                                          globals.slide_spec_bird.get('name'),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Color(0xFF345071),
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  Text(
                                    globals.slide_spec_bird.get('sciname'),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF75E6E7),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      for (int i = 0;
                                          i <
                                              globals.slide_spec_bird
                                                  .get('rarity');
                                          i++)
                                        Icon(Icons.star),
                                      Text('spotted 1h ago',
                                          style: TextStyle(
                                              fontSize: 15, color: Colors.grey))
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      if (globals.slide_spec_bird
                                              .get('rarity') ==
                                          1)
                                        Text("Abundance: Common"),
                                      if (globals.slide_spec_bird
                                              .get('rarity') ==
                                          2)
                                        Text("Abundance: Uncommon"),
                                      if (globals.slide_spec_bird
                                              .get('rarity') ==
                                          3)
                                        Text("Abundance: Rare"),
                                    ],
                                  ),
                                  Text('Status: Visitor'),
                                  Row(
                                    children: [
                                      Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 10, 10, 0),
                                          child: SingleChildScrollView(
                                            child: Text(
                                                '${globals.slide_spec_bird.get('pred')}%',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xFF75E6E7),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 10, 0, 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('chance of bird',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Color(0xFF3E9DAD))),
                                            Text('appearing',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Color(0xFF3E9DAD)))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                          text: 'More Info',
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () async {
                                              var url = globals.slide_spec_bird
                                                  .get('wikiurl');
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              } else {
                                                throw 'Could not launch $url';
                                              }
                                            })
                                    ]),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    top: 220,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      margin: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Gallery',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF3E9DAD),
                                  fontWeight: FontWeight.bold)),
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              child: Text(
                                  'Photos by other users in the same location',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey)))
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 210,
                    right: 0,
                    child: SizedBox(
                        height: 500,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Container(
                          child: GridView.count(
                            primary: false,
                            padding: const EdgeInsets.all(20),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 3,
                            children: <Widget>[
                              for (int i = 0; i < 12; i++)
                                Container(
                                  // padding: const EdgeInsets.all(8),
                                  // color: Colors.teal[100],
                                  child: InkWell(
                                    onTap: () {
                                      globals.slide_spec_bird =
                                          data.docs[i + 20];
                                      streamController.add(0);
                                    },
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image(
                                          image: NetworkImage(
                                              data.docs[i + 20]['imgurl']),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                ),
                            ],
                          ),
                        )),
                  ),
                ],
              ));
        });
  }
}

class AllBirds extends StatelessWidget {
  //const AllBirds({Key? key}) : super(key: key);

  Stream<QuerySnapshot> all_bird_species = FirebaseFirestore.instance
      .collection('AllBirdInfo')
      .orderBy('rarity', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: all_bird_species,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return Text('Error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('...Loading...');
          }

          final data = snapshot.requireData;
          return SlidingUpPanel(
              minHeight: 220,
              maxHeight: 450,
              panel: Stack(
                children: <Widget>[
                  Column(
                    children: [
                      Icon(Icons.drag_handle),
                      Container(
                          margin: EdgeInsets.all(10),
                          child: Center(
                              child: Text(
                            globals.slide_flag_bird.get('address'),
                            // 'All birds in NTU',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 3,
                      children: <Widget>[
                        for (int i = 0; i < 12; i++)
                          Container(
                            // padding: const EdgeInsets.all(8),
                            // color: Colors.teal[100],
                            child: InkWell(
                              onTap: () {
                                globals.slide_spec_bird = data.docs[i];
                                streamController.add(0);
                                // streamController2.add(0);
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image(
                                    image: NetworkImage(data.docs[i]['imgurl']),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              ));
        });
  }
}

class TopThreeBirds extends StatelessWidget {
  //const TopThreeBirds({Key? key}) : super(key: key);
  static const TextStyle birdname_style =
      TextStyle(fontSize: 10, color: Colors.black);
  static const TextStyle spotted_style =
      TextStyle(fontSize: 10, color: Colors.grey);
  static const Icon star = Icon(Icons.star, size: 20);

  Stream<QuerySnapshot> all_bird_species = FirebaseFirestore.instance
      .collection('AllBirdInfo')
      .orderBy('rarity', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: all_bird_species,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return Text('Error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('...Loading...');
          }

          final data = snapshot.requireData;

          return SlidingUpPanel(
            minHeight: 220,
            maxHeight: 220,
            panel: Column(
              children: [
                Icon(Icons.drag_handle),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (int i = 0; i < 3; i++)
                      Expanded(
                          child: Column(
                        children: [
                          Container(
                            height: 130,
                            width: MediaQuery.of(context).size.width * 0.33,
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                margin: EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {
                                    globals.slide_spec_bird = data.docs[i];
                                    streamController.add(0);
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image(
                                          image: NetworkImage(
                                              data.docs[i]['imgurl']),
                                          fit: BoxFit.cover)),
                                )),
                          ),
                          Text(
                            data.docs[i]['name'],
                            style: birdname_style,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              for (int i = 0; i < data.docs[i]['rarity']; i++)
                                star,
                            ],
                          ),
                          Text('spotted 1h ago', style: spotted_style),
                        ],
                      )),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
