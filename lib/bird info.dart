import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'dart:async';
import 'package:transparent_image/transparent_image.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BirdInfo extends StatelessWidget {
  // BirdInfo(QueryDocumentSnapshot<Object?> bird);

  BirdInfo({Key? key, required this.bird}) : super(key: key);

  final QueryDocumentSnapshot bird;

  // DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('locations').doc('SCIBIRDNAME; COMMONNAME').get();

  @override
  Widget build(BuildContext) {
    Stream<QuerySnapshot> _occurrenceStream = FirebaseFirestore.instance
        .collection('locations')
        .where('name', isEqualTo: bird.get('name'))
        .snapshots();

    // DocumentSnapshot documentSnapshot =
    // FirebaseFirestore.instance.collection('locations').doc(bird.get('name')).get().then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists) {
    //     return documentSnapshot;
    //     // print('Document data: ${documentSnapshot.data()}');
    //   }
    //   // else {
    //   // print('Document does not exist on the database');
    //   // }
    // }) as DocumentSnapshot<Object?>;

    // final double img_width = 256;
    // final double img_height = 256;

    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white, // Color(0xff75E6E7),
      ),
      child: new Column(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //IMAGE
          Container(
              height: 360,
              alignment: Alignment(0.0, 0.0),
            // padding: EdgeInsets.all(1),
            child: FittedBox(
              child: FadeInImage.assetNetwork(
              alignment: Alignment(0.0, 0.0),
              placeholder: 'assets/loading.gif',
              image: bird.get('imgurl'),
              // image: 'https://cdn.download.ams.birds.cornell.edu/api/v1/asset/202984001/1800',
              fit: BoxFit.fill,
              // height: 250.0,// After image load
            ),
            fit: BoxFit.fill,)
            ),

          //COMMON NAME
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 3),
            child: RichText(
              textDirection: TextDirection.ltr,
              text: TextSpan(
                children: [
                  TextSpan(
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff35678B),
                      fontStyle: FontStyle.italic,
                      // decoration: TextDecoration.underline,
                    ),
                    text: bird.get("name"),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: RichText(
              textDirection: TextDirection.ltr,
              text: TextSpan(
                children: [
                  TextSpan(
                      style: TextStyle(
                        fontSize: 18,
                        // fontWeight: FontWeight.bold,
                        color: Color(0xff75E6E7),
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline,
                      ),
                      text: bird.get("sciname"),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          // const url = "https://en.wikipedia.org/wiki/Bird";
                          final url = bird.get("wikiurl");
                          if (await canLaunch(url))
                            await launch(url);
                          else
                            // can't launch url, there is some error
                            throw "Could not launch $url";
                        }),
                ],
              ),
            ),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _occurrenceStream,
              builder: (
                context,
                AsyncSnapshot<QuerySnapshot> snapshot,
              ) {
                if (snapshot.hasError) {
                  return Text('Error');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('...Loading...');
                }

                final bird_locations = snapshot.requireData;

                if (bird_locations.size > 0) {
                  // print('${bird_locations.size} occurrences');
                  return new Scaffold(
                      body: Column(
                    children: [
                      const SizedBox(height: 18),
                      Container(
                        alignment: Alignment.centerLeft,
                        color: Color(0xff35678B),
                        padding: const EdgeInsets.all(10),
                        child: bird_locations.size != 1
                            ? Text('   ${bird_locations.size} OCCURRENCES',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white))
                            : Text('   ${bird_locations.size} OCCURRENCE',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white /*Color(0xff75E6E7)*/)),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: bird_locations.size,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              color: Colors.transparent, // Color(0xff75E6E7),
                              child: Container(
                                child: ListTile(
                                  title: Text(
                                    "• " +
                                        bird_locations.docs[index]['address'],
                                    textAlign: TextAlign.left,
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Color(0xff35678B)),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ));
                } else {
                  return Scaffold(
                    body: Column(
                      children: [
                        const SizedBox(height: 18),
                        Container(
                          alignment: Alignment.centerLeft,
                          color: Color(0xff35678B),
                          padding: const EdgeInsets.all(10),
                          child: //ons.size} OCCURRENCES',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white))
                              Text('   ${bird_locations.size} OCCURRENCES',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color:
                                          Colors.white /*Color(0xff75E6E7)*/)),
                        ),
                      ],
                    ),
                  );
                }

                // return new Scaffold( body: ListView.builder(
                //   itemCount: bird_locations.size,
                //   itemBuilder: (context, index) {
                //     return ListTile(
                //       title: Text(
                //         bird_locations.docs[index]['address'],
                //         style: new TextStyle(fontSize: 15, color: Colors.black),
                //       ),
                //     );
                //   },
                // ),
                // );
              },
            ),
          ),

          //  SCI NAME

          // new SingleChildScrollView(
          //   child: Padding(
          //     padding: const EdgeInsets.all(12.0),
          //     child: new Text(
          //       "This is the info of this bird\n Maybe include rarity, list of ALL sightings",
          //       style: new TextStyle(fontSize: 24, color: Colors.black),
          //       textDirection: TextDirection.ltr,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
