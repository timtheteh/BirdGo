import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    required this.text,
    required this.onClicked,
     Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => RaisedButton(
        shape: StadiumBorder(),
        color: Color(0xfffeaa9c),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textColor: Colors.white,
        onPressed: onClicked,
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );
}
