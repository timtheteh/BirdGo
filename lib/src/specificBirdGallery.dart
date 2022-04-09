import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'gridSpecificBirdGallery.dart';

void main() => runApp(SpecificBirdGallery());

class SpecificBirdGallery extends StatelessWidget {
  const SpecificBirdGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                                  image: AssetImage('assets/bird4.jpeg'),
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
                            Text('Pied Kingfisher',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF345071),
                                    fontWeight: FontWeight.bold)),
                            Text(
                              'Ceryle rudis',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF75E6E7),
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.star),
                                Icon(Icons.star),
                                Text('spotted 1h ago',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey))
                              ],
                            ),
                            Text('Abundance: Rare'),
                            Text('Status: Vistor'),
                            Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                    child: Text('82%',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xFF75E6E7),
                                            fontWeight: FontWeight.bold))),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('chance of appearing',
                                          style: TextStyle(
                                              color: Color(0xFF3E9DAD))),
                                      Text('in this location',
                                          style: TextStyle(
                                              color: Color(0xFF3E9DAD)))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            RichText(text: 
                              TextSpan(
                                children: [
                                  TextSpan(
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      decoration: TextDecoration.underline,
                                    ),
                                    text: 'More Info',
                                    recognizer: TapGestureRecognizer()..onTap =  () async{
                                      const url = 'https://en.wikipedia.org/wiki/Pied_kingfisher';
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    }
                                  )
                                ]
                              ),
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
                            style: TextStyle(fontSize: 10, color: Colors.grey)))
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
                child: Grid2()
              ),
            ),
          ],
        ));
  }
}
