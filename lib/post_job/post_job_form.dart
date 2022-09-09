import 'package:esaa/Screens/Login/login_screen.dart';
import 'package:esaa/Screens/Welcome/components/login_signup_btn.dart';
import 'package:esaa/Screens/signup/sec_signup_scren.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';

class postJob extends StatefulWidget {
  const postJob({
    Key? key,
  }) : super(key: key);
  _postJobFormState createState() => _postJobFormState();
}

class _postJobFormState extends State<postJob> {
  final _formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();
  final titleEditingController = new TextEditingController();
  final descripEditingController = new TextEditingController();
  final locationEditingController = new TextEditingController();
  final dateEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final titleField = TextFormField(
      controller: titleEditingController,
      keyboardType: TextInputType.name,
      cursorColor: kPrimaryColor,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => titleEditingController.text = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return kjobTitleNullError;
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
        ),
        labelText: " ادخل عنوان الاعلان الوظيفي",
      ),
    );

    final descripField = TextFormField(
      controller: descripEditingController,
      onSaved: (newValue) => descripEditingController.text = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return kdescNullError;
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
        ),
        labelText: "أدخل وصف الوظيفه  ",
      ),
      maxLines: 100,
      minLines: 5,
    );

    final locField = TextFormField(
      controller: locationEditingController,
      cursorColor: kPrimaryColor,
      onSaved: (newValue) => locationEditingController.text = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return klocNullError;
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
        ),
        hintText: " ادخل موقع الوظيفه",
      ),
    );
    final startDate = TextFormField(
      controller: dateEditingController,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.datetime,
      textInputAction: TextInputAction.done,
      onSaved: (value) {
        dateEditingController.text = value!.toString();
      },
      onTap: () async {
        DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100));
        if (newDate != null) {
          print(newDate);
          String formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
          print(formattedDate);
          setState(() {
            date = newDate;
          });
        } else {
          print(kStartDateNullError);
        }
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
        labelText: "أدخل تاريخ البدايه",
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
          Padding(padding: const EdgeInsets.all(defaultPadding)),
          SizedBox(height: defaultPadding / 2),
          titleField,
          SizedBox(height: defaultPadding / 2),
          descripField,
          SizedBox(height: defaultPadding / 2),
          locField,
          SizedBox(height: defaultPadding / 2),
          startDate,
          Padding(padding: const EdgeInsets.all(defaultPadding)),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return secSignUpScreen();
                    },
                  ),
                );
              }
            },
            child: Text("ارسال".toUpperCase(), style: TextStyle(fontSize: 16)),
          ),
          const SizedBox(height: defaultPadding),
          //extra btn
          ElevatedButton(
            onPressed: () {
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginAndSignupBtn();
                    },
                  ),
                );
              }
            },
            child: Text("back".toUpperCase(), style: TextStyle(fontSize: 16)),
          ),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
