import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaa/Screens/CompanyPage/userCompanyOffers.dart';
import 'package:esaa/constants.dart';
import 'package:flutter/material.dart';

class detailsPage extends StatelessWidget {
  final String CompanyName;
  final String CompanyPath;
  final String offertitle;
  final String offerCity;
  final String offerDate;
  final String offerDes;
  final String offerFee;
  final String offerTime;
  final String offerHours;
  const detailsPage(
      {required this.CompanyPath,
      required this.CompanyName,
      required this.offertitle,
      required this.offerCity,
      required this.offerDate,
      required this.offerDes,
      required this.offerFee,
      required this.offerTime,
      required this.offerHours});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Text('اسع'),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (
                    context,
                  ) =>
                      userOffers(
                    child: CompanyPath,
                  ),
                ));
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
      ),
      body: Container(
        color: kPrimaryColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            children: [
              Text(
                offertitle,
                style: TextStyle(color: kPrimaryLightColor, fontSize: 40),
              ),
              Text(
                offerCity,
                style: TextStyle(color: kPrimaryLightColor, fontSize: 35),
              ),
              Text(
                offerDate,
                style: TextStyle(color: kPrimaryLightColor, fontSize: 30),
              ),
              Text(
                offerTime,
                style: TextStyle(
                    color: kPrimaryLightColor, fontSize: defaultFontSize),
              ),
              Text(
                offerDes,
                style: TextStyle(
                    color: kPrimaryLightColor, fontSize: defaultFontSize),
              ),
              Text(
                offerHours + ' ساعات',
                style: TextStyle(color: kPrimaryLightColor, fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
