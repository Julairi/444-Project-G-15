import 'package:esaa/config/constants.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/company_home/company_home.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/database/database.dart';
import 'package:flutter/material.dart';

class AvailablePostsScreen extends StatelessWidget {
  const AvailablePostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [

              const SizedBox(height: 20),

              Center(
                child: StreamBuilder<List<Post>>(
                    stream: PostDatabase().getAvailablePosts(),
                    builder: (context, snapshot) {
                      int postCount = 0;

                      if (snapshot.hasData) {
                        postCount = snapshot.data?.length ?? 0;
                      }

                      return SizedBox(
                        child: Text(
                          '$postCount المنشورات المتاحة${postCount > 1 ? "" : ""}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }),
              ),

              CustomListView(
                  query: PostDatabase.postsCollection.where("offerStatus",
                      whereIn: [
                        "pending",
                        "assigned"
                      ]).orderBy("timePosted", descending: true),
                  emptyListWidget: const SizedBox(
                    child: Text(
                      'ليس هناك أي منشورات في الوقت الحالي',
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
