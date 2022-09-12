//import 'package:esaa/Screens/Login/login_screen.dart';
import 'package:esaa/Screens/Welcome/components/login_signup_btn.dart';
import 'package:esaa/Screens/signup/sec_signup_scren.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final noHoursEditingController = new TextEditingController();
  final payHourEditingController = new TextEditingController();
  final timeEditingController = new TextEditingController();
  TimeOfDay timeOfDay = TimeOfDay(hour: 8, minute: 00);
  FocusNode myFocusNode = new FocusNode();

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        timeOfDay = value!;
      });
    });
  }

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
        filled: true,
        fillColor: kFillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: kFillColor),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
        ),
        labelText: " ادخل عنوان الاعلان الوظيفي",
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
          return kdescNullError;
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
        labelText: "أدخل وصف الوظيفه  ",
        floatingLabelStyle: TextStyle(
          color: kTextcolor,
          fontSize: 20,
        ),
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
      textInputAction: TextInputAction.next,
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
        labelText: " ادخل المدينه",
        floatingLabelStyle: TextStyle(
          color: kTextcolor,
          fontSize: 20,
        ),
      ),
    );

    final startDate = TextFormField(
      controller: dateEditingController,
      cursorColor: kPrimaryColor,
      //keyboardType: TextInputType.datetime,
      readOnly: true,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        dateEditingController.text = value!.toString();
      },
      onTap: () async {
        DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2101));
        if (newDate != null) {
          setState(() {
            dateEditingController.text =
                DateFormat('yyyy-MM-dd').format(newDate);
          });
        } else {
          print(kStartDateNullError);
        }
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
          child: Icon(Icons.date_range),
        ),
        labelText: "أدخل التاريخ ",
        floatingLabelStyle: TextStyle(
          color: kTextcolor,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return kDOBNullError;
        } else
          return null;
      },
    );

    final time = TextFormField(
      readOnly: true,
      controller: timeEditingController,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.datetime,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        //timeEditingController.text = value!;
        timeOfDay.format(context).toString();
      },
      // time picker
      onTap: () async {
        TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (time != null) {
          setState(() {
            timeEditingController.text = time.format(context).toString();
          });
        }
      },

      decoration: InputDecoration(
        filled: true,
        fillColor: kFillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: kFillColor),
          // border color
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
        ),
        labelText: " الوقت",
        floatingLabelStyle: TextStyle(
          color: kTextcolor,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),

      validator: (value) {
        if (value!.isEmpty) {
          //// checkkkkkkkkkkk
          return ktimeNullError;
        }
        //}
        else
          return null;
      },
    );

    final noHours = TextFormField(
      controller: noHoursEditingController,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        noHoursEditingController.text = value!;
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: kFillColor),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
        ),
        labelText: "أدخل عدد الساعات",
        floatingLabelStyle: TextStyle(
          color: kTextcolor,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          //// checkkkkkkkkkkk
          return kPhoneNumberNullError;
        }
        //}
        else
          return null;
      },
    );

    final payHour = TextFormField(
      controller: payHourEditingController,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      onSaved: (value) {
        payHourEditingController.text = value!;
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
        labelText: " الأجر لكل ساعه",
        floatingLabelStyle: TextStyle(
          color: kTextcolor,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          //// checkkkkkkkkkkk
          return kPhoneNumberNullError;
        }
        //}
        else
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
          SizedBox(height: defaultPadding / 2),
          noHours,
          SizedBox(height: defaultPadding / 2),
          time,
          SizedBox(height: defaultPadding / 2),
          payHour,
          Padding(padding: const EdgeInsets.all(defaultPadding)),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                // add new post
                var currentUser = await FirebaseAuth.instance.currentUser;
                FirebaseFirestore.instance.collection('posts').doc().set({
                  'Title': titleEditingController.text,
                  'Description': descripEditingController.text,
                  'City': locationEditingController.text,
                  'Date': dateEditingController.text,
                  'nHours': noHoursEditingController.text,
                  'Time': timeEditingController.text,
                  'Pay per hour': payHourEditingController.text,
                  'user': 'users/nmUoWSvCgKZ24L4yBItbaWuHWcw2',
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return secSignUpScreen();
                    },
                  ),
                ); //push
              } //end if
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
