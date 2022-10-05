import 'package:esaa/config/constants.dart';
import 'package:esaa/screens/intro/intro.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TransparentAppbar(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: _MobileSignupScreen(),
          desktop: _DesktopSignupScreen()
        ),
      ),
    );
  }
}

class _DesktopSignupScreen extends StatelessWidget {
  const _DesktopSignupScreen ({
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
                child: SignUpForm(),
              ),
              SizedBox(height: defaultPadding / 2),
            ],
          ),
        )
      ],
    );
  }
}

class _MobileSignupScreen extends StatelessWidget {
  const _MobileSignupScreen({
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
              child: SignUpForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
