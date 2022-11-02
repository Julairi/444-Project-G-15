import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/screens/notifications/notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/user_controller.dart';
import '../../../services/authentication.dart';

class CustomAppbar extends StatelessWidget {
  final Widget? title;
  final Widget child;
  final String topImage, bottomImage;
  final bool showLeading, showNotification, showChat, showLogout, isCollapsable;
  final void Function()? onChatPressed;

  const CustomAppbar({
    Key? key,
    this.title,
    required this.child,
    this.onChatPressed,
    this.showChat = false,
    this.showLeading = false,
    this.showNotification = false,
    this.showLogout = false,
    this.isCollapsable = true,
    this.topImage = "assets/images/main_top.png",
    this.bottomImage = "assets/images/login_bottom.png",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 242, 242),
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          if (isCollapsable)
            SliverAppBar(
              title: title,
              flexibleSpace: const FlexibleSpaceBar(),
              leading: showLeading
                  ? IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: kPrimaryColor,
                      ))
                  : const SizedBox(),
              actions: [
                showNotification
                    ? IconButton(
                        onPressed: () {
                          if (App.user.userType == 'jobSeeker') {
                            Get.to(() => const JobSeekerNotificationScreen());
                          } else {
                            Get.to(() => const CompanyNotificationScreen());
                          }
                        },
                        icon: const Icon(
                          Icons.notifications,
                          color: kPrimaryColor,
                        ))
                    : const SizedBox(),
                showChat
                    ? IconButton(
                        onPressed: onChatPressed ?? () {},
                        icon: const Icon(
                          Icons.chat,
                          color: Colors.white,
                        ))
                    : const SizedBox(),
                showLogout
                    ? IconButton(
                        onPressed: () async {
                          Get.find<UserController>().clearAll();
                          Get.find<UserController>().changePage(2);
                          await Auth().signOut();
                          Get.toNamed('/login_screen');
                        },
                        icon: const Icon(
                          Icons.logout_sharp,
                          color: kPrimaryColor,
                        ))
                    : const SizedBox(),
                const SizedBox(width: defaultPadding),
              ],
              backgroundColor: Colors.transparent,
              expandedHeight: 80,
              elevation: 0,
              floating: true,
              snap: true,
              pinned: true,
            ),
        ],
        body: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Scaffold(
                  appBar: isCollapsable
                      ? null
                      : AppBar(
                          elevation: 0,
                          title: title,
                          flexibleSpace: const FlexibleSpaceBar(),
                          leading: showLeading
                              ? IconButton(
                                  onPressed: () => Get.back(),
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: kPrimaryColor,
                                  ))
                              : const SizedBox(),
                          actions: [
                            showNotification
                                ? IconButton(
                                    onPressed: () {
                                      if (App.user.userType == 'jobSeeker') {
                                        Get.to(() =>
                                            const JobSeekerNotificationScreen());
                                      } else {
                                        Get.to(() =>
                                            const CompanyNotificationScreen());
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.notifications,
                                      color: Colors.white,
                                    ))
                                : const SizedBox(),
                            showChat
                                ? IconButton(
                                    onPressed: onChatPressed ?? () {},
                                    icon: const Icon(
                                      Icons.chat,
                                      color: Colors.white,
                                    ))
                                : const SizedBox(),
                            showLogout
                                ? IconButton(
                                    onPressed: () async {
                                      Get.find<UserController>().clearAll();
                                      await Auth().signOut();
                                      Get.offAndToNamed('/welcome_screen');
                                    },
                                    icon: const Icon(
                                      Icons.logout_sharp,
                                      color: kPrimaryColor,
                                    ))
                                : const SizedBox(),
                            const SizedBox(width: defaultPadding)
                          ],
                          backgroundColor: kPrimaryLightColor,
                        ),
                  backgroundColor: Colors.transparent,
                  body: child)
            ],
          ),
        ),
      ),
    );
  }
}
