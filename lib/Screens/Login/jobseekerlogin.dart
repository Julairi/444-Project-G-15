import 'dart:math';

import 'package:esaa/Screens/Login/login_screen.dart';
import 'package:esaa/Screens/Welcome/components/login_signup_btn.dart';
import 'package:esaa/Screens/forgotpass/forgotpasscreen.dart';
import 'package:esaa/Screens/forgotpass/forgotpassform.dart';
import 'package:esaa/Screens/signup/sec_signup_scren.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../navbar.dart';

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
          child: Icon(Icons.email),
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
          child: Icon(Icons.vpn_key),
        ),
        labelText: " ادخل كلمة المرور ",
        floatingLabelStyle: TextStyle(
          color: kTextcolor,
          fontSize: 20,
        ),
      ),
    );

    //final User? user = FirebaseAuth.instance.currentUser;
    //final role= user?.role;

    //final _fireStore = FirebaseFirestore.instance;
    //final users= _fireStore.collection('company').snapshots();
    // final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('company').snapshots();

    //final posts = snapshot.data!.docs;
    //posts.get('role');

    //return FutureBuilder<DocumentSnapshot>(
    // final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('company').snapshots();

    //future: users.doc(documentId).get(),
    //builder:
    //  (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

    // if (snapshot.hasError) {
    // return Text("Something went wrong");
    //}

    /*  if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text("Full Name: ${data['full_name']} ${data['last_name']}");
        }

        return Text("loading");
     },*/
    //);
/*
    FirebaseFirestore.instance
        .collection('company')
        .where('role', arrayContains: 'company')
        .get();
*/
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: 290,
            child: Image.asset("assets/logoo.png"),
          ),
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
                  //final User?
                );
                //////////
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return navbar();
                    },
                  ),
                );
                //////
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
                        content:
                            Text('البريد الالكتروني/كلمة المرور غير صحيحة'),
                      );
                    },
                  );
                }
              }
            },
            child: Text("تسجيل الدخول".toUpperCase(),
                style: TextStyle(fontSize: 16)),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ForgotPass();
                  },
                ),
              );
            },
            child: Column(
              children: [
                Padding(padding: const EdgeInsets.all(defaultPadding)),
                SizedBox(height: defaultPadding / 4),
                Text(
                  'نسيت كلمة المرور',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
