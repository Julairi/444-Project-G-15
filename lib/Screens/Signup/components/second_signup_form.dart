import 'package:esaa/Screens/Login/login_screen.dart';
import 'package:flutter/material.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';

class secondSignupScreen extends StatefulWidget {
  const secondSignupScreen({Key? key}) : super(key: key);

  @override
  State<secondSignupScreen> createState() => _secondSignupScreenState();
}

class _secondSignupScreenState extends State<secondSignupScreen> {
  @override
  final _formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();
  final FnameEditingController = new TextEditingController();
  final SnameEditingController = new TextEditingController();
  final genderEditingController = new TextEditingController();
  final nationalIdEditingController = new TextEditingController();
  final phoneEditingController = new TextEditingController();
  final experienceEditingController = new TextEditingController();
  final DOBEditingController = new TextEditingController();

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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Icon(Icons.person),
        ),
        labelText: " أدخل اسمك الأول",
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Icon(Icons.person),
        ),
        labelText: " أدخل اسمك الأخير ",
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Icon(Icons.numbers),
        ),
        labelText: "أدخل رقم الهوية /الإقامة",
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return kNationalIdNullError;
        } else if (!RegExp(r'^[+]+*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\.0/-9]$')
            .hasMatch(value!)) {
          return kInvalidNationalIdError;
        } else
          return null;
      },
    );

    final phoneField = TextFormField(
      controller: phoneEditingController,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        phoneEditingController.text = value!;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Icon(Icons.phone),
        ),
        labelText: "أدخل رقم الجوال",
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return kPhoneNumberNullError;
        } else if (!RegExp(r'^[+]+*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\.0/-9]$')
            .hasMatch(value!)) {
          return kInvalidPhoneNumber;
        } else
          return null;
      },
    );

    final experienceField = TextFormField(
      controller: DOBEditingController,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        experienceEditingController.text = value!;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Icon(Icons.content_paste_search),
        ),
        labelText: "أدخل خبراتك السابقة",
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "الرجاء كتابة خبراتك السابقة";
        } else
          return null;
      },
    );

    final DOBField = TextFormField(
      controller: DOBEditingController,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.datetime,
      textInputAction: TextInputAction.done,
      onSaved: (value) {
        DOBEditingController.text = value!.toString();
      },
      onTap: () async {
        DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100));
        if (newDate == null) return;
        setState(() {
          date = newDate;
        });
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Icon(Icons.date_range),
        ),
        labelText: "أدخل يوم ميلادك",
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return kDOBNullError;
        } else
          return null;
      },
    );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: defaultPadding / 2),
          FnameField,
          SizedBox(height: defaultPadding / 2),
          SnameField,
          Divider(),
          Row(
            children: [
              Text(
                "اختر جنسك",
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: defaultFontSize),
              ),
              Expanded(
                child: RadioListTile(
                  //tileColor: kPrimaryLightColor,
                  activeColor: kPrimaryColor,
                  title: Text("ذكر"),
                  value: "ذكر",
                  groupValue: genderEditingController.text,
                  onChanged: (value) {
                    setState(() {
                      genderEditingController.text = value.toString();
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  activeColor: kPrimaryColor,
                  //tileColor: kPrimaryLightColor,
                  title: Text("أنثى "),
                  value: "أنثى ",
                  groupValue: genderEditingController.text,
                  onChanged: (value) {
                    setState(() {
                      genderEditingController.text = value.toString();
                    });
                  },
                ),
              ),
            ],
          ),
          Divider(),
          SizedBox(height: defaultPadding / 2),
          nationalIdField,
          SizedBox(height: defaultPadding / 2),
          phoneField,
          SizedBox(height: defaultPadding / 2),
          experienceField,
          SizedBox(height: defaultPadding / 2),
          DOBField,
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
}
