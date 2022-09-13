import 'package:esaa/Screens/offers%20list/OfferDetails.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Text('اسع'),
        actions: [
          ImageIcon(
            AssetImage("assets/logoo.png"),
            color: Color.fromARGB(255, 255, 255, 255),
            size: 24,
          ),
        ],
      ),
      body: SafeArea(
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
              final posts = snapshot.data!.docs;

              for (var post in posts) {
                final offertitle = post.get('Title');
                final offerCity = post.get('City');
                final offerDate = post.get('Date');
                final offerDes = post.get('Description');
                final offerFee = post.get('PayPerHour');
                final offerTime = post.get('Time');
                final offerHours = post.get('nHours');
                final companyPath = post.get('user');
                var lastSlash = companyPath.lastIndexOf('/');
                final String companyName = (lastSlash != -1)
                    ? companyPath.substring(lastSlash)
                    : companyPath;

                final OfferWidget = Container(
                  margin: EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 62, 75, 100),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: kPrimaryColor,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (
                                  context,
                                ) =>
                                    detailsPage(
                                        CompanyPath: companyPath,
                                        CompanyName: companyName,
                                        offertitle: offertitle,
                                        offerCity: offerCity,
                                        offerDate: offerDate,
                                        offerDes: offerDes,
                                        offerFee: offerFee,
                                        offerTime: offerTime,
                                        offerHours: offerHours),
                              ));
                        },
                        icon: Icon(Icons.more_horiz_rounded),
                        color: Colors.white,
                        iconSize: 40,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.work),
                                    ),
                                    Text(
                                      'Company:$companyName',
                                      style: TextStyle(
                                          color: kPrimaryLightColor,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(
                                  ' JobTitle: $offertitle',
                                  style: TextStyle(
                                      color: kPrimaryLightColor,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  ' City:$offerCity',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 245, 250, 252),
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
                titleWidget.add(OfferWidget);
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
  void postStreams() async {
    await for (var snapshot in _fireStore.collection('posts').snapshots()) {
      for (var posts in snapshot.docs) {
        print(posts.data());
      }
    }
  }
}
