import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:esaa/Screens/offers%20list/OfferList.dart';
import 'package:esaa/constants.dart';
import 'package:esaa/post_job/post_job_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class navbarjs extends StatefulWidget {
  const navbarjs({Key? key}) : super(key: key);

  @override
  State<navbarjs> createState() => _navbarjsState();
}

class _navbarjsState extends State<navbarjs> {
  int index = 1;
  final items = const [
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
      body: Container(child: getselectedWidget(index: index)),
    );
  }

  Widget getselectedWidget({required int index}) {
    Widget widget;
    //
    switch (index) {
      default:
        widget = const ListOffers(); //jumanas page
        break;
    }
    return widget;
  }
}
