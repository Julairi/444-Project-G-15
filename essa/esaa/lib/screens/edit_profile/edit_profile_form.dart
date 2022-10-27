import 'package:esaa/config/constants.dart';
import 'dart:typed_data';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/company_home/company_home.dart';
import 'package:esaa/screens/edit_post/edit_post.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/database/database.dart';
import 'package:esaa/app.dart';
import 'package:esaa/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:esaa/screens/intro/intro.dart';
import 'package:esaa/services/services.dart';
import 'package:esaa/screens/profile_screen.dart';

class EditProfileForm extends StatefulWidget {
  //Uint8List? _image;

  EditProfileForm({Key? key}) : super(key: key) {}

  @override
  EditProfileFormState createState() => EditProfileFormState();

  //void setState(Null Function() param0) {}
}

class EditProfileFormState extends State<EditProfileForm> {
  /*final _formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      title: const Text("تعديل الحساب",
          style: TextStyle(
              color: kPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis)),
      showLeading: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(alignment: Alignment.center, children: [
          Container(
              margin: EdgeInsets.all(100.0),
              decoration: BoxDecoration(shape: BoxShape.circle),
              width: double.infinity,
              child: App.user.imgUrl == ''
                  ? Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.white,
                    )
                  : Image.network(App.user.imgUrl)),
          TextFormField(
            decoration: InputDecoration(
              hintText: App.user.name,
              contentPadding: EdgeInsets.all(15.0),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[200],
            ),
            onSaved: (newValue) => App.user.name = newValue!.trim(),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              hintText: App.user.description,
              contentPadding: EdgeInsets.all(15.0),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[200],
            ),
            onSaved: (newValue) => App.user.description = newValue!.trim(),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              hintText: App.user.contact,
              contentPadding: EdgeInsets.all(15.0),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[200],
            ),
            onSaved: (newValue) => App.user.contact = newValue!.trim(),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              hintText: App.user.email,
              contentPadding: EdgeInsets.all(15.0),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[200],
            ),
            onSaved: (newValue) => App.user.email = newValue!.trim(),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              hintText: App.user.address,
              contentPadding: EdgeInsets.all(15.0),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[200],
            ),
            onSaved: (newValue) => App.user.address = newValue!.trim(),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              hintText: App.user.description,
              contentPadding: EdgeInsets.all(15.0),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[200],
            ),
            onSaved: (newValue) => App.user.description = newValue!.trim(),
          ),
        ]),
      ),
    );
  }
}

void selectImage() async {
  final pickedFile = await pickImage(ImageSource.gallery);

  if (pickedFile != null) {
    Uint8List image = await pickImage(ImageSource.gallery);
  }
}*/

  final _formKey = GlobalKey<FormState>();
  //bool isButtonDisable= true;

  final nameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confPasswordEditingController = TextEditingController();
  final addressEditingController = TextEditingController();
  final contactEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();

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
    final nameField = TextFormField(
      controller: nameEditingController,
      keyboardType: TextInputType.name,
      cursorColor: kPrimaryColor,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => emailEditingController.text = newValue!,
      decoration: InputDecoration(
        hintText: App.user.name,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: kFillColor),
        ),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Icon(Icons.person_add),
        ),
        labelText: " أدخل اسم الشركة",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
    );

    final addressField = TextFormField(
      controller: addressEditingController,
      keyboardType: TextInputType.streetAddress,
      cursorColor: kPrimaryColor,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => addressEditingController.text = newValue!,
      decoration: InputDecoration(
        hintText: App.user.address,
        filled: true,
        fillColor: kFillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: kFillColor),
        ),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Icon(Icons.pin_drop),
        ),
        labelText: "أدخل عنوان الشركة ",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
    );

    final contactInfoField = TextFormField(
      controller: contactEditingController,
      keyboardType: TextInputType.text,
      cursorColor: kPrimaryColor,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => contactEditingController.text = newValue!,
      decoration: InputDecoration(
        hintText: App.user.contact,
        filled: true,
        fillColor: kFillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: kFillColor),
        ),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Icon(Icons.contacts),
        ),
        labelText: "طريقة تواصل للشركة",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
    );

    final descriptionField = TextFormField(
      controller: descriptionEditingController,
      keyboardType: TextInputType.text,
      cursorColor: kPrimaryColor,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => descriptionEditingController.text = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return kEmailNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: App.user.description,
        filled: true,
        fillColor: kFillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: kFillColor),
        ),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Icon(Icons.brush),
        ),
        labelText: "اضف وصف مختصر عن الشركة",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
    );

    return SafeArea(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _image != null
                  ? CircleAvatar(
                      radius: 70, backgroundImage: MemoryImage(_image!))
                  : GestureDetector(
                      onTap: selectImage,
                      child: SizedBox(
                        height: 200,
                        width: 290,
                        child: App.user.imgUrl == ''
                            ? Icon(
                                Icons.person,
                                size: 80,
                                color: Colors.white,
                              )
                            : Image.network(App.user.imgUrl),
                      ),
                    ),
              const Padding(padding: EdgeInsets.all(defaultPadding)),
              const SizedBox(height: defaultPadding / 2),
              nameField,
              const SizedBox(height: defaultPadding / 2),
              addressField,
              const SizedBox(height: defaultPadding / 2),
              contactInfoField,
              const SizedBox(height: defaultPadding / 2),
              descriptionField,
              const Padding(padding: EdgeInsets.all(defaultPadding)),
              const SizedBox(height: defaultPadding / 2),
              ElevatedButton(
                onPressed: () {
                  //UPDATE METHOD
                  updateCompany(App.user.id);
                  ProfileScreen();
                },
                child: Text("تعديل الحساب".toUpperCase(),
                    style: const TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: defaultPadding),
              const SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateCompany(String uID) async {
    String imgUrl = "";
    if (_image != null) {
      imgUrl = await Storage().uploadImageToString("companyLogo ", _image!);
    }

    User company = User.empty();

    company.email = emailEditingController.text;
    company.imgUrl = imgUrl;
    company.id = uID;
    company.name = nameEditingController.text;
    company.address = addressEditingController.text;
    company.contact = contactEditingController.text;
    company.description = descriptionEditingController.text;
    company.userType = "company";

    //NEED TO MAKE SURE IT DOESNT NULLIFY THE EMPTY FIELDS

    await UserDatabase(uID).updateDetails(company.toMap());
  }
}
