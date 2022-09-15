import 'package:esaa/Screens/offers%20list/OfferDetails.dart';
import 'package:esaa/components/OfferCard.dart';
import 'package:esaa/components/appbar.dart';
import 'package:esaa/components/background.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaa/Screens/CompanyPage/square.dart';

import '../../constants.dart';

class ListOffers extends StatefulWidget {
  const ListOffers({super.key});

  @override
  State<ListOffers> createState() => _ListOffersState();
}

class _ListOffersState extends State<ListOffers> {
  final _fireStore = FirebaseFirestore.instance;
  List<Object> _jobList = [];
  final _auth = FirebaseAuth.instance;
  var CompanyName = 'company';

  @override
  Widget build(BuildContext context) {
    return appbar(
      child: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            width: 20,
            height: 30,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _fireStore.collection('posts').snapshots(),
            builder: (context, snapshot) {
              List<Widget> titleWidget = [];
              if (!snapshot.hasData) {
                // add here a spinner
              }

              if (snapshot.data != null) {
                final posts = snapshot.data?.docs;

                for (var post in posts!) {
                  final offertitle = post.get('Title');
                  final offerCity = post.get('City');
                  final offerDate = post.get('Date');
                  final offerDes = post.get('Description');
                  final offerFee = post.get('PayPerHour');
                  final offerTime = post.get('Time');
                  final offerHours = post.get('nHours');
                  final companyPath = post.get('user');
                  var lastSlash = companyPath.lastIndexOf('/');
                  String user = (lastSlash != -1)
                      ? companyPath.substring(lastSlash)
                      : companyPath;

                  final fm = setCompanyName(companyPath, user);
                  Convertstring(fm);
                  final OfferWidget = CardO(
                    CompanyPath: companyPath,
                    CompanyName: CompanyName,
                    offertitle: offertitle,
                    offerCity: offerCity,
                    offerDate: offerDate,
                    offerDes: offerDes,
                    offerFee: offerFee,
                    offerHours: offerHours,
                    offerTime: offerTime,
                  );

                  titleWidget.add(OfferWidget);
                }
              } else {
                return mySquare(
                  child: 'No available offers at this time!',
                );
              }
              return Column(
                children: titleWidget,
              );
            },
          ),
        ],
      )),
    );
  }

  //Future GetOffersList() async {
  //final posts = await _fireStore.collection('posts').get();
  //for (var offer in posts.docs) {
  //  print(offer.data());
  // }
  //}
  Future<String> setCompanyName(String path, String user) async {
    final companyName = await FirebaseFirestore.instance
        .collection('company')
        .doc(user)
        .get()
        .then((val) {
      return val.data()?["Name"];
    });
    return companyName;
  }

  void Convertstring(Future<String> cm) async {
    CompanyName = await cm;
  }
}
