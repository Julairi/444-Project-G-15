import 'package:esaa/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppbar extends StatelessWidget {
  final Widget child;
  final String topImage, bottomImage;
  final bool showLeading;

  const CustomAppbar({
    Key? key,
    required this.child,
    this.showLeading = false,
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
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/header.jpg',
                fit: BoxFit.cover,
              ),
            ),
            leading: showLeading
                ? IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: kFillColor,
                  )
                )
                : const SizedBox(),
            backgroundColor: kPrimaryColor,
            expandedHeight: 200,
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
                appBar: AppBar(
                  leading: const SizedBox(),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                backgroundColor: Colors.transparent,
                body: child
              ),
            ],
          ),
        ),
      ),
    );
  }
}
