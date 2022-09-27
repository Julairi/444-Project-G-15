import 'package:esaa/Screens/stripePayment/payment_screen.dart';
import 'package:esaa/components/appbar.dart';
import 'package:esaa/constants.dart';
import 'package:esaa/post_job/post_job_form.dart';
import 'package:esaa/responsive.dart';
import 'package:flutter/material.dart';
//import 'components/signup_form.dart';
//import 'components/socal_sign_up.dart';

class postjobScreen extends StatelessWidget {
  const postjobScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return appbar(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileSignupScreen(),
          desktop: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 450,
                      child: postJob(), //change
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
  const MobileSignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: postJob(),
            ),
            Spacer(),
          ],
        ),
        // const SocalSignUp()
      ],
    );
  }
}
