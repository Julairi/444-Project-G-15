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

// Import the firebase_core plugin
//Import firestore database
//import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../components/background.dart';

class certianOffers extends StatefulWidget {
  oneCompanyOffers createState() => oneCompanyOffers();
}

class oneCompanyOffers extends State<certianOffers> {
  final _auth = FirebaseAuth.instance;

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
        .orderBy('Date', descending: true)
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 52, 64, 110),
        title: Text('عروض العمل'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                postStreams();
              },
              icon: Icon(Icons.close)),
          Center(
            child: new Image.asset('assets/logoo.png'),
          )
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
            stream: FirebaseFirestore.instance
                .collection('posts')
                .where("user", isEqualTo: cid)
                .orderBy('Date', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              List<Widget> titleWidget = [];
              if (!snapshot.hasData) {
                print("You haven't posted any offers");
              }
              final posts = snapshot.data!.docs;

              for (var post in posts) {
                final offertitle = post.get('Title');
                final offerCity = post.get('City');

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
                    child: Expanded(
                      flex: 8,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
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
                                    Text(
                                      ' $offertitle',
                                      style: TextStyle(
                                          color: kPrimaryLightColor,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ' $offerCity',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 245, 250, 252),
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
                    ));
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
}
