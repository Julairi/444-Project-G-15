import 'package:esaa/screens/apply/apply.dart';
import 'package:flutter/material.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/screens/intro/login/login.dart';
import 'package:esaa/screens/intro/company_sign_up/company_sign_up.dart';
import 'package:get/get.dart';

class jscombuttons extends StatelessWidget {
  const jscombuttons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          width: 290,
          child: Image.asset("assets/logo.png"),
        ),
        Hero(
          tag: "login_btn",
          child: ElevatedButton(
            onPressed: () => Get.toNamed('/company_sign_up_screen'),
            child: Text(
              "تسجيل كشركة".toUpperCase(),
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => Get.toNamed('/sign_up_screen'),
          child: Text(
            " تسجيل كباحث عن عمل".toUpperCase(),
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
