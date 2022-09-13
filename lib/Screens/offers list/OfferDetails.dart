import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaa/constants.dart';
import 'package:flutter/material.dart';

class detailsPage extends StatelessWidget {
  final offertitle;
  final offerCity;
  final offerDate;
  final offerDes;
  final offerFee;
  final offerTime;
  final offerHours;
  const detailsPage(
      {required this.offertitle,
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
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [Text(offertitle)],
        ),
      ),
    );
  }
}
