import 'dart:developer';
import 'package:esaa/navbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
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

//88888888888888888888888

//88888888888888

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
          return kStartDateNullError;
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
      keyboardType:
          TextInputType.numberWithOptions(signed: false, decimal: true),
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
          return 'الرجاء ادخال عدد الساعات';
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
          return 'الرجاء ادخال المبلغ للساعه';
        }
        //}
        else
          return null;
      },
    );

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
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

            // btn *****************
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // add new post
                  User? currentUser = await FirebaseAuth.instance.currentUser;
                  /*
                  var cName = await FirebaseFirestore.instance
                      .collection('company')
                      .doc("HtgizLsb0tWt3JxlpXCxsc4Nz623")
                      .get()
                      .then((value) {
                    return value
                        .data()!['Name']; // Access your after your get the data
                  });*/
                  FirebaseFirestore.instance.collection('posts').add({
                    'Title': titleEditingController.text,
                    'Description': descripEditingController.text,
                    'City': locationEditingController.text,
                    'Date': dateEditingController.text,
                    'nHours': noHoursEditingController.text,
                    'Time': timeEditingController.text,
                    'PayPerHour': payHourEditingController.text,
                    'user': '/company/' + currentUser!.uid,
                    'offerstatus': 'pending',
                    'orderstatus': 'none',
                    /*
                    'user': {
                      'uid': currentUser!.uid,
                      'Name': cName,
                      'email': currentUser.email,
                    }*/
                    //'user': '/company/HtgizLsb0tWt3JxlpXCxsc4Nz623',
                  });
                  log('post done ');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return navbar();
                      },
                    ),
                  ); //push
                } //end if
              },
              child:
                  Text("ارسال".toUpperCase(), style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: defaultPadding),
          ],
        ),
      ),
    );
  }
}
