import 'dart:async';
import 'dart:math';

import 'package:esaa/Screens/Login/login_screen.dart';
import 'package:esaa/Screens/Welcome/components/login_signup_btn.dart';
import 'package:esaa/Screens/Welcome/components/welcome_screen.dart';
import 'package:esaa/Screens/forgotpass/forgotpasscreen.dart';
import 'package:esaa/Screens/forgotpass/forgotpassform.dart';
import 'package:esaa/Screens/signup/sec_signup_scren.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class splash extends StatefulWidget {
  const splash({
    Key? key,
  }) : super(key: key);
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), navigateToSecondPage);
  }

  void navigateToSecondPage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
        (Route<dynamic> route) => false);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logoo.png',
              height: 150,
            ),
            const SizedBox(
              height: 50,
            ),
            CircularProgressIndicator(
              color: kSPrimaryColor,
            )
          ],
        ),
      ),
    );
  }
}
