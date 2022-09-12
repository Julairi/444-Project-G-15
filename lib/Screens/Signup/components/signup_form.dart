import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaa/Screens/Login/login_screen.dart';
import 'package:esaa/Screens/signup/sec_signup_scren.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../../model/user_model.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final nationalIdEditingController = new TextEditingController();

  final nameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final FnameEditingController = new TextEditingController();
  final SnameEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final FnameField = TextFormField(
      controller: FnameEditingController,
      keyboardType: TextInputType.name,
      cursorColor: kPrimaryColor,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        FnameEditingController.text = value!;
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
          child: Icon(Icons.person),
        ),
        labelText: " أدخل اسمك الأول",
        floatingLabelStyle: TextStyle(
          color: kTextcolor,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return kFNamelNullError;
        } else
          return null;
      },
    );

    final SnameField = TextFormField(
      controller: SnameEditingController,
      keyboardType: TextInputType.name,
      cursorColor: kPrimaryColor,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        SnameEditingController.text = value!;
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
          child: Icon(Icons.person),
        ),
        labelText: " أدخل اسمك الأخير ",
        floatingLabelStyle: TextStyle(
          color: kTextcolor,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return kSNamelNullError;
        } else
          return null;
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
          borderSide: BorderSide(color: kFillColor),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Icon(Icons.numbers),
        ),
        labelText: "أدخل رقم الهوية /الإقامة",
        floatingLabelStyle: TextStyle(
          color: kTextcolor,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return kNationalIdNullError;
        } //else if (!RegExp(r'^[+]+*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\.0/-9]$')
        //.hasMatch(value!)) {
        //return kInvalidNationalIdError;
        // }
        else
          return null;
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
          borderSide: BorderSide(color: kFillColor),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Icon(Icons.email),
        ),
        labelText: "أدخل بريدك الإلكتروني ",
        floatingLabelStyle: TextStyle(
          color: kTextcolor,
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
          borderSide: BorderSide(color: kFillColor),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Icon(Icons.vpn_key),
        ),
        labelText: "أدخل كلمة المرور  ",
        floatingLabelStyle: TextStyle(
          color: kTextcolor,
          fontSize: 20,
        ),
      ),
    );

    final confPasswordField = TextFormField(
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
          borderSide: BorderSide(color: kFillColor),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Icon(Icons.vpn_key),
        ),
        hintText: "أعد كتابة كلمة المرور",
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
          SizedBox(
            height: 200,
            width: 290,
            child: Image.asset("assets/logoo.png"),
          ),
          SizedBox(height: defaultPadding / 2),
          FnameField,
          SizedBox(height: defaultPadding / 2),
          SnameField,
          SizedBox(height: defaultPadding / 2),
          nationalIdField,
          SizedBox(height: defaultPadding / 2),
          emailField,
          SizedBox(height: defaultPadding / 2),
          passwordField,
          SizedBox(height: defaultPadding / 2),
          confPasswordField,
          Padding(padding: const EdgeInsets.all(defaultPadding)),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () {
              signUp(
                  emailEditingController.text, passwordEditingController.text);

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
                style: TextStyle(fontSize: 16)),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          //FlutterToast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            print("Yaddress appears to be malformed.");
            break;
            print("wrong-password");
            // errorMessage = "Your password is wrong.";
            break;
            print("user-not-found");
            // errorMessage = "User with this email doesn't exist.";
            break;
            print("user-disabled");
            // errorMessage = "User with this email has been disabled.";
            break;
            print("too-many-requests");
            // errorMessage = "Too many requests";
            break;
            print(
                "operation-not-allowed"); //  errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            print("An undefined Error happened.");
        }
        // Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;

    userModel.uid = user.uid;
    userModel.firstName = FnameEditingController.text;
    userModel.secondName = SnameEditingController.text;
    userModel.nationalId = nationalIdEditingController.text;

    await firebaseFirestore
        .collection("jobseekers")
        .doc(user.uid)
        .set(userModel.toMap());
    //Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false);
  }
}
