import 'package:esaa/screens/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/widgets.dart';

class JobSeekerNotificationScreen extends StatelessWidget {

  JobSeekerNotificationScreen({Key? key}) : super(key: key);


  final _auth = FirebaseAuth.instance;
  var CompanyName = 'company';

  //late final CompanyName;

  // List<Object> cOffers = [];

  String? retrieveList() {
    final User? user = FirebaseAuth.instance.currentUser;
    //final cid = user?.uid;
    String? cid = '/jobseeker/' + user!.uid;
    return cid;
    //return "/company/HtgizLsb0tWt3JxlpXCxsc4Nz623";
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

    return CustomAppbar(
      showLeading: true,
      child: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            width: 20,
            height: 30,
          ),

          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('orders')
                //.where("user", isEqualTo: cid)
                .where('thereIsMessage', isEqualTo: 'true')
                //.where("notification", isNotEqualTo: 'none')
                // .orderBy('Date', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              List<Widget> titleWidget = [];
              if (!snapshot.hasData) {
                return const Text('لايوجد لديك إشعارات');
              }
              final notifications = snapshot.data!.docs;
              if (snapshot.data != null) {
                for (var notification in notifications) {
                  final uid = notification.id;

                  final message = notification.get('notification');

                  final companyPath = notification.get('user');
                  var lastSlash = companyPath.lastIndexOf('/');
                  final String user = (lastSlash != -1)
                      ? companyPath.substring(lastSlash)
                      : companyPath;

                  final fm = setCompanyName(companyPath, user);
                  Convertstring(fm);

                  final notificationWidget = JobSeekerNotificationCard(
                    uID: uid,
                    companyPath: companyPath,
                    companyName: CompanyName,
                    notification: message,
                  );

                  titleWidget.add(notificationWidget);
                }
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
