import 'package:esaa/config/constants.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/company_home/company_home.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/database/database.dart';

import 'package:flutter/material.dart';

class CompanyPostDetails extends StatelessWidget {
  final Post post;

  const CompanyPostDetails({required this.post, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {

    return CustomAppbar(
      showLeading: true,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            CustomListView(
                query: OrderDatabase.ordersCollection
                    .where("postID", isEqualTo: post.id)
                    .where("orderStatus", isEqualTo: post.offerStatus == 'pending' ? 'pending' : 'accepted')
                    .orderBy("timeApplied", descending: true),
                emptyListWidget: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: Text(
                      'No request has been ${post.offerStatus == 'pending'? "made" : "accepted"} for this post',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
                itemBuilder: (context, querySnapshot) {
                  Order order = Order.fromDocumentSnapshot(querySnapshot);
                  return OrderCard(order: order, post: post);
                }
            ),
          ],
        )
      ),
    );
  }
}
