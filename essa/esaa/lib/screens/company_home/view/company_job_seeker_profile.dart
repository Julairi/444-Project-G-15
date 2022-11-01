import 'package:esaa/config/constants.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/company_home/company_home.dart';
import 'package:esaa/screens/review_page.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class CompanyJobSeekerProfile extends StatelessWidget {
  const CompanyJobSeekerProfile({Key? key}) : super(key: key);

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GetX<OrderDetailsController>(builder: (controller) {
                      return RatingBar.builder(
                        initialRating: _sumRating(controller.reviews),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 30,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 18,
                        ),
                        ignoreGestures: true,
                        onRatingUpdate: (double value) {},
                      );
                    }),
                    const SizedBox(width: 10),
                    GetX<OrderDetailsController>(builder: (controller) {
                      return Text(
                        '(${controller.reviews.isNotEmpty ? controller.reviews.length : 'ليس هناك تقييمات'})',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: controller.reviews.isNotEmpty ? 24 : 16,
                            fontWeight: FontWeight.w500),
                      );
                    })
                  ],
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () => Get.to(
                          () => ReviewPage(userID: controller.user.value.id)),
                      child: const Text(
                        "عرض التقييمات",
                        style: TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
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
                          Icons.male,
                          color: kPrimaryColor,
                          size: 28,
                        ),
                        const SizedBox(
                          height: 20,
                          width: 15,
                        ),
                        Text(controller.user.value.sex,
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "الأعمال السابقة",
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
                          "لا يوجد أعمال سابقة",
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

  double _sumRating(List<Review> reviews) {
    double totalValue = 0;
    for (Review review in reviews) {
      totalValue = totalValue + review.rating;
    }

    if (totalValue == 0 || reviews.isEmpty) return 0;

    return totalValue / reviews.length;
  }
}
