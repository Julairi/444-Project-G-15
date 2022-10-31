import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class JobSeekerProfile extends StatefulWidget {
  JobSeekerProfile({Key? key}) : super(key: key) {
    Get.put(JobSeekerFormController());
  }
  @override
  _JobSeekerProfileState createState() => _JobSeekerProfileState();
}

class _JobSeekerProfileState extends State<JobSeekerProfile> {
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
    super.initState();
  }

  saveNewValues() async {
    App.user.name = nameController.text;
    App.user.email = emailController.text;
    App.user.id = idController.text;
    //App.user.rates.sex;

    await UserDatabase(App.user.id).updateDetails(App.user.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
        title: const Text("حسابك الشخصي",
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis)),
        showLogout: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                      saveNewValues();
                                      //en = false;
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                  primary: kPrimaryColor, elevation: 0),
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

class JobSeekerFormController extends UserController {}
