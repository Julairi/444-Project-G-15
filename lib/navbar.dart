import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:esaa/Screens/CompanyPage/company_offers.dart';
import 'package:esaa/Screens/offers%20list/OfferList.dart';
import 'package:esaa/constants.dart';
import 'package:esaa/post_job/post_job_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:esaa/Screens/CompanyPage/company_offers.dart';

class navbar extends StatefulWidget {
  const navbar({Key? key}) : super(key: key);

  @override
  State<navbar> createState() => _navbarState();
}

class _navbarState extends State<navbar> {
  int index = 1;
  final items = const [
    Icon(
      Icons.add_rounded,
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
        widget = const postJob(); //post a new
        break;
      default:
        widget = certianOffers(); //jumanas page
        break;
    }
    return widget;
  }
}
