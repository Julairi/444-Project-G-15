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

class EditProfileForm extends StatefulWidget {
  Uint8List? _image;

  EditProfileForm({Key? key}) : super(key: key) {}

  @override
  EditProfileFormState createState() => EditProfileFormState();

  void setState(Null Function() param0) {}
}

class EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
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
}
