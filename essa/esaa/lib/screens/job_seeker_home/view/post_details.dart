import 'package:esaa/config/constants.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/apply/apply_screen.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/company_posts_for_job_seeker.dart';

class PostDetails extends StatelessWidget {
  final Post post;
  final bool canApply;
  const PostDetails({required this.post, this.canApply = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TransparentAppbar(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: defaultPadding),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Icon(
                      Icons.work_outline_outlined,
                      color: Color.fromARGB(255, 22, 126, 210),
                      size: 40,
                    ),
                    const SizedBox(
                      height: 20,
                      width: 12,
                    ),
                    Text(
                      post.title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.fade),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      '  : وصف العمل \n ${post.description}',
                      style: const TextStyle(
                          color: kPrimaryColor,
                          fontSize: defaultFontSize,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.business_outlined,
                          color: Color.fromARGB(255, 5, 53, 93),
                        ),
                        const SizedBox(
                          height: 20,
                          width: 10,
                        ),
                        Text(
                          post.companyName,
                          style: const TextStyle(
                              color: kPrimaryColor,
                              fontSize: defaultFontSize,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.fade),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                      width: 15,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            color: Color.fromARGB(255, 237, 229, 109),
                            size: 35),
                        const SizedBox(
                          height: 20,
                          width: 10,
                        ),
                        Text(post.city,
                            style: const TextStyle(
                                color: kPrimaryColor,
                                fontSize: defaultFontSize,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis))
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                  width: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_month_outlined,
                            color: Color.fromARGB(255, 3, 77, 138), size: 35),
                        const SizedBox(
                          height: 20,
                          width: 10,
                        ),
                        Text(post.date,
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
                    Row(
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          color: Color.fromARGB(255, 3, 77, 138),
                          size: 35,
                        ),
                        const SizedBox(
                          height: 20,
                          width: 10,
                        ),
                        Text(post.date,
                            style: const TextStyle(
                                color: kPrimaryColor,
                                fontSize: defaultFontSize,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis))
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                  width: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.payments,
                          color: Color.fromARGB(255, 7, 154, 68),
                          size: 35,
                        ),
                        const SizedBox(
                          height: 20,
                          width: 10,
                        ),
                        Text(
                          '${post.payPerHour} لكل ساعة عمل',
                          style: const TextStyle(
                              color: kPrimaryColor,
                              fontSize: defaultFontSize,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                      width: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.hourglass_bottom_outlined,
                          color: Color.fromARGB(255, 143, 13, 13),
                          size: 35,
                        ),
                        const SizedBox(
                          height: 20,
                          width: 10,
                        ),
                        Text(
                          '${post.nHours}  ساعات  ',
                          style: const TextStyle(
                              color: kPrimaryColor,
                              fontSize: defaultFontSize,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                  width: 10,
                ),
                if (canApply)
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                        onPressed: () => Get.to(() => ApplyScreen(post: post)),
                        child: const Text('التقديم على الوظيفة')),
                  ),
                TextButton(
                    onPressed: () => Get.to(() =>
                        CompanyPostsForJobSeeker(companyID: post.companyID)),
                    child: const Text('لمزيدٍ من عروض هذه الشركه اضغط هنا ')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
