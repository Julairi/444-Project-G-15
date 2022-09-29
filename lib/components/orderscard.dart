import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaa/Screens/offers%20list/OfferDetails.dart';
import 'package:esaa/components/orders2.dart';
import 'package:esaa/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Screens/CompanyPage/square.dart';

class cardOrder extends StatefulWidget {
  final String UId;
  final String CompanyName;
  final String offertitle;

  const cardOrder({
    super.key,
    required this.CompanyName,
    required this.offertitle,
    required this.UId,
  });

  @override
  State<cardOrder> createState() =>
      _cardOrderState(CompanyName, offertitle, UId);
}

class _cardOrderState extends State<cardOrder> {
  @override
  final String UId;
  final String CompanyName;
  final String offertitle;

  _cardOrderState(this.CompanyName, this.offertitle, this.UId);

  final _fireStore = FirebaseFirestore.instance;
  List<Object> _jobList = [];
  final _auth = FirebaseAuth.instance;

  String? retrieveList() {
    final User? user = FirebaseAuth.instance.currentUser;
    final cid = user?.uid;
    return cid;
  }

  @override
  Widget build(BuildContext context) {
    String? cid = retrieveList();
    return Container(
      child: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            width: 20,
            height: 30,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _fireStore
                .collection('orders')
                .where('posts', isEqualTo: '/post/' + UId)
                .where('user', isEqualTo: cid)
                .snapshots(),
            builder: (context, snapshot) {
              List<Widget> titleWidget = [];
              if (!snapshot.hasData) {
                return Text('No orders available');
              }

              if (snapshot.data != null) {
                final orders = snapshot.data?.docs;

                for (var order in orders!) {
                  final skil = order.get('skills');
                  final summary = order.get('summary');
                 

                  final OfferWidget = orders2(
                    CompanyName: CompanyName,
                    offertitle: offertitle,
                    skil: skil,
                      summary: summary,

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

}
