import 'package:esaa/config/constants.dart';
import 'package:esaa/screens/intro/sign_up/jsandcomscreen.dart';
import 'package:esaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final emailEditingController = TextEditingController();
  final passEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      cursorColor: kPrimaryColor,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => emailEditingController.text = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return kEmailNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: kFillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: kFillColor),
        ),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Icon(Icons.email),
        ),
        labelText: "ادخل عنوان البريد الالكتروني ",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
    );

    final passField = TextFormField(
      controller: passEditingController,
      keyboardType: TextInputType.visiblePassword,
      cursorColor: kPrimaryColor,
      obscureText: true,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => passEditingController.text = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return kPassNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: kFillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: kFillColor),
        ),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Icon(Icons.vpn_key),
        ),
        labelText: " ادخل كلمة المرور ",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
    );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: 290,
            child: Image.asset("assets/logo.png"),
          ),
          const Padding(padding: EdgeInsets.all(defaultPadding)),
          const SizedBox(height: defaultPadding / 2),
          emailField,
          const SizedBox(height: defaultPadding / 2),
          passField,
          const Padding(padding: EdgeInsets.all(defaultPadding)),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () =>
                login(emailEditingController.text, passEditingController.text),
            child: Text("تسجيل الدخول".toUpperCase(),
                style: const TextStyle(fontSize: 16)),
          ),
          GestureDetector(
            onTap: () => Get.toNamed('/forgot_password'),
            child: Column(
              children: const [
                Padding(padding: EdgeInsets.all(defaultPadding)),
                SizedBox(height: defaultPadding / 4),
                Text(
                  'نسيت كلمة المرور',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const jscomsignup();
                  },
                ),
              );
            },
            child: Column(
              children: const [
                Padding(padding: EdgeInsets.all(defaultPadding)),
                SizedBox(height: defaultPadding / 4),
                Text(
                  'لا تمتلك حساب؟ تسجيل حساب جديد',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget okButton =
      TextButton(child: const Text('الغاء'), onPressed: () => Get.back());

  void login(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await Auth().signInWithEmail(email, password,
          exceptionBuilder: (FirebaseAuthException e) {
        if (e.code == 'user-not-found') {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: const Text('ليس هناك حساب لهذا البريد الالكتروني'),
                actions: [okButton],
              );
            },
          );
        } else if (e.code == 'wrong-password') {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: const Text('البريد الالكتروني/كلمة المرور غير صحيحة'),
                actions: [okButton],
              );
            },
          );
        }
      });

      if (Auth().isSignedIn) {
        Get.offAllNamed('/');
      }
    }
  }
}
