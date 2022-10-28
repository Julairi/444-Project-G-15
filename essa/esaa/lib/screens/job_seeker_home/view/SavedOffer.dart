import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/models/post.dart';
import 'package:esaa/screens/company_home/company_home.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/database/database.dart';

import 'package:flutter/material.dart';

// ignore: camel_case_types
class savedOffers extends StatelessWidget {
  const savedOffers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      title: const Text("العروض المحفوظة",
          style: TextStyle(
              color: kPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis)),
      showNotification: true,
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          CustomListView(
              query: PostDatabase.postsCollection
                  .where("userID", isEqualTo: App.user.id)
                  .where('saved', isEqualTo: true)
                  .where("offerStatus", whereIn: [
                "pending",
                "assigned",
                "fully_assigned"
              ]).orderBy("timePosted", descending: true),
              emptyListWidget: const SizedBox(
                child: Text(
                  'لا توجد عروض محفوظة',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              itemBuilder: (context, querySnapshot) {
                Post post = Post.fromDocumentSnapshot(querySnapshot);
                return PostCardCompany(
                    post: post, filters: const ["pending", "accepted"]);
              }),
        ],
      )),
    );
  }
}
