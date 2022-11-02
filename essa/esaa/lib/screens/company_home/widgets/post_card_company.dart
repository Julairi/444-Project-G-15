import 'package:esaa/config/constants.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/company_home/view/company_post_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../company_home.dart';

class PostCardCompany extends StatelessWidget {
  final Post post;
  final List<String> filters;
  final bool skipDetails;
  const PostCardCompany(
      {required this.post,
      required this.filters,
      this.skipDetails = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (skipDetails) {
            Get.to(() => PostOrders(post: post, filters: filters));
          } else {
            Get.to(() => CompanyPostDetails(post: post, filters: filters));
          }
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 7,
          color: Colors.white,
          shadowColor: kPrimaryColor,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: 50,
                      alignment: Alignment.bottomRight,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(),
                      child: Row(
                        children: [
                          const SizedBox(
                            height: 20,
                            width: 20,
                          ),
                          const Icon(
                            Icons.work_outline,
                            color: Color.fromARGB(255, 83, 80, 80),
                            size: 35,
                          ),
                          const SizedBox(
                            height: 20,
                            width: 20,
                          ),
                          Text(
                            post.title,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 6, 6, 6),
                                fontSize: 18,
                                fontFamily: 'ElMessiri',
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.fade),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            child: Text(
                                '${post.acceptedApplicants}/${post.maxNoOfApplicants} طلبات مقبولة',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 63, 75, 85),
                                    fontSize: defaultFontSize,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    overflow: TextOverflow.ellipsis)),
                            onTap: () {
                              if (skipDetails) {
                                Get.to(() =>
                                    PostOrders(post: post, filters: filters));
                              } else {
                                Get.to(() => CompanyPostDetails(
                                    post: post, filters: filters));
                              }
                            })
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                      width: 5,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color.fromARGB(255, 237, 229, 109),
                        ),
                        const SizedBox(
                          height: 10,
                          width: 5,
                        ),
                        Text(post.city,
                            style: const TextStyle(
                                color: kPrimaryColor,
                                fontSize: defaultFontSize,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.fade))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                      width: 15,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
