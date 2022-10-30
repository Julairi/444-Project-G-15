import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

import 'chat/chat.dart';
import 'company_home/company_home.dart';
import 'job_seeker_home/job_seeker_home.dart';
import 'post_job/post_job.dart';

class Default extends StatefulWidget {
  Default({Key? key}) : super(key: key) {
    Get.find<UserController>().bindUser();
  }

  @override
  State<Default> createState() => _DefaultState();
}

class _DefaultState extends State<Default> {
  @override
  void initState() {
    registerNotification();

    // For handling notification when the app is in background
    // but not terminated
    checkForInitialMessage();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title ?? "",
        body: message.notification?.body ?? "",
      );
      _showNotification(notification);
    });

    super.initState();
  }

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
              GetX<UserController>(builder: (controller) {
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
                            colors: [kPrimaryColor, kTextColor]),
                      ),
                    ),
                  ),
                );
              }),
              GetX<UserController>(builder: (controller) {
                return Container(
                    child: getSelectedWidget(
                        index: controller.currentIndex,
                        userType: controller.user.value.userType));
              }),
            ],
          ),
          bottomNavigationBar: GetX<UserController>(builder: (controller) {
            final items = getItems(controller.user.value.userType);

            return CurvedNavigationBar(
                backgroundColor: kFillColor,
                color: kPrimaryColor,
                animationDuration: const Duration(milliseconds: 40),
                index: controller.currentIndex,
                items: items,
                onTap: controller.changePage);
          }),
        ));
  }

  List<Widget> getItems(String userType) {
    if (userType == "jobSeeker") {
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
        Icon(
          Icons.chat,
          color: Colors.white,
        ),
        Icon(
          Icons.account_circle,
          color: Colors.white,
        ),
      ];
    } else if (userType == "company") {
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
        Icon(
          Icons.chat,
          color: Colors.white,
        ),
        Icon(
          Icons.account_circle,
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
      Icon(
        Icons.chat,
        color: Colors.white,
      ),
      Icon(
        Icons.account_circle,
        color: Colors.white,
      ),
    ];
  }

  Widget getSelectedWidget({required int index, required String userType}) {
    Widget widget;

    if (userType == "jobSeeker") {
      switch (index) {
        case 0:
          widget = const AvailablePostsScreen();
          break;
        case 1:
          widget = const JobSeekerTabBarPage();
          break;
        case 2:
          widget = const AvailablePostsScreen();
          break;
        case 3:
          widget = const Conversations();
          break;
        case 4:
          widget = const ProfileScreen();
          break;

        default:
          widget = const AvailablePostsScreen();
          break;
      }
    } else {
      switch (index) {
        case 0:
          widget = const PostJob();
          break;
        case 1:
          widget = const CompanyPosts();
          break;
        case 2:
          widget = const CompanyTabBarPage();
          break;
        case 3:
          widget = const Conversations();
          break;
        case 4:
          widget = const ProfileScreen();
          break;

        default:
          widget = const CompanyPosts();
          break;
      }
    }

    return widget;
  }

  void registerNotification() async {
    final FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        PushNotification notification = PushNotification(
          title: message.notification?.title ?? "",
          body: message.notification?.body ?? "",
        );

        _showNotification(notification);
      });
    } else {
      if (kDebugMode) {
        print('User declined or has not accepted permission');
      }
    }
  }

  checkForInitialMessage() async {
    await Firebase.initializeApp();

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title ?? "",
        body: initialMessage.notification?.body ?? "",
      );

      _showNotification(notification);
    }
  }

  void _showNotification(PushNotification notification) {
    if (notification.body != "" && notification.title != "") {
      showSimpleNotification(
        Text(notification.title),
        leading: const Icon(Icons.notifications),
        subtitle: Text(notification.body),
        background: kPrimaryColor,
        duration: const Duration(seconds: 2),
      );
    }
  }
}
