import 'package:esaa/config/constants.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/company_home/company_home.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/database/database.dart';
import 'package:flutter/material.dart';

class CompanyPostsForJobSeeker extends StatelessWidget {
  final String companyID;

  const CompanyPostsForJobSeeker({Key? key, required this.companyID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      showLeading: true,
      child: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(height: 10),
          CustomListView(
              query: PostDatabase.postsCollection
                  .where("companyID", isEqualTo: companyID)
                  .where("offerStatus", isEqualTo: "pending")
                  .orderBy("timePosted", descending: true),
              emptyListWidget: const SizedBox(
                child: Text(
                  "هذه الشركة ليست لديها أي عروض حالياً",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              itemBuilder: (context, querySnapshot) {
                Post post = Post.fromDocumentSnapshot(querySnapshot);
                return PostCardJobSeeker(post: post);
              }),
        ],
      )),
    );
  }
}
