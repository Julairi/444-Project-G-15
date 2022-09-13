import 'package:esaa/constants.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      title: Text('اسع'),
      leading: IconButton(
        onPressed: () {
          //do something
        },
        icon: Icon(Icons.menu),
      ),
      actions: [
        ImageIcon(
          AssetImage("assets/logoo.png"),
          color: Color.fromARGB(255, 255, 255, 255),
          size: 24,
        ),
      ],
    );
  }
}


