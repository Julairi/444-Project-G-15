import 'dart:async';
import 'dart:io';

import 'package:esaa/config/constants.dart';
import 'package:esaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatelessWidget {
  const Splash({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      if (Auth().isSignedIn) {
        Get.toNamed('/');
      } else {
        Get.toNamed('/login_screen');
      }
    });

    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                height: 150,
              ),
              const SizedBox(
                height: 50,
              ),
              const CircularProgressIndicator(
                color: kSPrimaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
