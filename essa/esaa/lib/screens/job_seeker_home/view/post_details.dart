import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/apply/apply_screen.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/company_posts_for_job_seeker.dart';
import 'package:esaa/screens/companyProfileForJS.dart';

class PostDetails extends StatelessWidget {
  final Post post;
  final bool canApply;
  const PostDetails({required this.post, this.canApply = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      showLeading: true,
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
                      color: kSPrimaryColor,
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
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.fade),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () => Get.to(
                      () => ProfileScreenForJS(companyID: post.companyID)),
                  child: Row(
                    children: [
                      Icon(Icons.business, color: kSPrimaryColor, size: 30),
                      const SizedBox(
                        height: 20,
                        width: 12,
                      ),
                      Text(
                        post.companyName,
                        style: const TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      '   وصف العمل :\n ${post.description}',
                      style: const TextStyle(
                          color: Colors.black,
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
                          Icons.people_alt,
                          color: kSPrimaryColor,
                          size: 30,
                        ),
                        const SizedBox(
                          height: 20,
                          width: 10,
                        ),
                        Text(
                          post.maxNoOfApplicants,
                          style: const TextStyle(
                              color: KGrey,
                              fontSize: defaultFontSize,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.fade),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                      width: 90,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            color: kSPrimaryColor, size: 30),
                        const SizedBox(
                          height: 20,
                          width: 10,
                        ),
                        Text(post.city,
                            style: const TextStyle(
                                color: KGrey,
                                fontSize: defaultFontSize,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis)),
                        const SizedBox(
                          height: 20,
                          width: 20,
                        ),
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
                            color: kSPrimaryColor, size: 30),
                        const SizedBox(
                          height: 20,
                          width: 10,
                        ),
                        Text(
                          '${_getDate(post.startDate)} - ${_getDate(post.endDate)}',
                          style: const TextStyle(
                              color: KGrey,
                              fontSize: defaultFontSize,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.fade),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                      width: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          color: kSPrimaryColor,
                          size: 30,
                        ),
                        const SizedBox(
                          height: 20,
                          width: 10,
                        ),
                        Text(
                          post.time,
                          style: const TextStyle(
                              color: KGrey,
                              fontSize: defaultFontSize,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                  width: 70,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.payments,
                          color: kSPrimaryColor,
                          size: 30,
                        ),
                        const SizedBox(
                          height: 20,
                          width: 10,
                        ),
                        Text(
                          '${post.payPerHour} لكل ساعة عمل',
                          style: const TextStyle(
                              color: KGrey,
                              fontSize: defaultFontSize,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                      width: 30,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.hourglass_bottom_outlined,
                          color: kSPrimaryColor,
                          size: 35,
                        ),
                        const SizedBox(
                          height: 20,
                          width: 10,
                        ),
                        Text(
                          '${post.nHours}  ساعات  ',
                          style: const TextStyle(
                              color: KGrey,
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
                  width: 30,
                ),
                if (canApply)
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                        onPressed: () => Get.to(() => ApplyScreen(post: post)),
                        child: const Text('التقديم على الوظيفة')),
                  ),
                if (Get.find<UserController>().user.value.userType ==
                    "jobSeeker")
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

  String _getDate(String date) {
    String output = "";
    final fields = date.split('-');
    output = "${fields[2]}/${fields[1]}/${fields[0].substring(2)}";
    return output;
  }
}
