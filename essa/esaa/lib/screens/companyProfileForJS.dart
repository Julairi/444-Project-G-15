// ignore_for_file: file_names

import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/models/models.dart';
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
  }

  @override
  Widget build(BuildContext context) {

    return CustomAppbar(
        title: const Text("حساب الشركة",
            style: TextStyle(
                color: kFillColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis)),
        showLeading: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                  margin: const EdgeInsets.all(100.0),
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  width: double.infinity,
                  child: controller.user.value.imgUrl == ''
                      ? const Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.white,
                        )
                            :  GetX<ProfileController>(
                            builder: (controller) {
                              return Image.network(controller.user.value.imgUrl);
                            }
                        ));
                  }
              ),

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
                      GetX<ProfileController>(
                          builder: (controller) {
                            return Text(controller.user.value.name,
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis
                                )
                            );
                          }
                      ),
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
                      GetX<ProfileController>(
                          builder: (controller) {
                            return Text(
                                controller.user.value.email,
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis
                                )
                            );
                          }
                      ),
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
                      GetX<ProfileController>(
                          builder: (controller) {
                            return Text(
                                controller.user.value.contact,
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis
                                )
                            );
                          }
                      ),
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
                      GetX<ProfileController>(
                          builder: (controller) {
                            return Text(controller.user.value.description,
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis));
                          }
                      ),
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
                      GetX<ProfileController>(
                          builder: (controller) {
                            return Text(controller.user.value.address,
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis));
                          }
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "تقييم الشركة",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GetX<ProfileController>(
                    builder: (controller) {
                      return RatingBar.builder(
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
                      );
                    }
                  ),

                  const SizedBox(width: 10),

                  GetX<ProfileController>(
                    builder: (controller) {
                      return Text(
                        '(${controller.user.value.rates.isNotEmpty ? controller.user.value.rates.length : 'No ratings yet'})',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: controller.user.value.rates.isNotEmpty ? 24 : 16,
                            fontWeight: FontWeight.w500
                        ),
                      );
                    }
                  )
                ],
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "تقييم الشركة",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GetX<ProfileController>(
                    builder: (controller) {
                      return RatingBar.builder(
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
                      );
                    }
                  ),

                  const SizedBox(width: 10),

                  GetX<ProfileController>(
                    builder: (controller) {
                      return Text(
                        '(${controller.user.value.rates.isNotEmpty ? controller.user.value.rates.length : 'No ratings yet'})',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: controller.user.value.rates.isNotEmpty ? 24 : 16,
                            fontWeight: FontWeight.w500
                        ),
                      );
                    }
                  )
                ],
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
                child: const Text('لجميع عروض الشركة اضغط هنا',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        overflow: TextOverflow.ellipsis)),
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "تقييم الشركة",
                  style: TextStyle(
                      color: Colors.black,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: kPrimaryColor,
                        ),
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

  double _sumRating(List<dynamic> rates) {
    double totalValue = 0;
    for(double rating in rates){
      totalValue = totalValue + rating;
    }

    if(totalValue == 0 || rates.isEmpty) return 0;

    return totalValue / rates.length;
  }
}

class ProfileController extends UserController {}
