import 'package:esaa/constants.dart';
import 'package:flutter/material.dart';

class mySquare extends StatelessWidget {
  final String child;
  mySquare({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(29.5),
          color: kPrimaryColor,
        ),
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //),
                  Text(
                    child,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, color: kPrimaryColor),
                    //textAlign: Center,
                  ),
                ],
              ),
            ),
            /*Image.asset('assets/bookstore.png',
                height: 50, width: 50, fit: BoxFit.cover),
            //),
            Text(
              child,
              style: TextStyle(fontSize: 30),
            ),*/
          ],
        ),
      ),
    );
  }
}
