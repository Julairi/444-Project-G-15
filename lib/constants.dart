import 'package:flutter/material.dart';

//Color.fromARGB(255, 127, 182, 177);
const kPrimaryColor = Color.fromARGB(255, 112, 171, 166);
const kSPrimaryColor = Color.fromARGB(255, 22, 126, 196);
const kPrimaryLightColor = Color.fromARGB(210, 247, 247, 247);
const kTextcolor = Color.fromARGB(255, 112, 171, 166);
const kFillColor = Color.fromARGB(255, 249, 250, 250);
const double defaultPadding = 16.0;
const double defaultFontSize = 16.0;
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "الرجاء إدخال البريد الإلكتروني";
const String kInvalidEmailError = " الرجاء إدخال البريد الإلكتروني بشكل صحيح";
const String kPassNullError = "الرجاء إدخال كلمة المرور";
const String kShortPassError =
    "كلمة المرور قصيرة جدا يجب ألا تكون أقل من 8 خانات";
const String kMatchPassError = "كلمتي المرور لاتتطابقان";
const String kFNamelNullError = "الرجاء إدخال اسمك الأول";
const String kSNamelNullError = "الرجاء إدخال اسمك الأخير";
const String kPhoneNumberNullError = "الرجاء إدخال رقم الهاتف";
const String kInvalidPhoneNumber = "الرجاء إدخال رقم الهاتف بشكل صحيح";
const String kNationalIdNullError = "الرجاءإدخال رقم الهوية/الإقامة";
const String kInvalidNationalIdError =
    "الرجاء إدخال رقم الهوية/الإقامة بشكل صحيح";
const String kDOBNullError = " الرجاء إدخال يوم ميلادك  ";
const String kjobTitleNullError = "الرجاء إدخال عنوان الاعلان الوظيفي";
const String kdescNullError = "الرجاء ادخال الوصف";
const String klocNullError = "الرجاء ادخال الموقع";
const String kStartDateNullError = " الرجاء إدخال التاريخ   ";
const String ktimeNullError = " الرجاء إدخال الوقت   ";
const String kNullError = "الرجاء إدخال نبذة تعريفية";
