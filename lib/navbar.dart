import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:esaa/Screens/offers%20list/OfferList.dart';
import 'package:esaa/constants.dart';
import 'package:esaa/post_job/post_job_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Screens/CompanyPage/company_offers.dart';
import 'Screens/OfferStatus/InterstedJSCard.dart';

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
    Icon(
      Icons.document_scanner_rounded,
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
        animationDuration: Duration(milliseconds: 40),
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
    switch (index) {
      case 0:
        widget = const postJob(); //post a new
        break;
      case 1:
        widget = const ListOffers(); //post a new
        break;
      case 2:
        widget = IntrestedJSCard(); //post a new
        break;
      case 3:
        widget = certianOffers(); //post a new
        break;
      default:
        widget = const ListOffers(); //jumanas page
        break;
    }
    return widget;
  }
}
