import 'package:esaa/config/constants.dart';
import 'package:esaa/screens/stripePayment/cardFormScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shared/shared.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Responsive(
            desktop: _DesktopWelcomeScreen(),
            mobile: _MobileWelcomeScreen(),
          ),
        ),
      ),
    );
  }
}

class _DesktopWelcomeScreen extends StatelessWidget {
  const _DesktopWelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // const Expanded(
        // child: WelcomeImage(),
        // ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(
                width: 450,
                child: LoginAndSignupBtn(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MobileWelcomeScreen extends StatelessWidget {
  const _MobileWelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //const WelcomeImage(),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: LoginAndSignupBtn(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: "login_btn",
          child: ElevatedButton(
            onPressed: () => Get.toNamed('/company_sign_up_screen'),
            child: Text(
              "تسجيل كشركة".toUpperCase(),
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),

        const SizedBox(height: 16),

        ElevatedButton(
          onPressed: () => Get.toNamed('/sign_up_screen'),
          style: ElevatedButton.styleFrom(
              primary: kPrimaryLightColor, elevation: 0),
          child: Text(
            " تسجيل كباحث عن عمل".toUpperCase(),
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        //test
        const SizedBox(height: 16),

        ElevatedButton(
          onPressed: () => Get.toNamed('/login_screen'),
          style: ElevatedButton.styleFrom(
              primary: kPrimaryLightColor, elevation: 0),
          child: Text(
            "تسجيل الدخول".toUpperCase(),
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),

        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return CardFormScreen();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
              primary: kPrimaryLightColor, elevation: 0),
          child: Text(
            "payment".toUpperCase(),
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
