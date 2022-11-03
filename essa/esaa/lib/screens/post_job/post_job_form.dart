import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/services/database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PostJobForm extends StatefulWidget {
  const PostJobForm({Key? key}) : super(key: key);

  @override
  PostJobFormState createState() => PostJobFormState();
}

class PostJobFormState extends State<PostJobForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();

  final titleEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();
  final locationEditingController = TextEditingController();
  final startDateEditingController = TextEditingController();
  final endDateEditingController = TextEditingController();
  final noOfHoursEditingController = TextEditingController();
  final payPerHourEditingController = TextEditingController();
  final timeEditingController = TextEditingController();
  final applicantsEditingController = TextEditingController();

  TimeOfDay timeOfDay = const TimeOfDay(hour: 8, minute: 00);

  @override
  Widget build(BuildContext context) {
    final titleField = TextFormField(
      controller: titleEditingController,
      keyboardType: TextInputType.name,
      cursorColor: kPrimaryColor,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => titleEditingController.text = newValue!,
      validator: (value) {
        final number = num.tryParse(value!);

        if (value.trim().isEmpty) {
          return kJobTitleNullError;
        } else if (number != null) {
          return 'يجب أن لا يحتوي عنوان الإعلان الوظيفي على أرقام فقط';
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
        ),
        labelText: " ادخل عنوان الاعلان الوظيفي",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
    );

    final descriptionField = TextFormField(
      controller: descriptionEditingController,
      onSaved: (newValue) => descriptionEditingController.text = newValue!,
      validator: (value) {
        final number = num.tryParse(value!);
        if (value.trim().isEmpty) {
          return kDescNullError;
        } else if (number != null) {
          return 'يجب أن لا يحتوي وصف الوظيفة على أرقام فقط';
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
        ),
        labelText: "أدخل وصف الوظيفه  ",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
      maxLines: 100,
      minLines: 5,
    );

    final locationField = TextFormField(
      controller: locationEditingController,
      cursorColor: kPrimaryColor,
      onSaved: (newValue) => locationEditingController.text = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return "الرجاء إدخال المدينة";
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
        ),
        labelText: " ادخل المدينه",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
    );

    final startDate = TextFormField(
      controller: startDateEditingController,
      cursorColor: kPrimaryColor,
      //keyboardType: TextInputType.datetime,
      readOnly: true,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        startDateEditingController.text = value!.toString();
      },
      onTap: () async {
        DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2101));
        if (newDate != null) {
          setState(() {
            startDateEditingController.text =
                DateFormat('yyyy-MM-dd').format(newDate);
          });
        } else {
          if (kDebugMode) {
            print(kStartDateNullError);
          }
        }
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
          child: Icon(Icons.date_range),
        ),
        labelText: "أدخل تاريخ البداية ",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return kStartDateNullError;
        } else {
          if (DateFormat('yyyy-MM-dd').parse(value).millisecondsSinceEpoch >
              (DateTime.now().millisecondsSinceEpoch +
                  (1000 * 60 * 60 * 24 * 90))) {
            return "يجب ان يكون التاريخ بحدود ثلاث اشهر من تاريخ اليوم";
          } else {
            return null;
          }
        }
      },
    );

    final endDate = TextFormField(
      controller: endDateEditingController,
      cursorColor: kPrimaryColor,
      //keyboardType: TextInputType.datetime,
      readOnly: true,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        endDateEditingController.text = value!.toString();
      },
      onTap: () async {
        DateTime? newDate2 = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2101));
        if (newDate2 != null) {
          setState(() {
            endDateEditingController.text =
                DateFormat('yyyy-MM-dd').format(newDate2);
          });
        } else {
          if (kDebugMode) {
            print(kEndDateNullError);
          }
        }
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
          child: Icon(Icons.date_range),
        ),
        labelText: "أدخل تاريخ النهاية ",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return kStartDateNullError;
        } else {
          if (DateFormat('yyyy-MM-dd')
                  .parse(startDateEditingController.text)
                  .millisecondsSinceEpoch >
              (DateFormat('yyyy-MM-dd').parse(value).millisecondsSinceEpoch)) {
            return " يجب ان يكون تاريخ البداية قبل تاريخ النهاية";
          } else {
            return null;
          }
        }
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
          borderSide: const BorderSide(color: kFillColor),
          // border color
        ),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(defaultPadding),
        ),
        labelText: " الوقت",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),

      validator: (value) {
        if (value!.isEmpty) {
          //// checkkkkkkkkkkk
          return kTimeNullError;
        }
        //}
        else {
          return null;
        }
      },
    );

    final noOfHours = TextFormField(
      controller: noOfHoursEditingController,
      cursorColor: kPrimaryColor,
      keyboardType:
          const TextInputType.numberWithOptions(signed: false, decimal: true),
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        noOfHoursEditingController.text = value!;
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: kFillColor),
        ),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(defaultPadding),
        ),
        labelText: "أدخل عدد الساعات",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return 'الرجاء ادخال عدد الساعات';
        } else {
          if (value.trim() == "0") {
            return "عدد الساعات لايجب ان يكون صفر";
          } else {
            return null;
          }
        }
      },
    );

    final payPerHour = TextFormField(
      controller: payPerHourEditingController,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      onSaved: (value) {
        payPerHourEditingController.text = value!;
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
        ),
        labelText: " الأجر لكل ساعه",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value!.trim().isEmpty) {
          //// checkkkkkkkkkkk
          return 'الرجاء ادخال الأجر للساعه';
        } else {
          if (value.trim() == "0") {
            return "الأجر للساعة لايجب ان يكون صفر";
          } else {
            return null;
          }
        }
      },
    );

    final maxNoOfApplicants = TextFormField(
      controller: applicantsEditingController,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      onSaved: (value) {
        applicantsEditingController.text = value!;
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
        ),
        labelText: "العدد الأقصى للطلبات",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value!.trim().isEmpty) {
          //// checkkkkkkkkkkk
          return 'الرجاء ادخال العدد الأقصى للطلبات';
        } else {
          if (value.trim() == "0") {
            return "العدد الأقصى للطلبات يجب أن يكون أكبر من صفر";
          } else {
            return null;
          }
        }
      },
    );

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(defaultPadding)),
            const SizedBox(height: defaultPadding / 2),
            titleField,
            const SizedBox(height: defaultPadding / 2),
            descriptionField,
            const SizedBox(height: defaultPadding / 2),
            locationField,
            const SizedBox(height: defaultPadding / 2),
            startDate,
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text("*يجب أن يكون بحدود ثلاث أشهر من الوقت الحالي")
              ],
            ),
            const SizedBox(height: defaultPadding / 2),
            endDate,
            const SizedBox(height: defaultPadding / 2),
            noOfHours,
            const SizedBox(height: defaultPadding / 2),
            time,
            const SizedBox(height: defaultPadding / 2),
            payPerHour,
            const SizedBox(height: defaultPadding / 2),
            maxNoOfApplicants,
            const Padding(padding: EdgeInsets.all(defaultPadding)),
            const SizedBox(height: defaultPadding / 2),
            ElevatedButton(
              onPressed: () async {
                final controller = Get.find<UserController>();
                if (_formKey.currentState!.validate()) {
                  Post post = Post.empty();

                  post.title = titleEditingController.text;
                  post.description = descriptionEditingController.text;
                  post.city = locationEditingController.text;
                  post.startDate = startDateEditingController.text;
                  post.endDate = endDateEditingController.text;
                  post.nHours = noOfHoursEditingController.text;
                  post.time = timeEditingController.text;
                  post.payPerHour = int.parse(payPerHourEditingController.text);
                  post.offerStatus = 'pending';
                  post.companyID = App.user.id;
                  post.companyName = App.user.name;
                  post.maxNoOfApplicants =
                      applicantsEditingController.text == ""
                          ? "1"
                          : applicantsEditingController.text;
                  post.acceptedApplicants = "0";
                  post.paymentStatus = 'none_paid';
                  post.imgUrl = App.user.imgUrl;

                  controller.isLoading.value = true; //Show Indicator

                  await PostDatabase().createPost(post.toMap());

                  controller.isLoading.value = false; //Hide Indicator

                  Get.find<UserController>().changePage(2);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Show indicator if post is being created, hide otherwise
                  GetX<UserController>(builder: (controller) {
                    return Visibility(
                        visible: controller.isLoading.value,
                        child: LayoutBuilder(builder: (context, constraints) {
                          return const SpinKitRing(
                            color: kFillColor,
                            size: 24.0,
                          );
                        }));
                  }),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding * 2),
                    child: Text("ارسال".toUpperCase(),
                        style: const TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: defaultPadding),
          ],
        ),
      ),
    );
  }

  bool isNumericUsingRegularExpression(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string);
  }
}
