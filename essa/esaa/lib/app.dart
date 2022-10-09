import 'package:esaa/screens/default.dart';
import 'package:esaa/screens/job_seeker_home/job_seeker_profile/job_seeker_profile_forC.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:overlay_support/overlay_support.dart';

import 'config/constants.dart';
import 'controllers/controllers.dart';
import 'models/models.dart';
import 'screens/intro/intro.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key) {
    Get.put(UserController());
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: GetMaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar', 'AE'), // English, no country code
          Locale('en', ''),
        ],
        title: 'es3a',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: kPrimaryColor,
                shape: const StadiumBorder(),
                maximumSize: const Size(double.infinity, 56),
                minimumSize: const Size(double.infinity, 56),
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: kPrimaryLightColor,
              iconColor: kPrimaryColor,
              prefixIconColor: kPrimaryColor,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide.none,
              ),
            )),
        getPages: [
          GetPage(name: '/splash', page: () => const Splash()),
          GetPage(name: '/welcome_screen', page: () => const WelcomeScreen()),
          GetPage(
              name: '/company_sign_up_screen',
              page: () => const CompanySignUpScreen()),
          GetPage(name: '/sign_up_screen', page: () => const SignUpScreen()),
          GetPage(name: '/login_screen', page: () => const LoginScreen()),
          GetPage(
              name: '/forgot_password',
              page: () => const ForgotPasswordScreen()),
          GetPage(name: '/', page: () => Default()),
          GetPage(
              name: '/job_seeker_profile_forC', page: () => jcProfilePage()),
        ],
        initialRoute: '/splash',
      ),
    );
  }

  static User get user => Get.find<UserController>().user.value;
}
