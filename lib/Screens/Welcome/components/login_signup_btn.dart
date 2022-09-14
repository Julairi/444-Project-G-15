import 'package:esaa/Screens/CompanyPage/company_offers.dart';
import 'package:esaa/Screens/CompanyPage/userCompanyOffers.dart';
import 'package:esaa/Screens/companySignup/signup_screen.dart';
import 'package:esaa/Screens/forgotpass/forgotpassform.dart';
import 'package:esaa/Screens/offers%20list/OfferList.dart';
import 'package:esaa/post_job/post_job_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../Login/login_screen.dart';
import '../../signup/signup_screen.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: "login_btn",
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return companySignUpScreen();
                  },
                ),
              );
            },
            child: Text(
              "إنشاء حساب كشركة".toUpperCase(),
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SignUpScreen();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
              primary: kPrimaryLightColor, elevation: 0),
          child: Text(
            " إنشاء حساب كباحث عن عمل".toUpperCase(),
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        //tesst
        const SizedBox(height: 16),

        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
              primary: kPrimaryLightColor, elevation: 0),
          child: Text(
            "تسجيل الدخول".toUpperCase(),
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        /*ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return certianOffers();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
              primary: kPrimaryLightColor, elevation: 0),
          child: Text(
            " logon".toUpperCase(),
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),*/
      ],
    );
  }
}
