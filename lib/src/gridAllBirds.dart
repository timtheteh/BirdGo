import 'package:flutter/material.dart';
import 'package:birdgo/mappage.dart';

void main() => runApp(Grid());

class Grid extends StatelessWidget {
  const Grid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: <Widget>[
          Container(
            // padding: const EdgeInsets.all(8),
            // color: Colors.teal[100],
            child: InkWell(
              onTap: () {
                
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: AssetImage('assets/bird1.jpeg'),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                    image: AssetImage('assets/bird2.jpeg'), fit: BoxFit.cover)),
          ),
          Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                    image: AssetImage('assets/bird3.jpeg'), fit: BoxFit.cover)),
          ),
          Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                    image: AssetImage('assets/bird4.jpeg'), fit: BoxFit.cover)),
          ),
          Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                    image: AssetImage('assets/bird5.jpeg'), fit: BoxFit.cover)),
          ),
          Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                    image: AssetImage('assets/bird6.jpeg'), fit: BoxFit.cover)),
          ),
          Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                    image: AssetImage('assets/bird7.jpeg'), fit: BoxFit.cover)),
          ),
          Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                    image: AssetImage('assets/bird8.jpeg'), fit: BoxFit.cover)),
          ),
          Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                    image: AssetImage('assets/bird9.jpeg'), fit: BoxFit.cover)),
          ),
          Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                    image: AssetImage('assets/bird9.jpeg'), fit: BoxFit.cover)),
          ),
          Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                    image: AssetImage('assets/bird9.jpeg'), fit: BoxFit.cover)),
          ),
          Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                    image: AssetImage('assets/bird9.jpeg'), fit: BoxFit.cover)),
          ),
        ],
      ),
    );
  }
}
