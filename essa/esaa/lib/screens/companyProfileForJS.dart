import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/review_page.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:esaa/screens/company_home/widgets/post_card_job_seeker.dart';
import 'package:esaa/screens/job_seeker_home/widgets/company_posts_for_job_seeker.dart';

class ProfileScreenForJS extends StatelessWidget {
  final String companyID;

  ProfileScreenForJS({Key? key, required this.companyID}) : super(key: key) {
    Get.put(ProfileController());
    Get.find<ProfileController>().bindUserWithID(companyID);
    Get.find<ProfileController>().bindReviewsWithID(companyID);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return CustomAppbar(
        title: const Text("حساب الشركة",
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis)),
        showLeading: true,
        showNotification: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              GetX<ProfileController>(builder: (controller) {
                return Container(
                    margin: const EdgeInsets.all(100.0),
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    width: double.infinity,
                    child: controller.user.value.imgUrl == ''
                        ? const Icon(
                            Icons.person,
                            size: 80,
                            color: Colors.white,
                          )
                        : GetX<ProfileController>(builder: (controller) {
                            return Image.network(controller.user.value.imgUrl);
                          }));
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GetX<ProfileController>(builder: (controller) {
                    return RatingBar.builder(
                      initialRating: _sumRating(controller.reviews),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 30,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                  GetX<ProfileController>(builder: (controller) {
                    return Text(
                      '(${controller.reviews.isNotEmpty ? controller.reviews.length : 'لا يوجد تقييمات'})',
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
                          color: kPrimaryColor,
                          decoration: TextDecoration.underline,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                      GetX<ProfileController>(builder: (controller) {
                        return Text(controller.user.value.name,
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis));
                      }),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                      GetX<ProfileController>(builder: (controller) {
                        return Text(controller.user.value.email,
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis));
                      }),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.contact_phone,
                        color: kPrimaryColor,
                        size: 28,
                      ),
                      const SizedBox(
                        height: 20,
                        width: 15,
                      ),
                      GetX<ProfileController>(builder: (controller) {
                        return Text(controller.user.value.contact,
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis));
                      }),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.note,
                        color: kPrimaryColor,
                        size: 28,
                      ),
                      const SizedBox(
                        height: 20,
                        width: 15,
                      ),
                      GetX<ProfileController>(builder: (controller) {
                        return Text(controller.user.value.description,
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis));
                      }),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_city,
                        color: kPrimaryColor,
                        size: 28,
                      ),
                      const SizedBox(
                        height: 20,
                        width: 15,
                      ),
                      GetX<ProfileController>(builder: (controller) {
                        return Text(controller.user.value.address,
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis));
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "عروض الشركة المتاحة",
                  style: TextStyle(
                      color: Colors.black,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: kPrimaryColor,
                        ),
                      ],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
              CustomListView(
                  query: PostDatabase.postsCollection
                      .where("companyID", isEqualTo: companyID)
                      .where("offerStatus", whereIn: [
                    "pending",
                    "assigned"
                  ]).orderBy("timePosted", descending: true),
                  emptyListWidget: const SizedBox(
                    height: 300,
                    child: Center(
                      child: Text(
                        "ليس هناك أي عروض مقدمة لهذه الشركة",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  itemBuilder: (context, querySnapshot) {
                    Post post = Post.fromDocumentSnapshot(querySnapshot);
                    return PostCardJobSeeker(post: post);
                  }),
              const SizedBox(height: 20),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                elevation: 6,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: InkWell(
                    onTap: () => Get.to(() => CompanyPostsForJobSeeker(
                          companyID: companyID,
                        )),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.list,
                          color: kPrimaryColor,
                          size: 28,
                        ),
                        SizedBox(
                          height: 20,
                          width: 15,
                        ),
                        Text('لجميع عروض الشركة اضغط هنا',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
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

class ProfileController extends UserController {}
