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
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.share),
        )
      ],
    );
  }
}
