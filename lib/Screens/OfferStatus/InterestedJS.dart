import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/appbar.dart';
import '../CompanyPage/square.dart';

class InterstedJS extends StatefulWidget {
  const InterstedJS({super.key});

  @override
  State<InterstedJS> createState() => _InterstedJSState();
}

class _InterstedJSState extends State<InterstedJS> {
  final _fireStore = FirebaseFirestore.instance;
  List<Object> _jobList = [];
  final _auth = FirebaseAuth.instance;

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
            stream: _fireStore.collection('orders').snapshots(),
            builder: (context, snapshot) {
              List<Widget> titleWidget = [];
              if (!snapshot.hasData) {
                return Text('No offers available');
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

                  //  final fm = setCompanyName(companyPath, user);
                  //      Convertstring(fm);
                  //   final OfferWidget = CardO(
                  //        CompanyPath: companyPath,
                  //    CompanyName: CompanyName,
                  //    offertitle: offertitle,
                  //    offerCity: offerCity,
                  //    offerDate: offerDate,
                  //    offerDes: offerDes,
                  //    offerFee: offerFee,
                  //    offerHours: offerHours,
                  //   offerTime: offerTime,
                  //   );

                  //    titleWidget.add(OfferWidget);
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
}
