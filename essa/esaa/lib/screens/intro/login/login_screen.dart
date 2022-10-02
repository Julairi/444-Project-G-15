import 'package:esaa/config/constants.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:flutter/material.dart';

import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TransparentAppbar(
      child: SingleChildScrollView(
        child: Responsive(
            mobile: _MobileLoginScreen(), desktop: _DesktopLoginScreen()),
      ),
    );
  }
}

class _DesktopLoginScreen extends StatelessWidget {
  const _DesktopLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(
                width: 450,
                child: LoginForm(),
              ),
              SizedBox(height: defaultPadding / 2),
            ],
          ),
        )
      ],
    );
  }
}

class _MobileLoginScreen extends StatelessWidget {
  const _MobileLoginScreen({
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
              child: LoginForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
