import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/models/post.dart';
import 'package:esaa/screens/company_home/company_home.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/database/database.dart';

import 'package:flutter/material.dart';

class CompanyPosts extends StatelessWidget {
  const CompanyPosts({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            CustomListView(
                query: PostDatabase.postsCollection
                    .where("companyID", isEqualTo: App.user.id)
                    .orderBy("timePosted", descending: true),
                emptyListWidget: const SizedBox(
                  child: Text(
                    'No offers posted',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                itemBuilder: (context, querySnapshot) {
                  Post post = Post.fromDocumentSnapshot(querySnapshot);
                  return PostCardCompany(post: post, filters: const ["pending", "accepted"]);
                }
            ),

          ],
        )
      ),
    );
  }
}
