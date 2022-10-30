import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/services.dart';
import 'package:esaa/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/order.dart';
import '../company_home/widgets/full_job_list.dart';
import '../company_home/widgets/order_card.dart';

class jobseekerProfile extends StatefulWidget {
  jobseekerProfile({Key? key}) : super(key: key) {
    Get.put(jobseekerFormController());
  }
  _jobseekerProfileState createState() => _jobseekerProfileState();
}

class _jobseekerProfileState extends State<jobseekerProfile> {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool en = false;
  //String imgUrl = App.user.imgUrl;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final idController = TextEditingController();
  @override
  void initState() {
    _setInitialValues(nameController, emailController, idController);
    final controller = Get.find<jobseekerFormController>();
    super.initState();
  }

  saveNewValues() async {
    App.user.name = nameController.text;
    App.user.email = emailController.text;
    App.user.id = idController.text;

    await UserDatabase(App.user.id).updateDetails(App.user.toMap());
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<jobseekerFormController>();
    return CustomAppbar(
        title: const Text("حسابك الشخصي",
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis)),
        logout: true,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child:
                //========== profile img======================================================================
                Column(
              children: [
                //====================form ============================================
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: nameController,
                            onSaved: (newValue) =>
                                nameController.text = newValue!.trim(),
                            validator: (val) => val!.trim().isEmpty
                                ? 'يجب ان يكون الاسم اكثر من ثلاث أحرف'
                                : null,
                            onChanged: (val) => setState(() {
                              en = true;
                              nameController.text = val.toString();
                            }),
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              //overflow: TextOverflow.ellipsis
                            ),
                            decoration: InputDecoration(
                              labelText: "اسم الشركة",
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 0.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: idController,
                            onSaved: (newValue) =>
                                idController.text = newValue!.trim(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return kNationalIdNullError;
                              } else if (value.length != 10) {
                                return kInvalidNationalIdError;
                              } else {
                                return null;
                              }
                            },
                            onChanged: (val) => setState(() {
                              en = true;
                              idController.text = val.toString();
                            }),
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              //overflow: TextOverflow.ellipsis
                            ),
                            decoration: InputDecoration(
                              labelText: "الهوية الوطنية",
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 0.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            enabled: false,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              labelText: "ايميل الشركة",
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 0.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: en
                                ? () async {
                                    final controller =
                                        Get.find<jobseekerFormController>();
                                    saveNewValues();
                                    //en = false;
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor, elevation: 0),
                            child: const Text(
                              "حفظ التغييرات",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

void _setInitialValues(TextEditingController nameController,
    TextEditingController emailController, TextEditingController idController) {
  nameController.text = App.user.name;
  emailController.text = App.user.email;
  idController.text = App.user.id;
}

class jobseekerFormController extends UserController {}
