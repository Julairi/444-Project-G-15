import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static String errorMessage = "";

  bool get isSignedIn {
    if (_auth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  String get uID {
    if(isSignedIn){
      return _auth.currentUser!.uid;
    }else {
      return "";
    }
  }

  void authFailed(){
    Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0
    );
  }

  Future<void> signUpWithEmail(String email, String password) async {
    try {
       await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          errorMessage = "Your email appears to be malformed";
          //print("Your address appears to be malformed.");
          break;
        case "wrong-password":
          errorMessage = "your password is wrong";
          break;
        case "user-not-found":
          errorMessage = "user with this email doesn't exist";
          break;
        case "user-disabled":
          errorMessage = "user with this email has been disabled";
          break;
        case "too-many-requests":
          if (kDebugMode) {
            print("too-many-requests");
          }
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage =
          "Signing in with this email and password isn't enabled";
          break;
        default:
          errorMessage = "An undefined error happened";
      // print("An undefined Error happened.");
      }

      errorMessage = e.toString().split('] ')[1];
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> signInWithEmail(String email, String password,{Function(FirebaseAuthException)? exceptionBuilder}) async {
    try {

      await _auth.signInWithEmailAndPassword(email: email, password: password);

    } on FirebaseAuthException catch (e) {
      if(exceptionBuilder == null) {
        errorMessage = e.toString().split('] ')[1];
        if (kDebugMode) {
          print(e.toString());
        }
      }else{
        exceptionBuilder(e);
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}