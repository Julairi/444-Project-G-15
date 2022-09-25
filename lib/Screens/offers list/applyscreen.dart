import 'package:esaa/Screens/offers%20list/applyForm.dart';
import 'package:esaa/components/appbar.dart';
import 'package:esaa/constants.dart';
import 'package:esaa/post_job/post_job_form.dart';
import 'package:esaa/responsive.dart';
import 'package:flutter/material.dart';

import '../../components/background.dart';
//import 'components/signup_form.dart';
//import 'components/socal_sign_up.dart';
import 'package:firebase_core/firebase_core.dart';

class applyScreen extends StatelessWidget {
  final String UID;
  const applyScreen({
    Key? key,
    required this.UID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return appbar(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileSignupScreen(
            UID: UID,
          ),
          desktop: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: apply(uid: UID), //change
                    ),
                    SizedBox(height: defaultPadding / 2),
                    // SocalSignUp()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MobileSignupScreen extends StatelessWidget {
  final String UID;
  const MobileSignupScreen({
    Key? key,
    required this.UID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: apply(
                uid: UID,
              ),
            ),
            Spacer(),
          ],
        ),
        // const SocalSignUp()
      ],
    );
  }
}
