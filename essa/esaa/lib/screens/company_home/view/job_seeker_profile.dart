import 'package:esaa/config/constants.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/company_home/company_home.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class JobSeekerProfile extends StatelessWidget {
  const JobSeekerProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderDetailsController>();

    return CustomAppbar(
        title: const Text("الملف الشخصي للباحث عن العمل ",
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis)),
        showLeading: true,
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 30),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  elevation: 6,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: kPrimaryColor,
                          size: 28,
                        ),
                        const SizedBox(
                          height: 20,
                          width: 15,
                        ),
                        Text(controller.user.value.name,
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  elevation: 6,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.email,
                          color: kPrimaryColor,
                          size: 28,
                        ),
                        const SizedBox(
                          height: 20,
                          width: 15,
                        ),
                        Text(controller.user.value.email,
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RatingBar.builder(
                      initialRating: _sumRating(controller.user.value.rates),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      ignoreGestures: true,
                      onRatingUpdate: (double value) {},
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '(${controller.user.value.rates.isNotEmpty ? controller.user.value.rates.length : 'No ratings yet'})',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize:
                              controller.user.value.rates.isNotEmpty ? 24 : 16,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "الوظائف السابقة",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                CustomListView(
                    query: OrderDatabase.ordersCollection
                        .where("userID", isEqualTo: controller.user.value.id)
                        .where("orderStatus", isEqualTo: "accepted")
                        .orderBy("timeApplied", descending: true),
                    emptyListWidget: const SizedBox(
                      height: 300,
                      child: Center(
                        child: Text(
                          "لايوجد وظائف سابقة",
                          textAlign: TextAlign.center,
                          style: TextStyle(
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
          ),
        ));
  }

  double _sumRating(List<dynamic> rates) {
    double totalValue = 0;
    for (double rating in rates) {
      totalValue = totalValue + rating;
    }

    if (totalValue == 0 || rates.isEmpty) return 0;

    return totalValue / rates.length;
  }
}
