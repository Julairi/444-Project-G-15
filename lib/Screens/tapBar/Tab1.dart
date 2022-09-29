import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaa/components/orderscard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/appbar.dart';
import '../CompanyPage/square.dart';

class Tab1 extends StatefulWidget {
  const Tab1({super.key});

  @override
  State<Tab1> createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  final _fireStore = FirebaseFirestore.instance;
  List<Object> _jobList = [];
  final _auth = FirebaseAuth.instance;
  var CompanyName = 'company';

  @override
  Widget build(BuildContext context) {
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
                .collection('posts')
                .where(
                  'orderstatus',
                  isEqualTo: 'pending',
                )
                .snapshots(),
            builder: (context, snapshot) {
              List<Widget> titleWidget = [];
              if (!snapshot.hasData) {
                return Text('No offers available');
              }

              if (snapshot.data != null) {
                final orders = snapshot.data?.docs;

                for (var post in orders!) {
                  final uid = post.id;
                  final offertitle = post.get('Title');
                  final companyPath = post.get('user');
                  var lastSlash = companyPath.lastIndexOf('/');
                  String user = (lastSlash != -1)
                      ? companyPath.substring(lastSlash)
                      : companyPath;

                  final fm = setCompanyName(companyPath, user);
                  Convertstring(fm);
                  final OfferWidget = cardOrder(
                    CompanyName: CompanyName,
                    offertitle: offertitle,
                    UId: uid,
                  );
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
