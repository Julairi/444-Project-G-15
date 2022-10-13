import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/edit_post/edit_post.dart';
import 'package:esaa/services/database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class profileForm extends StatefulWidget {
  final Post post;
  profileForm({required this.post, Key? key}) : super(key: key) {
    Get.put(EditPostFormController());
  }

  @override
  profileFormState createState() => profileFormState();
}

class profileFormState extends State<EditPostForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();

  final titleEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();
  final locationEditingController = TextEditingController();
  final dateEditingController = TextEditingController();
  final noOfHoursEditingController = TextEditingController();
  final payPerHourEditingController = TextEditingController();
  final timeEditingController = TextEditingController();
  final applicantsEditingController = TextEditingController();

  TimeOfDay timeOfDay = const TimeOfDay(hour: 8, minute: 00);

  @override
  void initState() {
    _setDetails(
      widget.post,
      titleEditingController,
      descriptionEditingController,
      locationEditingController,
      dateEditingController,
      noOfHoursEditingController,
      payPerHourEditingController,
      timeEditingController,
      applicantsEditingController,
    );
    final controller = Get.find<EditPostFormController>();

    controller.city.value = widget.post.city;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditPostFormController>();

    final titleField = TextFormField(
      controller: titleEditingController,
      keyboardType: TextInputType.name,
      cursorColor: kPrimaryColor,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => titleEditingController.text = newValue!.trim(),
      validator: (value) {
        final number = num.tryParse(value!);

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
        labelText: "",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
    );

    final descriptionField = TextFormField(
      controller: descriptionEditingController,
      onSaved: (newValue) =>
          descriptionEditingController.text = newValue!.trim(),
      validator: (value) {
        final number = num.tryParse(value!);

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
        labelText: " ",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
      maxLines: 100,
      minLines: 5,
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
        labelText: "",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return kStartDateNullError;
        } else {}
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

      validator: (value) {
        if (value!.trim().isEmpty) {
          return kTimeNullError;
        }
        //// checkkkkkkkkkkk
      },
    );

    final noOfHours = TextFormField(
      controller: noOfHoursEditingController,
      cursorColor: kPrimaryColor,
      keyboardType:
          const TextInputType.numberWithOptions(signed: false, decimal: true),
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        noOfHoursEditingController.text = value!.trim();
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: kFillColor),
        ),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(defaultPadding),
        ),
        labelText: "  ",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
    );

    final payPerHour = TextFormField(
      controller: payPerHourEditingController,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      onSaved: (value) {
        payPerHourEditingController.text = value!.trim();
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
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
      validator: (value) {},
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
      ),
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
            startDate,
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
                final controller = Get.find<EditPostFormController>();
                if (_formKey.currentState!.validate()) {
                  /* final date = DateFormat('yyyy-MM-dd h:mm aa').parse(
                      "${dateEditingController.text.trim()} ${timeEditingController.text.trim()}");

                  if (date.millisecondsSinceEpoch <
                      DateTime.now().millisecondsSinceEpoch) {
                    Fluttertoast.showToast(
                      msg: "يحب أن يكون الوقت والتاريخ بالمستقبل",
                      backgroundColor: Colors.redAccent,
                      textColor: kFillColor,
                    );
                    return;
                  }*/

                  widget.post.title = titleEditingController.text.trim();
                  widget.post.description =
                      descriptionEditingController.text.trim();
                  widget.post.city = controller.city.value;
                  widget.post.date = dateEditingController.text.trim();
                  widget.post.nHours = noOfHoursEditingController.text.trim();
                  widget.post.time = timeEditingController.text.trim();
                  widget.post.payPerHour =
                      payPerHourEditingController.text.trim();
                  widget.post.maxNoOfApplicants =
                      applicantsEditingController.text.trim() == ""
                          ? "1"
                          : applicantsEditingController.text.trim();

                  controller.isLoading.value = true;

                  await PostDatabase().updatePostDetails(widget.post.toMap());

                  controller.isLoading.value = false;

                  Fluttertoast.showToast(
                      msg: "تم تعديل المنشور بنجاح",
                      backgroundColor: Colors.black54,
                      toastLength: Toast.LENGTH_LONG,
                      textColor: kFillColor);

                  Get.offAllNamed('/');
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GetX<EditPostFormController>(builder: (controller) {
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
                    child: Text("تعديل".toUpperCase(),
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

  void _setDetails(
      Post post,
      TextEditingController titleEditingController,
      TextEditingController descriptionEditingController,
      TextEditingController locationEditingController,
      TextEditingController dateEditingController,
      TextEditingController noOfHoursEditingController,
      TextEditingController payPerHourEditingController,
      TextEditingController timeEditingController,
      TextEditingController applicantsEditingController) {
    titleEditingController.text = post.title;
    descriptionEditingController.text = post.description;
    locationEditingController.text = post.city;
    dateEditingController.text = post.date;
    noOfHoursEditingController.text = post.nHours;
    payPerHourEditingController.text = post.payPerHour;
    timeEditingController.text = post.time;
    applicantsEditingController.text = post.maxNoOfApplicants;
  }
}

class EditPostFormController extends UserController {
  RxString city = "".obs;

  bool isNumericUsingRegularExpression(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string);
  }
}
