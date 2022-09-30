import 'package:esaa/config/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({
    Key? key,
  }) : super(key: key);

  @override
  ForgotPasswordFormState createState() => ForgotPasswordFormState();
}

class ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final emailEditingController = TextEditingController();

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
        ),
        labelText: "ادخل عنوان البريد الالكتروني ",
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

          const Padding(padding: EdgeInsets.all(defaultPadding)),

          const SizedBox(height: defaultPadding / 2),

          ElevatedButton(
            onPressed: () => sendPasswordReset(emailEditingController.text),
            child: Text("ارسال".toUpperCase(), style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget okButton = TextButton(
    child: const Text('الغاء'),
    onPressed: () => Get.back(),
  );

  void sendPasswordReset(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailEditingController.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text(
                'تم إرسال رابط إعادة تعيين المرور على البريد الالكتروني المدخل'),
            actions: [okButton],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
