import 'dart:developer';

import 'package:esaa/Screens/CompanyPage/company_offers.dart';
import 'package:esaa/Screens/Login/login_screen.dart';
import 'package:esaa/Screens/Welcome/components/login_signup_btn.dart';
import 'package:esaa/Screens/signup/sec_signup_scren.dart';
import 'package:esaa/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class apply extends StatefulWidget {
  final String uid;
  const apply({
    Key? key,
    required this.uid,
  }) : super(key: key);
  _applystate createState() => _applystate();
}

class _applystate extends State<apply> {
  final _formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();
  final infoEditingController = new TextEditingController();
  final descripEditingController = new TextEditingController();
  final englishlevelEditingController = new TextEditingController();

  FocusNode myFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    final titleField = TextFormField(
      controller: infoEditingController,
      keyboardType: TextInputType.name,
      cursorColor: kPrimaryColor,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => infoEditingController.text = newValue!,
      validator: (value) {
        if (value!.isEmpty) {}
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
        labelText: "ادخل المهارات الاضافية ان وجدت",
        floatingLabelStyle: TextStyle(
          color: kTextcolor,
          fontSize: 20,
        ),
      ),
    );

    final descripField = TextFormField(
      controller: descripEditingController,
      onSaved: (newValue) => descripEditingController.text = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return kNullError;
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      cursorColor: kPrimaryColor,
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
        labelText: "أدخل نبذة تعريفية عنك ",
        floatingLabelStyle: TextStyle(
          color: kTextcolor,
          fontSize: 20,
        ),
      ),
      maxLines: 100,
      minLines: 5,
    );

//88888888888888888888888

//88888888888888

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.all(defaultPadding)),
            SizedBox(height: defaultPadding / 2),
            titleField,
            SizedBox(height: defaultPadding / 2),
            descripField,
            SizedBox(height: defaultPadding / 2),
            Padding(padding: const EdgeInsets.all(defaultPadding)),
            const SizedBox(height: defaultPadding / 2),

            // btn *****************
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // add new post
                  User? currentUser = await FirebaseAuth.instance.currentUser;
                  /*
                  var cName = await FirebaseFirestore.instance
                      .collection('company')
                      .doc("HtgizLsb0tWt3JxlpXCxsc4Nz623")
                      .get()
                      .then((value) {
                    return value
                        .data()!['Name']; // Access your after your get the data
                  });*/
                  FirebaseFirestore.instance
                      .collection('posts')
                      .doc('currentUsers.uid')
                      .update({
                    'orderstatus': 'pending',
                  });

                  FirebaseFirestore.instance.collection('orders').add({
                    'skills': infoEditingController.text,
                    'summary': descripEditingController.text,
                    'user': '/jobseeker/' + currentUser!.uid,
                    'post': '/posts/' + widget.uid,
                  });

                  log('post done ');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return navbar();
                      },
                    ),
                  ); //push
                } //end if
              },
              child:
                  Text("ارسال".toUpperCase(), style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: defaultPadding),
          ],
        ),
      ),
    );
  }
}
