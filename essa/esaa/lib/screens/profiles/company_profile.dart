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

class companyProfile extends StatefulWidget {
  companyProfile({Key? key}) : super(key: key) {
    Get.put(EditProfileFormController());
  }
  _companyProfileState createState() => _companyProfileState();
}

class _companyProfileState extends State<companyProfile> {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool en = false;
  String imgUrl = App.user.imgUrl;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final contactController = TextEditingController();
  final discriptionController = TextEditingController();
  @override
  void initState() {
    _setInitialValues(nameController, emailController, addressController,
        contactController, discriptionController);
    final controller = Get.find<EditProfileFormController>();
    super.initState();
  }

  saveNewValues() async {
    App.user.name = nameController.text;
    App.user.address = addressController.text;
    App.user.email = emailController.text;
    App.user.description = discriptionController.text;
    App.user.contact = contactController.text;

    if (_image != null) {
      imgUrl = await Storage().uploadImageToString("companyLogo ", _image!);
    }
    await UserDatabase(App.user.id).updateDetails(App.user.toMap());
  }

  Uint8List? _image;
  void selectImage() async {
    final pickedFile = await pickImage(ImageSource.gallery);

    if (pickedFile != null) {
      Uint8List image = await pickImage(ImageSource.gallery);

      setState(() {
        _image = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditProfileFormController>();
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
                Center(
                  child: Stack(
                    children: [
                      Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover, image: NetworkImage(imgUrl)),
                          )),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: kPrimaryColor,
                            ),
                            child: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                selectImage();
                              },
                            ),
                          )),
                    ],
                  ),
                ),

                SizedBox(
                  height: 35,
                ),
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
                            controller: discriptionController,
                            onSaved: (newValue) => discriptionController.text =
                                newValue!.trim().toString(),
                            validator: (val) => val!.trim().isEmpty
                                ? 'يجب ان لا يكون الوصف فارغًا'
                                : null,
                            onChanged: (val) => setState(() {
                              en = true;
                            }),
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              //overflow: TextOverflow.ellipsis
                            ),
                            decoration: InputDecoration(
                              labelText: "وصف الشركة",
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
                            controller: contactController,
                            onSaved: (newValue) => contactController.text =
                                newValue!.trim().toString(),
                            validator: (val) => val!.trim().isEmpty
                                ? 'يجب ان لا تكون معلومات التواصل فارغة'
                                : null,
                            onChanged: (val) => setState(() {
                              en = true;
                            }),
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              //overflow: TextOverflow.ellipsis
                            ),
                            decoration: InputDecoration(
                              labelText: " معلومات التواصل",
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
                            controller: addressController,
                            onSaved: (newValue) => addressController.text =
                                newValue!.trim().toString(),
                            validator: (val) => val!.trim().isEmpty
                                ? 'يجب ان لا يكون اسم المدينة فارغًا'
                                : null,
                            onChanged: (val) => setState(() {
                              en = true;
                            }),
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              //overflow: TextOverflow.ellipsis
                            ),
                            decoration: InputDecoration(
                              labelText: "المدينة",
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
                                        Get.find<EditProfileFormController>();
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

void _setInitialValues(
    TextEditingController nameController,
    TextEditingController emailController,
    TextEditingController addressController,
    TextEditingController contactController,
    TextEditingController discriptionController) {
  nameController.text = App.user.name;
  emailController.text = App.user.email;
  addressController.text = App.user.address;
  contactController.text = App.user.contact;
  discriptionController.text = App.user.description;
}

class EditProfileFormController extends UserController {}
