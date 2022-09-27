import 'package:esaa/Screens/stripePayment/payment.dart';
import 'package:esaa/post_job/post_job_screen.dart';
import 'package:flutter/material.dart';
import 'package:esaa/constants.dart';
import 'package:esaa/components/appbar.dart';
import 'package:esaa/responsive.dart';
import '../../components/background.dart';

class paymentScreen extends StatelessWidget {
  const paymentScreen({Key? key}) : super(key: key);

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
                      child: payment(), //change
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
