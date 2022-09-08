import 'package:esaa/Screens/Login/login_screen.dart';
import 'package:esaa/Screens/signup/sec_signup_scren.dart';
import 'package:flutter/material.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';

class companySignupForm extends StatefulWidget {
  const companySignupForm({
    Key? key,
  }) : super(key: key);
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<companySignupForm> {
  final _formKey = GlobalKey<FormState>();
  final nameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confPasswordEditingController = new TextEditingController();
  final AdressEditingController = new TextEditingController();
  final ContactEditingController = new TextEditingController();
  final DescrioptionEditingController = new TextEditingController();

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
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          return kInvalidEmailError;
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Icon(Icons.email),
        ),
        labelText: "أدخل البريد الإلكتروني ",
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Icon(Icons.vpn_key),
        ),
        labelText: "أدخل كلمة المرور  ",
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
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Icon(Icons.streetview),
        ),
        hintText: "أعد كتابة كلمة المرور",
      ),
    );
    final AdressField = TextFormField(
      controller: AdressEditingController,
      keyboardType: TextInputType.streetAddress,
      cursorColor: kPrimaryColor,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => AdressEditingController.text = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return kEmailNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Icon(Icons.pin_drop),
        ),
        labelText: "أدخل عنوان الشركة ",
      ),
    );
    final ContactinfoField = TextFormField(
      controller: ContactEditingController,
      keyboardType: TextInputType.text,
      cursorColor: kPrimaryColor,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => ContactEditingController.text = newValue!, /////
      validator: (value) {
        if (value!.isEmpty) {
          return kEmailNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Icon(Icons.contacts),
        ),
        labelText: "طريقة تواصل للشركة",
      ),
    );
    final DescriptionField = TextFormField(
      controller: DescrioptionEditingController,
      keyboardType: TextInputType.text,
      cursorColor: kPrimaryColor,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => DescrioptionEditingController.text = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return kEmailNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Icon(Icons.brush),
        ),
        labelText: "اضف وصف مختصر عن الشركة",
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
          Padding(padding: const EdgeInsets.all(defaultPadding)),
          SizedBox(height: defaultPadding / 2),
          emailField,
          SizedBox(height: defaultPadding / 2),
          passwordField,
          SizedBox(height: defaultPadding / 2),
          confPasswordField,
          SizedBox(height: defaultPadding / 2),
          AdressField,
          SizedBox(height: defaultPadding / 2),
          ContactinfoField,
          SizedBox(height: defaultPadding / 2),
          DescriptionField,
          Padding(padding: const EdgeInsets.all(defaultPadding)),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              }
            },
            child: Text("انشاء حساب".toUpperCase(),
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
}
