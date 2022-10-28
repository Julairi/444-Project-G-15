import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../models/order.dart';
import '../company_home/widgets/full_job_list.dart';
import '../company_home/widgets/order_card.dart';

class companyProfile extends StatefulWidget {
  _companyProfileState createState() => _companyProfileState();
}

class _companyProfileState extends State<companyProfile> {
  bool showPassword = false;
  bool EN = true;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final contactController = TextEditingController();
  final discriptionController = TextEditingController();
  final idController = TextEditingController();

  void _setInitialValues(
      TextEditingController nameController,
      TextEditingController emailController,
      TextEditingController addressController,
      TextEditingController contactController,
      TextEditingController discriptionController,
      TextEditingController idController) {
    nameController.text = App.user.name;
    emailController.text = App.user.email;
    addressController.text = App.user.address;
    contactController.text = App.user.contact;
    discriptionController.text = App.user.description;
    idController.text = App.user.id;
  }

  @override
  void initState() {
    _setInitialValues(nameController, emailController, addressController,
        contactController, discriptionController, idController);
    super.initState();
  }

  saveNewValues() {
    App.user.name = nameController.text;
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
        logout: true,
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
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(App.user.imgUrl)),
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
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: kPrimaryColor,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
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
                            EN = false;
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
                            EN = true;
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
                            EN = true;
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
                            EN = true;
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
                          onPressed: EN
                              ? null
                              : () async {
                                  App.user.name = nameController.text;
                                },
                          child: Text(" حفظ التغييرات".toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
