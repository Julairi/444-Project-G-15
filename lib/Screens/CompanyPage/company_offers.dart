import 'package:esaa/constants.dart';
import 'package:esaa/responsive.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaa/Screens/Login/login_screen.dart';
import 'package:esaa/Screens/signup/sec_signup_scren.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import 'package:flutter/material.dart';
import 'package:esaa/components/OfferCard.dart';
import 'package:esaa/components/appbar.dart';

// Import the firebase_core plugin
//Import firestore database
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../components/background.dart';

class certianOffers extends StatefulWidget {
  oneCompanyOffers createState() => oneCompanyOffers();
}

class oneCompanyOffers extends State<certianOffers> {
  final _auth = FirebaseAuth.instance;
  late final CompanyName;

  // List<Object> cOffers = [];

  String? retrieveList() {
    final User? user = FirebaseAuth.instance.currentUser;
    final cid = user?.uid;
    //return cid;
    return "/company/HtgizLsb0tWt3JxlpXCxsc4Nz623";
    /*final cid = 'testCompany';
    // here you write the codes to input the data into firestore
    var docRef = await FirebaseFirestore.instance
        .collection('posts')
        .where("user", isEqualTo: cid)
        .get();

    setState(() {
      cOffers = List.from(docRef.docs.map((doc) => offers.fromSnapshot(doc)));
    });

    //.get()
    //doc().get();
    //.where("capital", isEqualTo: true).get()*/
  }

  @override
  Widget build(BuildContext context) {
    String? cid = retrieveList();
    return appbar(
      child: SafeArea(
          child: Column(
        children: [
          SizedBox(
            width: 20,
            height: 30,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .where("user", isEqualTo: cid)
                .orderBy('Date', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              List<Widget> titleWidget = [];
              if (!snapshot.hasData) {
                return Text('No offers Posted');
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
                final String user = (lastSlash != -1)
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
              return Column(
                children: titleWidget,
              );
            },
          ),
        ],
      )),
    );
  }

  void postStreams() async {
    await for (var snapshot
        in FirebaseFirestore.instance.collection('posts').snapshots()) {
      for (var posts in snapshot.docs) {
        print(posts.data());
      }
    }
  }

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
