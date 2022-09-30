import 'package:esaa/config/constants.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:flutter/material.dart';

import '../intro.dart';

class CompanySignUpScreen extends StatelessWidget {
  const CompanySignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: const Background(
        child: SingleChildScrollView(
          child: Responsive(
            mobile: _MobileSignupScreen(),
            desktop: _DesktopSignupScreen(),
          ),
        ),
      ),
    );
  }
}

class _DesktopSignupScreen extends StatelessWidget {
  const _DesktopSignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
                child: CompanySignUpForm(),
              ),
              SizedBox(height: defaultPadding / 2),
              // SocalSignUp()
            ],
          ),
        )
      ],
    );
  }
}

class _MobileSignupScreen extends StatelessWidget {
  const _MobileSignupScreen({Key? key}) : super(key: key);

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
              child: CompanySignUpForm(),
            ),

            Spacer(),
          ],
        ),
      ],
    );
  }
}
