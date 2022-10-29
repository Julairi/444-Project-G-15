import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/screens/notifications/notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppbar extends StatelessWidget {
  final Widget? title;
  final Widget child;
  final String topImage, bottomImage;
  final bool showLeading, showNotification, showChat, collapsable;
  final void Function()? onChatPressed;

  const CustomAppbar({
    Key? key,
    this.title,
    required this.child,
    this.onChatPressed,
    this.showChat = false,
    this.showLeading = false,
    this.showNotification = false,
    this.collapsable = true,
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
          if(collapsable)
            SliverAppBar(
            title: title,
            flexibleSpace: const FlexibleSpaceBar(),
            leading: showLeading
                ? IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: kFillColor,
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
              const SizedBox(width: defaultPadding)
            ],
            backgroundColor: kPrimaryColor,
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
            children: <Widget>[
              /* Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                topImage,
                width: 120,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(bottomImage, width: 120),
            ), */
              Scaffold(
                appBar: collapsable ? null : AppBar(
                  title: title,
                  flexibleSpace: const FlexibleSpaceBar(),
                  leading: showLeading
                      ? IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: kFillColor,
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
                    const SizedBox(width: defaultPadding)
                  ],
                  backgroundColor: kPrimaryColor,
                ),
                backgroundColor: Colors.transparent,
                  body: child
              )
            ],
          ),
        ),
      ),
    );
  }
}
