import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:esaa/Screens/offers%20list/OfferList.dart';
import 'package:esaa/constants.dart';
import 'package:esaa/post_job/post_job_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Screens/tapBar/tapbarpage.dart';

class navbarjjs extends StatefulWidget {
  const navbarjjs({Key? key}) : super(key: key);

  @override
  State<navbarjjs> createState() => _navbarjjsState();
}

class _navbarjjsState extends State<navbarjjs> {
  int index = 1;
  final items = const [
    Icon(
      Icons.document_scanner,
      color: Colors.white,
    ),
    Icon(
      Icons.work_outline_outlined,
      color: Colors.white,
    ),
    Icon(
      Icons.home,
      color: Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kFillColor,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: kFillColor,
        color: kPrimaryColor,
        animationDuration: Duration(milliseconds: 400),
        index: index,
        items: items,
        onTap: (selectedIndex) {
          setState(() {
            index = selectedIndex;
          });
        },
      ),
      body: new Stack(
        children: [
          new Transform.rotate(
            origin: Offset(40, -150),
            angle: 2.4,
            child: Container(
              margin: EdgeInsets.only(
                left: 75,
                top: 40,
              ),
              height: 400,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    colors: [kPrimaryColor, kTextcolor]),
              ),
            ),
          ),
          Container(child: getselectedWidget(index: index)),
        ],
      ),
    );
  }

  Widget getselectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = const ListOffers(); //post a new
        break;
      case 1:
        widget = const TabBarPage(); //post a new
        break;
      default:
        widget = const ListOffers(); //jumanas page
        break;
    }
    return widget;
  }
}
