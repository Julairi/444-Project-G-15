import 'package:esaa/config/constants.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/intro/intro.dart';
import 'package:esaa/services/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  SignUpFormState createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final nameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final nationalIdEditingController = TextEditingController();
  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confPasswordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final firstNameField = TextFormField(
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      cursorColor: kPrimaryColor,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        firstNameEditingController.text = value!;
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
          child: Icon(Icons.person),
        ),
        labelText: " أدخل اسمك الأول",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return kFirstNameNullError;
        } else {
          return null;
        }
      },
    );

    final secondNameField = TextFormField(
      controller: secondNameEditingController,
      keyboardType: TextInputType.name,
      cursorColor: kPrimaryColor,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        secondNameEditingController.text = value!;
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
          child: Icon(Icons.person),
        ),
        labelText: " أدخل اسمك الأخير ",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return kSecondNameNullError;
        } else {
          return null;
        }
      },
    );

    final nationalIdField = TextFormField(
      controller: nationalIdEditingController,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        nationalIdEditingController.text = value!;
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
          child: Icon(Icons.numbers),
        ),
        labelText: "أدخل رقم الهوية /الإقامة",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return kNationalIdNullError;
        } else if (value.length != 10) {
          return kInvalidNationalIdError;
        } else {
          return null;
        }
      },
    );

    final emailField = TextFormField(
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      cursorColor: kPrimaryColor,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => emailEditingController.text = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return kEmailNullError;
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          return kInvalidEmailError;
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
        labelText: "أدخل بريدك الإلكتروني ",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
    );

    final passwordField = TextFormField(
      controller: passwordEditingController,
      obscureText: true,
      onSaved: (newValue) => passwordEditingController.text = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return kPassNullError;
        } else if (value.length < 8) {
          return kShortPassError;
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
          borderSide: const BorderSide(color: kFillColor),
        ),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Icon(Icons.vpn_key),
        ),
        labelText: "أدخل كلمة المرور  ",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
    );

    final confirmPasswordField = TextFormField(
      controller: confPasswordEditingController,
      cursorColor: kPrimaryColor,
      obscureText: true,
      onSaved: (newValue) => confPasswordEditingController.text = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return kPassNullError;
        } else if ((passwordEditingController.text != value)) {
          return kMatchPassError;
        }
        return null;
      },
      textInputAction: TextInputAction.done,
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
        hintText: "أعد كتابة كلمة المرور",
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

          const SizedBox(height: defaultPadding / 2),

          firstNameField,

          const SizedBox(height: defaultPadding / 2),

          secondNameField,

          const SizedBox(height: defaultPadding / 2),

          nationalIdField,

          const SizedBox(height: defaultPadding / 2),

          emailField,

          const SizedBox(height: defaultPadding / 2),

          passwordField,

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [Text("* يجب ان تحتوي كلمة المرور على ٨ حروف على الاقل")],
          ),

          const SizedBox(height: defaultPadding / 2),

          confirmPasswordField,

          const Padding(padding: EdgeInsets.all(defaultPadding)),

          const SizedBox(height: defaultPadding / 2),

          ElevatedButton(
            onPressed: () {
              signUp(emailEditingController.text, passwordEditingController.text);

              /* Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return secSignUpScreen();
                    },
                  ),
                );*/
            },
            child: Text("إنشاء حساب".toUpperCase(),
                style: const TextStyle(fontSize: 16)),
          ),
          const SizedBox(height: defaultPadding),

          AlreadyHasAnAccount(
            login: false,
            press: () => Get.toNamed('login')
          ),
        ],
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await Auth().signUpWithEmail(email, password);

      if (Auth().isSignedIn) {
        await _createJobSeeker(Auth().uID);
        Get.offAllNamed('/');

      } else {
        Auth().authFailed();

        //showSnackBar(error.toString(), context);

      }
    }
  }

  Future<void> _createJobSeeker(String uID) async {

    User jobSeeker = User.empty();

    jobSeeker.id = uID;
    jobSeeker.name = "${firstNameEditingController.text} ${secondNameEditingController.text}";
    jobSeeker.nationalID = nationalIdEditingController.text;
    jobSeeker.email = emailEditingController.text;
    jobSeeker.userType = "jobSeeker";
    jobSeeker.sex = "Female"; //todo get properly

    await UserDatabase(uID).createUser(jobSeeker.toMap());
  }
}
