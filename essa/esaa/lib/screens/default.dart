import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'company_home/company_home.dart';
import 'job_seeker_home/job_seeker_home.dart';
import 'post_job/post_job.dart';

class Default extends StatelessWidget {
  const Default({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: Scaffold(
        backgroundColor: kFillColor,
        body: Stack(
          children: [

            GetX<UserController>(
                builder: (controller) {
                  return Visibility(
                    visible: controller.user.value.userType == "jobSeeker",
                    child: Transform.rotate(
                      origin: const Offset(40, -150),
                      angle: 2.4,
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 75,
                          top: 40,
                        ),
                        height: 400,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          gradient: const LinearGradient(
                              begin: Alignment.bottomLeft,
                              colors: [kPrimaryColor, kTextColor]
                          ),
                        ),
                      ),
                    ),
                  );
                }
            ),

            GetX<UserController>(
                builder: (controller) {
                  return Container(
                      child: getSelectedWidget(index: controller.currentIndex, userType: controller.user.value.userType)
                  );
                }
            ),
          ],
        ),
        bottomNavigationBar: GetX<UserController>(
            builder: (controller) {
              final items = getItems(controller.user.value.userType);

              return CurvedNavigationBar(
                  backgroundColor: kFillColor,
                  color: kPrimaryColor,
                  animationDuration: const Duration(milliseconds: 40),
                  index: controller.currentIndex,
                  items: items,
                  onTap: controller.changePage
              );
            }
        ),
      )
    );
  }

  List<Widget> getItems(String userType){
    if(userType == "jobSeeker") {
      return const [
        Icon(
          Icons.document_scanner,
          color: Colors.white,
        ),
        Icon(
          Icons.work_outline_outlined,
          color: Colors.white,
        ),
        Icon(
          Icons.home,
          color: Colors.white,
        ),
      ];
    }
    else if (userType == "company"){
      return const [
        Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
        Icon(
          Icons.home,
          color: Colors.white,
        ),
        Icon(
          Icons.document_scanner_rounded,
          color: Colors.white,
        ),
      ];
    }
    return const [
      Icon(
        Icons.add_rounded,
        color: Colors.white,
      ),
      Icon(
        Icons.home,
        color: Colors.white,
      ),
      Icon(
        Icons.document_scanner_rounded,
        color: Colors.white,
      ),
    ];
  }

  Widget getSelectedWidget({required int index, required String userType}) {
    Widget widget;

    if(userType == "jobSeeker"){
      switch (index) {
        case 0:
          widget = const AvailablePostsScreen();
          break;
        case 1:
          widget = const JobSeekerTabBarPage();
          break;
        case 2:
          widget = const AvailablePostsScreen(); //ListOffers();
          break;

        default:
          widget = const AvailablePostsScreen();
          break;
      }
    } else {
      switch (index) {
        case 0:
          widget = const PostJob(); //post a new job
          break;

        case 1:
          widget = const CompanyPosts(); //view all posts... both assigned and unassigned
          break;

        case 2:
          widget = const CompanyTabBarPage(); //view all posts... differentiate assigned and unassigned
          break;

        default:
          widget = Container(color: Colors.brown);//const ListOffers(); //jumanas page
          break;
      }
    }

    return widget;
  }
}
