import 'dart:typed_data';

import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/screens/profiles/companyProfileView.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/services.dart';
import 'package:esaa/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../review_page.dart';

class CompanyProfile extends StatefulWidget {
  CompanyProfile({Key? key}) : super(key: key) {
    Get.put(EditProfileFormController());
  }
  @override
  _CompanyProfileState createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool en = false;
  String stroredImg = '';
  setStoredImg() {
    if (App.user.imgUrl == '' || App.user.imgUrl == null) {
      stroredImg = Icons.image as String;
    } else
      stroredImg = App.user.imgUrl;
  }

  Uint8List? _image;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final contactController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  void initState() {
    _setInitialValues(nameController, emailController, addressController,
        contactController, descriptionController);
    super.initState();
  }

  saveNewValues() async {
    App.user.name = nameController.text;
    App.user.address = addressController.text;
    App.user.email = emailController.text;
    App.user.description = descriptionController.text;
    App.user.contact = contactController.text;
    String imgUrl = "";
    if (_image != null) {
      imgUrl = await Storage().uploadImageToString("companyLogo ", _image!);
    }
    App.user.imgUrl = imgUrl;
    await UserDatabase(App.user.id).updateDetails(App.user.toMap());
  }

  void selectImage() async {
    final pickedFile = await pickImage(ImageSource.gallery);
    if (pickedFile != null) {
      Uint8List image = await pickImage(ImageSource.gallery);
      setState(() {
        _image = image;
      });
    }
    String imgUrl = "";
    if (_image != null) {
      imgUrl = await Storage().uploadImageToString("companyLogo ", _image!);
      App.user.imgUrl = imgUrl;
      await UserDatabase(App.user.id).updateDetails(App.user.toMap());
    }
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
        //showLogout: true,
        showLeading: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        _image != null
                            ? CircleAvatar(
                                radius: 70,
                                backgroundImage: MemoryImage(_image!))
                            : GestureDetector(
                                onTap: selectImage,
                                child: SizedBox(
                                  height: 200,
                                  width: 290,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(stroredImg),
                                    child: IconButton(
                                      iconSize: 40,
                                      icon: const Icon(Icons.camera_alt),
                                      onPressed: () => selectImage(),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 35,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onTap: () =>
                            Get.to(() => ReviewPage(userID: App.user.id)),
                        child: const Text(
                          "عرض التقييمات",
                          style: TextStyle(
                              fontSize: 18,
                              color: kPrimaryColor,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                              controller: descriptionController,
                              onSaved: (newValue) => descriptionController
                                  .text = newValue!.trim().toString(),
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
                                      saveNewValues();
                                      //en = false;
                                      Fluttertoast.showToast(
                                          msg: "تم التعديل بنجاح",
                                          backgroundColor: Colors.black54,
                                          toastLength: Toast.LENGTH_LONG,
                                          textColor: kFillColor);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                companyProfileView()),
                                      );
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                  primary: kPrimaryColor, elevation: 0),
                              child: const Text(
                                "حفظ التعديلات",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
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

void _setInitialValues(
    TextEditingController nameController,
    TextEditingController emailController,
    TextEditingController addressController,
    TextEditingController contactController,
    TextEditingController descriptionController) {
  nameController.text = App.user.name;
  emailController.text = App.user.email;
  addressController.text = App.user.address;
  contactController.text = App.user.contact;
  descriptionController.text = App.user.description;
}

class EditProfileFormController extends UserController {}
