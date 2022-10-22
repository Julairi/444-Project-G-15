import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/company_home/company_home.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/services.dart';
import 'package:flutter/material.dart';

class FullJobList extends StatelessWidget {
  const FullJobList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
        title: const Text("الوظائف السابقة",
            style: TextStyle(
                color: kFillColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis)),
        showLeading: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomListView(
                  query: OrderDatabase.ordersCollection
                      .where("userID", isEqualTo: App.user.id)
                      .where("orderStatus", isEqualTo: "accepted")
                      .orderBy("timeApplied", descending: true),
                  emptyListWidget: Container(
                    margin: const EdgeInsets.only(top: 300, bottom: 100),
                    child: Center(
                      child: Text(
                        App.user.userType == "jobSeeker"
                            ? "لا يوجد وظائف سابقة"
                            : "لا يوجد وظائف سابقة",
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
                    return OrderCard(order: order, showPaymentStatus: false);
                  }),
            ],
          ),
        ));
  }
}
