import 'package:flutter/material.dart';

//Color.fromARGB(255, 127, 182, 177);
const kPrimaryColor = Color.fromARGB(255, 112, 171, 166);
const kSPrimaryColor = Color.fromARGB(255, 2, 52, 94);
const kPrimaryLightColor = Color.fromARGB(210, 247, 247, 247);
const kTextColor = Color.fromARGB(255, 112, 171, 166);
const kFillColor = Color.fromARGB(255, 249, 250, 250);
const KGrey = Color.fromARGB(255, 108, 106, 106);
const double defaultPadding = 16.0;
const double defaultFontSize = 16.0;
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp textlValidatorRegExp = RegExp("[0-9]");
const String kEmailNullError = "الرجاء إدخال البريد الإلكتروني";
const String kInvalidEmailError = " الرجاء إدخال البريد الإلكتروني بشكل صحيح";
const String kPassNullError = "الرجاء إدخال كلمة المرور";
const String kShortPassError =
    "كلمة المرور قصيرة جدا يجب ألا تكون أقل من 8 خانات";
const String kMatchPassError = "كلمتي المرور لاتتطابقان";
const String kFirstNameNullError = "الرجاء إدخال اسمك الأول";
const String kSecondNameNullError = "الرجاء إدخال اسمك الأخير";
const String kPhoneNumberNullError = "الرجاء إدخال رقم الهاتف";
const String kInvalidPhoneNumber = "الرجاء إدخال رقم الهاتف بشكل صحيح";
const String kNationalIdNullError = "الرجاءإدخال رقم الهوية/الإقامة";
const String kInvalidNationalIdError =
    "الرجاء إدخال رقم الهوية/الإقامة بشكل صحيح";
const String kDOBNullError = " الرجاء إدخال يوم ميلادك  ";
const String kJobTitleNullError = "الرجاء إدخال عنوان الاعلان الوظيفي";
const String kDescNullError = "الرجاء ادخال الوصف";
const String kLocationNullError = "الرجاء ادخال الموقع";
const String kStartDateNullError = " الرجاء إدخال تاريخ البداية   ";
const String kEndDateNullError = " الرجاء إدخال تاريخ النهاية   ";
const String kTimeNullError = " الرجاء إدخال الوقت   ";
const String kNullError = "الرجاء إدخال نبذة تعريفية";
const String kDesError = "النص يجب أن لا يتجاوز 500 حرف";
const String kDesEmpty = 'رجاءً قم بادخال النبذة التعريفية بشكل صحيح';
