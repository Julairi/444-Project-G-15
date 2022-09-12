import 'package:esaa/Screens/offers%20list/offers_list.dart';
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
        leading: IconButton(
          onPressed: () {
            //do something
          },
          icon: Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {
              postStreams();
            },
            icon: Icon(Icons.share),
          )
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
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
                final offerCompany = post.get('Company');
                final OfferWidget = Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kPrimaryColor,
                  ),
                  child: Text('$offerCompany \n  $offertitle '),
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
