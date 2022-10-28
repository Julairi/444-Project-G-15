import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/screens/notifications/notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppbar extends StatelessWidget {
  final Widget? title;
  final Widget child;
  final String topImage, bottomImage;
  final bool showLeading;
  final bool showNotification;
  //final bool logout;

  const CustomAppbar({
    Key? key,
    this.title,
    required this.child,
    this.showLeading = false,
    this.showNotification = false,
    //this.logout = false,
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
              const SizedBox(width: defaultPadding)
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
