import 'package:flutter/material.dart';
import 'package:esaa/Screens/forgotpass/forgotpassform.dart';
import '../../components/background.dart';
import '../../constants.dart';
import '../../responsive.dart';

class ForgotPass extends StatelessWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const ForgotPassScreen(),
          desktop: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 450,
                      child: forgotpass(), //change
                    ),
                    SizedBox(height: defaultPadding / 2),
                    // SocalSignUp()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassScreen extends StatelessWidget {
  const ForgotPassScreen({
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
            Spacer(),
          ],
        ),
      ],
    );
  }
}
