import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/services/database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditPostForm extends StatefulWidget {
  final Post post;
  EditPostForm({required this.post, Key? key}) : super(key: key) {
    Get.put(EditPostFormController());
  }

  @override
  EditPostFormState createState() => EditPostFormState();
}

class EditPostFormState extends State<EditPostForm> {
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
  void initState() {
    _setDetails(
      widget.post,
      titleEditingController,
      descriptionEditingController,
      locationEditingController,
      startDateEditingController,
      endDateEditingController,
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

        if (value.trim().isEmpty) {
          return kJobTitleNullError;
        } else if (number != null) {
          return 'يجب أن يحتوي عنوان الإعلان الوظيفي على حروف وأرقام معا';
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
        prefixIcon: const Padding(padding: EdgeInsets.zero),
        labelText: " ادخل عنوان الاعلان الوظيفي",
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
        if (value.trim().isEmpty) {
          return kDescNullError;
        } else if (number != null) {
          return 'يجب أن يحتوي وصف الوظيفة على حروف وأرقام معا';
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
        labelText: "أدخل وصف الوظيفه",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
      maxLines: 100,
      minLines: 5,
    );

    final locationField = SizedBox(
        height: 52,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
              height: 44,
              decoration: const BoxDecoration(
                  color: kFillColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
              margin: const EdgeInsets.only(top: 8),
              child: PopupMenuButton<String>(
                tooltip: "Select City",
                enabled: true,
                constraints: BoxConstraints(
                  minHeight: 24,
                  maxHeight: MediaQuery.of(context).size.height / 1.35,
                  minWidth: 180,
                  maxWidth: 180,
                ),
                position: PopupMenuPosition.under,
                itemBuilder: (context) =>
                    controller.cities.map<PopupMenuItem<String>>((String city) {
                  return PopupMenuItem<String>(
                    value: city,
                    child: SizedBox(
                      height: 18,
                      child: Text(
                        city,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  );
                }).toList(),
                onSelected: (String city) {
                  controller.city.value = city;
                },
                child: SizedBox(
                    width: double.infinity,
                    height: 30,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(26),
                          ),
                          SizedBox(
                            height: 18,
                            child: GetX<EditPostFormController>(
                                builder: (controller) {
                              return Text(
                                controller.city.value,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                textAlign: TextAlign.start,
                              );
                            }),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
            Container(
              height: 20,
              margin: const EdgeInsets.only(left: 48),
              child: const Text(
                "اختر المدينة",
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ));

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
            lastDate: DateTime((DateTime.now().millisecondsSinceEpoch +
                (1000 * 60 * 60 * 24 * 90))));
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
        DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime((DateTime.now().millisecondsSinceEpoch +
                (1000 * 60 * 60 * 24 * 90))));
        if (newDate != null) {
          setState(() {
            endDateEditingController.text =
                DateFormat('yyyy-MM-dd').format(newDate);
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
        ),
      ),

      validator: (value) {
        if (value!.trim().isEmpty) {
          return kTimeNullError;
        }
        //// checkkkkkkkkkkk

        final date = DateFormat('yyyy-MM-dd h:mm aa').parse(
            "${startDateEditingController.text.trim()} ${timeEditingController.text.trim()}");

        if (date.millisecondsSinceEpoch <
            DateTime.now().millisecondsSinceEpoch) {
          // Fluttertoast.showToast(
          return "يحب أن يكون الوقت  بالمستقبل";
          //backgroundColor: Colors.redAccent,
          // textColor: kFillColor,
          //);
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
                Text("يجب أن يكون بحدود ثلاث أشهر من الوقت الحالي*")
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
                  widget.post.startDate =
                      startDateEditingController.text.trim();
                  widget.post.endDate = endDateEditingController.text.trim();
                  widget.post.nHours = noOfHoursEditingController.text.trim();
                  widget.post.time = timeEditingController.text.trim();
                  widget.post.payPerHour =
                      int.parse(payPerHourEditingController.text.trim());
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
      TextEditingController startDateEditingController,
      TextEditingController endDateEditingController,
      TextEditingController noOfHoursEditingController,
      TextEditingController payPerHourEditingController,
      TextEditingController timeEditingController,
      TextEditingController applicantsEditingController) {
    titleEditingController.text = post.title;
    descriptionEditingController.text = post.description;
    locationEditingController.text = post.city;
    startDateEditingController.text = post.startDate;
    endDateEditingController.text = post.endDate;
    noOfHoursEditingController.text = post.nHours;
    payPerHourEditingController.text = post.payPerHour.toString();
    timeEditingController.text = post.time;
    applicantsEditingController.text = post.maxNoOfApplicants;
  }
}

class EditPostFormController extends UserController {
  RxString city = "".obs;

  RxList<String> cities = <String>[
    "Abha",
    "Ad-Dilam",
    "Al-Abwa",
    "Al Artaweeiyah",
    "Al Bukayriyah",
    "Badr",
    "Baljurashi",
    "Bisha",
    "Bareq",
    "Buraydah",
    "Al Bahah",
    "Buqaa",
    "Dammam",
    "Dhahran",
    "Dhurma",
    "Dahaban",
    "Diriyah",
    "Duba",
    "Dumat Al-Jandal",
    "Dawadmi",
    "Farasan",
    "Gatgat",
    "Gerrha",
    "Ghawiyah",
    "Al-Gwei'iyyah",
    "Hautat Sudair",
    "Habaala",
    "Hajrah",
    "Haql",
    "Al-Hareeq",
    "Harmah",
    "Ha'il",
    "Hotat Bani Tamim",
    "Hofuf",
    "Huraymila",
    "Hafr Al-Batin",
    "Jabal Umm al Ru'us",
    "Jalajil",
    "Jeddah",
    "Jizan",
    "Jizan Economic City",
    "Jubail",
    "Al Jafr",
    "Khafji",
    "Khaybar",
    "King Abdullah Economic City",
    "Khamis Mushait",
    "Al-Saih",
    "Knowledge Economic City, Medina",
    "Khobar",
    "Al-Khutt",
    "Layla",
    "Lihyan",
    "Al Lith",
    "Al Majma'ah",
    "Mastoorah",
    "Al Mikhwah",
    "Al-Mubarraz",
    "Al Mawain",
    "Medina",
    "Mecca",
    "Muzahmiyya",
    "Najran",
    "Al-Namas",
    "Umluj",
    "Al-Omran",
    "Al-Oyoon",
    "Qadeimah",
    "Qatif",
    "Qaisumah",
    "Al Qunfudhah",
    "Qurayyat",
    "Rabigh",
    "Rafha",
    "Ar Rass",
    "Ras Tanura",
    "Ranyah",
    "Riyadh",
    "Riyadh Al-Khabra",
    "Rumailah",
    "Sabt Al Alaya",
    "Sarat Abidah",
    "Saihat",
    "Safwa city",
    "Sakakah",
    "Sharurah",
    "Shaqraa",
    "Shaybah",
    "As Sulayyil",
    "Taif",
    "Tabuk",
    "Tanomah",
    "Tarout",
    "Tayma",
    "Thadiq",
    "Thuwal",
    "Thuqbah",
    "Turaif",
    "Tabarjal",
    "Udhailiyah",
    "Al-'Ula",
    "Um Al-Sahek",
    "Unaizah",
    "Uqair",
    "\'Uyayna",
    "Uyun AlJiwa",
    "Wadi Al-Dawasir",
    "Al Wajh",
    "Yanbu",
    "Az Zaimah",
    "Zulfi",
  ].obs;
  bool isNumericUsingRegularExpression(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string);
  }
}
