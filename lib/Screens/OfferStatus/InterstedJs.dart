import 'package:esaa/Screens/OfferStatus/CardComp.dart';
import 'package:esaa/Screens/OfferStatus/InterstedCards.dart';
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

//import 'package:esaa/components/OfferCard.dart';
//import 'package:esaa/components/offerCardComp.dart';
import 'package:esaa/components/appbar.dart';

// Import the firebase_core plugin
//Import firestore database
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../components/background.dart';
import '../CompanyPage/square.dart';

class IntrestedJs extends StatefulWidget {
  String postid;
  IntrestedJs({Key? key, required this.postid}) : super(key: key);

  oneIntrestedJs createState() => oneIntrestedJs();
}

class oneIntrestedJs extends State<IntrestedJs> {
  //final String postid;

  ///oneIntrestedJs({required this.postid}) : super();

  //final pp = widget.postid;
  // final _auth = FirebaseAuth.instance;
  // var CompanyName = 'company';
  //late final CompanyName;

  // List<Object> cOffers = [];

  String? retrieveList() {
    String? pid = '/posts/' + widget.postid;
    return pid;
  }

  @override
  Widget build(BuildContext context) {
    String? cid = retrieveList();
    return appbar(
      child: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            width: 20,
            height: 30,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('orders')
                .where("post", isEqualTo: cid)
                //   .where("offerstatus", isEqualTo: "pending")
                // .orderBy('Date', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              List<Widget> titleWidget = [];
              if (!snapshot.hasData) {
                return Text('لا يوجد طلبات لهذا العرض');
              }
              if (snapshot.data != null) {
                final posts = snapshot.data?.docs;

                for (var post in posts!) {
                  final uid = post.id;
                  final skills = post.get('skills');
                  final summary = post.get('summary');
                  final userPath = post.get('user');
                  var lastSlash = userPath.lastIndexOf('/');
                  final String user = (lastSlash != -1)
                      ? userPath.substring(lastSlash)
                      : userPath;

                  //        String fm = setCompanyName(userPath, user);
                  //       Convertstring(fm);

                  final OfferWidget = InterstedCardComp(
                    //newcard
                    UID: "fm",
                    userPath: userPath,
                    skills: skills,
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

  void postStreams() async {
    await for (var snapshot
        in FirebaseFirestore.instance.collection('posts').snapshots()) {
      for (var posts in snapshot.docs) {
        print(posts.data());
      }
    }
  }

  //Future<String> setCompanyName(String path, String user) async {
  //////
  //final companyName = await FirebaseFirestore.instance
  // .collection('jobseeker')
  //.doc(user)
  ///.get()
  //  .then((val) {
  //  return val.data()?["Name"];
  //  });
//  return companyName;
  // }

  //void Convertstring(Future<String> cm) async {
  //   CompanyName = await cm;
//  }
}
