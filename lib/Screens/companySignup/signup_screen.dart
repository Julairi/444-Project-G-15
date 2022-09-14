import 'package:esaa/Screens/Signup/components/sign_up_top_image.dart';
import 'package:esaa/Screens/Signup/components/signup_form.dart';
import 'package:esaa/Screens/companySignup/signup_form.dart';
import 'package:esaa/components/appbar.dart';
import 'package:esaa/components/transparentappbar.dart';
import 'package:esaa/constants.dart';
import 'package:esaa/responsive.dart';
import 'package:flutter/material.dart';

import '../../components/background.dart';

class companySignUpScreen extends StatelessWidget {
  const companySignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transparentappbar(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileSignupScreen(),
          desktop: Row(
            children: [
              const Expanded(
                child: SignUpScreenTopImage(),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 450,
                      child: companySignupForm(),
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
        const SignUpScreenTopImage(),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: companySignupForm(),
            ),
            Spacer(),
          ],
        ),
        // const SocalSignUp()
      ],
    );
  }
}
