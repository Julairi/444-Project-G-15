import 'dart:math';

import 'package:esaa/Screens/Login/login_screen.dart';
import 'package:esaa/Screens/Welcome/components/login_signup_btn.dart';
import 'package:esaa/Screens/signup/sec_signup_scren.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class jslogin extends StatefulWidget {
  const jslogin({
    Key? key,
  }) : super(key: key);
  _jsloginState createState() => _jsloginState();
}

class _jsloginState extends State<jslogin> {
  final _formKey = GlobalKey<FormState>();
  final emailEditingController = new TextEditingController();
  final passEditingController = new TextEditingController();

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
          return kjobTitleNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: kFillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: kFillColor),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
        ),
        labelText: "ادخل عنوان البريد الالكتروني ",
        floatingLabelStyle: TextStyle(
          color: kTextcolor,
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
          return kjobTitleNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: kFillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: kFillColor),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
        ),
        labelText: " ادخل كلمة المرور ",
        floatingLabelStyle: TextStyle(
          color: kTextcolor,
          fontSize: 20,
        ),
      ),
    );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(padding: const EdgeInsets.all(defaultPadding)),
          SizedBox(height: defaultPadding / 2),
          emailField,
          SizedBox(height: defaultPadding / 2),
          passField,
          Padding(padding: const EdgeInsets.all(defaultPadding)),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: emailEditingController.text.trim(),
                  password: passEditingController.text.trim(),
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text('ليس هناك حساب لهذا البريد الالكتروني'),
                      );
                    },
                  );
                } else if (e.code == 'wrong-password') {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text('البريد/كلمة المرور غير صحيحة'),
                      );
                    },
                  );
                }
              }
            },
            child:
                Text("اهلا بك!".toUpperCase(), style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
