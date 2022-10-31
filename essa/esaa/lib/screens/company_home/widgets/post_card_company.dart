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
  const PostCardCompany({required this.post, required this.filters, this.skipDetails = false, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if(skipDetails){
            Get.to(() => PostOrders(post: post, filters: filters));
          }else {
            Get.to(() => CompanyPostDetails(post: post, filters: filters));
          }
        },
        child: Card(
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
                            const Color.fromARGB(255, 105, 110, 112)
                                .withOpacity(0),
                            const Color.fromARGB(255, 64, 69, 71)
                                .withOpacity(0.2)
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
                                    color: Colors.blue,
                                    fontSize: defaultFontSize,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    overflow: TextOverflow.ellipsis)
                            ),
                            onTap: () {
                              if (skipDetails) {
                                Get.to(() => PostOrders(post: post, filters: filters));
                              } else {
                                Get.to(() => CompanyPostDetails(post: post, filters: filters));
                              }
                            }
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                      width: 15,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color.fromARGB(255, 237, 229, 109),
                        ),
                        const SizedBox(
                          height: 20,
                          width: 10,
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
