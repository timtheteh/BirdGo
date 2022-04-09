import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'gridAllBirds.dart';

void main() => runApp(AllBirds());

class AllBirds extends StatelessWidget {
  const AllBirds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      'All birds in NTU',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))),
              ],
            ),
            Grid()
          ],
        ));
  }
}
