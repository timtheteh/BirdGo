import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() => runApp(TopThreeBirds());

class TopThreeBirds extends StatelessWidget {
  //const TopThreeBirds({Key? key}) : super(key: key);
  static const TextStyle birdname_style =
      TextStyle(fontSize: 10, color: Colors.black);
  static const TextStyle spotted_style =
      TextStyle(fontSize: 10, color: Colors.grey);
  static const Icon star = Icon(Icons.star, size: 20);

  Stream<QuerySnapshot> all_bird_species =
      FirebaseFirestore.instance.collection('AllBirdInfo').orderBy('rarity', descending: true).snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: all_bird_species,
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot> snapshot,
      ){
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
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(
                                image: NetworkImage(data.docs[0]['imgurl']), fit: BoxFit.cover))),
                  ),
                  Text(
                    data.docs[0]['name'],
                    style: birdname_style,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int i = 0; i < data.docs[0]['rarity']; i++) star,
                      // star,
                      // star,
                      // star,
                      // Icon(Icons.star),
                      // Icon(Icons.star),
                      // Icon(Icons.star),
                    ],
                  ),
                  Text('spotted 1h ago', style: spotted_style),
                ],
              )),
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
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(
                                image: NetworkImage(data.docs[1]['imgurl']),
                                fit: BoxFit.cover))),
                  ),
                  Text(data.docs[1]['name'], style: birdname_style),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int i = 0; i < data.docs[1]['rarity']; i++) star, 
                      // Icon(Icons.star),
                      // Icon(Icons.star),
                      //star,
                      //star,
                    ],
                  ),
                  Text('spotted 4h ago', style: spotted_style),
                ],
              )),
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
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(
                                image: NetworkImage(data.docs[2]['imgurl']),
                                fit: BoxFit.cover))),
                  ),
                  Text(data.docs[2]['name'], style: birdname_style),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int i = 0; i < data.docs[2]['rarity']; i++) star,
                      // star,
                      // star,
                      // star,
                      // star,
                      // Icon(Icons.star),
                      // Icon(Icons.star),
                      // Icon(Icons.star),
                      // Icon(Icons.star),
                    ],
                  ),
                  Text('spotted 3h ago', style: spotted_style),
                ],
              )),
            ],
          ),
        ],
      ),
    );
      }
    );
  }
}


