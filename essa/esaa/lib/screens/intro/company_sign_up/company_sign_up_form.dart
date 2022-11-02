import 'dart:typed_data';
import 'package:esaa/config/constants.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/intro/intro.dart';
import 'package:esaa/services/services.dart';
import 'package:esaa/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CompanySignUpForm extends StatefulWidget {
  const CompanySignUpForm({Key? key}) : super(key: key);

  @override
  CompanySignUpFormState createState() => CompanySignUpFormState();
}

class CompanySignUpFormState extends State<CompanySignUpForm> {
  final _formKey = GlobalKey<FormState>();
  //bool isButtonDisable= true;

  final nameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confPasswordEditingController = TextEditingController();
  final addressEditingController = TextEditingController();
  final contactEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();

  Uint8List? _image;

  void selectImage() async {
    final pickedFile = await pickImage(ImageSource.gallery);

    if (pickedFile != null) {
      Uint8List image = await pickImage(ImageSource.gallery);

      setState(() {
        _image = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      controller: nameEditingController,
      keyboardType: TextInputType.name,
      cursorColor: kPrimaryColor,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => emailEditingController.text = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return 'الرجاء ادخال اسم الشركة^';
        }
        //else if (!emailValidatorRegExp.hasMatch(value)) {
        //return kInvalidEmailError;
        // }
        return null;
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: kFillColor),
        ),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Icon(Icons.person_add),
        ),
        labelText: " أدخل اسم الشركة",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
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
        labelText: "أدخل البريد الإلكتروني ",
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
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        fillColor: kFillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: kFillColor),
        ),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Icon(Icons.streetview),
        ),
        hintText: "أعد كتابة كلمة المرور",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
    );

    final addressField = TextFormField(
      controller: addressEditingController,
      keyboardType: TextInputType.streetAddress,
      cursorColor: kPrimaryColor,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => addressEditingController.text = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return ' لرجاء اضافة  عنوان  الشركة';
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
          child: Icon(Icons.pin_drop),
        ),
        labelText: "أدخل عنوان الشركة ",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
    );

    final contactInfoField = TextFormField(
      controller: contactEditingController,
      keyboardType: TextInputType.number,
      cursorColor: kPrimaryColor,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => contactEditingController.text = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return ' لرجاء اضافة طريقة تواصل مع الشركة';
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
        prefix: const Text(
          '05',
          style: TextStyle(
            color: Colors.black,
            fontSize: defaultFontSize,
          ),
        ),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Icon(Icons.contacts),
        ),
        labelText: "طريقة تواصل للشركة",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
        counterText: "",
      ),
      maxLength: 8,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))],
    );

    final descriptionField = TextFormField(
      controller: descriptionEditingController,
      keyboardType: TextInputType.text,
      cursorColor: kPrimaryColor,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => descriptionEditingController.text = newValue!,
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
          child: Icon(Icons.brush),
        ),
        labelText: "اضف وصف مختصر عن الشركة",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
    );

    return SafeArea(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _image != null
                  ? CircleAvatar(
                      radius: 70, backgroundImage: MemoryImage(_image!))
                  : GestureDetector(
                      onTap: selectImage,
                      child: SizedBox(
                        height: 200,
                        width: 290,
                        child: Image.asset("assets/logo.png"),
                      ),
                    ),
              const Padding(padding: EdgeInsets.all(defaultPadding)),
              const SizedBox(height: defaultPadding / 2),
              nameField,
              const SizedBox(height: defaultPadding / 2),
              emailField,
              const SizedBox(height: defaultPadding / 2),
              passwordField,
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text("* يجب ان تحتوي كلمة المرور على ٨ حروف على الاقل")
                ],
              ),
              const SizedBox(height: defaultPadding / 2),
              confirmPasswordField,
              const SizedBox(height: defaultPadding / 2),
              addressField,
              const SizedBox(height: defaultPadding / 2),
              contactInfoField,
              const SizedBox(height: defaultPadding / 2),
              descriptionField,
              const Padding(padding: EdgeInsets.all(defaultPadding)),
              const SizedBox(height: defaultPadding / 2),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: _image == null
                        ? Colors.grey.withOpacity(0.4)
                        : kPrimaryColor),
                onPressed: () {
                  if (_image == null) {
                    Fluttertoast.showToast(
                        msg: "Please select an image fisrt",
                        backgroundColor: Colors.redAccent,
                        textColor: kFillColor);
                  } else {
                    signUp(emailEditingController.text,
                        passwordEditingController.text);
                  }
                  /* Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return secSignUpScreen();
                    },
                  ),
                );*/
                },
                child: Text("انشاء حساب".toUpperCase(),
                    style: const TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: defaultPadding),
              AlreadyHasAnAccount(
                login: false,
                press: () => Get.toNamed('/login_screen'),
              ),
              const SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await Auth().signUpWithEmail(email, password);

      if (Auth().isSignedIn) {
        await _createCompany(Auth().uID);

        Fluttertoast.showToast(msg: "تم إنشاء حسابك بنجاح ");

        Get.offAllNamed('/');
      } else {
        Auth().authFailed();

        //showSnackBar(error.toString(), context);

      }
    }
  }

  Future<void> _createCompany(String uID) async {
    String imgUrl = "";
    if (_image != null) {
      imgUrl = await Storage().uploadImageToString("companyLogo ", _image!);
    }

    User company = User.empty();

    company.email = emailEditingController.text;
    company.imgUrl = imgUrl;
    company.id = uID;
    company.name = nameEditingController.text;
    company.address = addressEditingController.text;
    company.contact = "05${contactEditingController.text}";
    company.description = descriptionEditingController.text;
    company.userType = "company";

    await UserDatabase(uID).createUser(company.toMap());
  }
}
