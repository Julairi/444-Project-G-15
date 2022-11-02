import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/database/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReviewPage extends StatelessWidget {
  final String userID;
  const ReviewPage({required this.userID, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      showLeading: true,
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomListView(
              query: ReviewDatabase.reviewsCollection
                  .where("uID", isEqualTo: userID)
                  .orderBy("timePosted", descending: true),
              emptyListWidget: SizedBox(
                height: 200,
                child: Center(
                  child: Text(
                    '${userID == App.user.id ? "ليس لديك" : "This user has"} عروض بعد',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
              itemBuilder: (context, querySnapshot) {
                Review review = Review.fromDocumentSnapshot(querySnapshot);
                return ReviewCard(review: review);
              }),
        ],
      )),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final Review review;
  const ReviewCard({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 7,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(
                  "https://i.pinimg.com/474x/6a/d3/66/6ad3663d79ccc962377d7a6cbe4d9bfe.jpg",
                  height: 50,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                child: Container(
                  height: 50,
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        const Color.fromARGB(255, 105, 110, 112).withOpacity(0),
                        const Color.fromARGB(255, 64, 69, 71).withOpacity(0.2)
                      ],
                          stops: const [
                        0.6,
                        1
                      ])),
                  child: Row(
                    children: [
                      const SizedBox(
                        height: 20,
                        width: 20,
                      ),
                      StreamBuilder<User>(
                          stream: UserDatabase("")
                              .getUserAsStream(review.reviewerID),
                          builder: (context, snapshot) {
                            return Text(
                              snapshot.data?.name ?? "",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 6, 6, 6),
                                  fontSize: 18,
                                  fontFamily: 'ElMessiri',
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis),
                            );
                          })
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (review.comment.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  review.comment,
                  style: const TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.ellipsis,
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                ),
              ),
            ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.orangeAccent,
                  size: review.comment.isEmpty ? 30 : 20,
                ),
                const SizedBox(width: 5),
                Text(
                  review.rating.toString(),
                  style: const TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.ellipsis,
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                ),
                const Expanded(child: SizedBox()),
                Text(
                  DateFormat('dd/mm/yyyy hh:mm aa').format(review.timePosted),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic,
                    overflow: TextOverflow.ellipsis,
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
