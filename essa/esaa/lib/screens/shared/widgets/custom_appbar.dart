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
  final void Function()? onChatPressed;

  final String topImage, bottomImage;
  final bool showLeading, showChat, collapsable;
  final bool showNotification;
  final bool logout;

  const CustomAppbar({
    Key? key,
    this.title,
    required this.child,
    this.showLeading = false,
    this.showChat = false,
    this.collapsable = false,
    this.onChatPressed,
    this.showNotification = false,
    this.logout = false,
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
              const SizedBox(width: defaultPadding),
              showChat
                  ? IconButton(
                      onPressed: onChatPressed ?? () {},
                      icon: const Icon(
                        Icons.chat,
                        color: Colors.white,
                      ))
                  : const SizedBox(),
              const SizedBox(width: defaultPadding),
              logout
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
            ],
            backgroundColor: Colors.transparent,
            expandedHeight: 80,
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
            children: <Widget>[child],
          ),
        ),
      ),
    );
  }
}
