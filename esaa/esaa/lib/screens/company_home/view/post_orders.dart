import 'package:esaa/config/constants.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/company_home/company_home.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/database/database.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostOrders extends StatelessWidget {
  final Post post;
  final List<String> filters;

  const PostOrders({required this.post, required this.filters, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      title: const Text(" الطلبات",
          style: TextStyle(
              color: kPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis)),
      showLeading: true,
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          FirestoreQueryBuilder<Object?>(
            query: OrderDatabase.ordersCollection
                .where("postID", isEqualTo: post.id)
                .where("orderStatus", whereIn: filters),
            builder: (context, snapshot, _) {
              if (snapshot.isFetching) {
                return const SpinKitRing(
                  color: kFillColor,
                  size: 24.0,
                );
              }

              if (snapshot.hasError) {
                Fluttertoast.showToast(msg: '${snapshot.error}');
              }

              final count = snapshot.docs.length;

              return Text(
                '$count طلبات${count > 1 ? "" : ""}',
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 20),
              );
            },
          ),
          const SizedBox(height: 10),
          CustomListView(
              query: OrderDatabase.ordersCollection
                  .where("postID", isEqualTo: post.id)
                  .where("orderStatus", whereIn: filters)
                  .orderBy("timeApplied", descending: true),
              emptyListWidget: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Text(
                    'ليس هناك طلبات ${filters.contains("pending") ? "مقدمة" : "مقبولة"} لهذا العرض',
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
              }),
        ],
      )),
    );
  }
}
