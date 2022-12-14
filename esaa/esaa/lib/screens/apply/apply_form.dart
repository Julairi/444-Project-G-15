import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/services/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:esaa/services/notification.dart' as notification;

class ApplyForm extends StatefulWidget {
  final Post post;
  const ApplyForm({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  ApplyFormState createState() => ApplyFormState();
}

class ApplyFormState extends State<ApplyForm> {
  final _formKey = GlobalKey<FormState>();

  final infoEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();
  final englishLevelEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final titleField = TextFormField(
      controller: infoEditingController,
      keyboardType: TextInputType.name,
      cursorColor: kPrimaryColor,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => infoEditingController.text = newValue!,
      validator: (value) {
        if (value!.isEmpty) {}
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
        labelText: "ادخل المهارات الاضافية ان وجدت",
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
        if (value!.isEmpty) {
          return kNullError;
        } else if (value.length >= 500) {
          return kDesError;
        } else if (value == '') {
          return kDesEmpty;
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
        labelText: "أدخل نبذة تعريفية عنك ",
        floatingLabelStyle: const TextStyle(
          color: kTextColor,
          fontSize: 20,
        ),
      ),
      maxLines: 100,
      minLines: 5,
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
            const Padding(padding: EdgeInsets.all(defaultPadding)),
            const SizedBox(height: defaultPadding / 2),
            ElevatedButton(
              onPressed: () => _addNewOrder(
                  widget.post,
                  infoEditingController.text,
                  descriptionEditingController.text),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  GetX<UserController>(
                      builder: (controller) {
                        return Visibility(
                            visible: controller.isLoading.value,
                            child: LayoutBuilder (
                                builder: (context, constraints) {
                                  return const SpinKitRing(
                                    color: kFillColor,
                                    size: 24.0,
                                  );
                                }
                            )
                        );
                      }
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
                    child: Text("ارسال".toUpperCase(), style: const TextStyle(fontSize: 16)),
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

  Future<void> _addNewOrder(Post post, String skills, String summary) async {
    if (_formKey.currentState!.validate()) {
      Order order = Order.empty();
      order.postID = post.id;
      order.skills = skills;
      order.summary = summary;
      order.userID = App.user.id;
      order.userName = App.user.name;
      order.orderStatus = "pending";
      order.timeApplied = DateTime.now();

      final controller = Get.find<UserController>();

      controller.isLoading.value = true;

      final applied = await OrderDatabase().doesOrderExist(order);
      if (applied) {
        controller.isLoading.value = false;
        Fluttertoast.showToast(
            msg: "لقد قدمت طلب لهذا المنشور بالفعل",
            backgroundColor: Colors.redAccent,
            textColor: kFillColor);
      } else {

        final user = await UserDatabase(post.companyID).getUser(post.companyID);

        if(user == null){
          Fluttertoast.showToast(
              msg: "Could not get company details, try again later",
              backgroundColor: Colors.redAccent,
              textColor: kFillColor);

          controller.isLoading.value = false;
          return;
        }

        await OrderDatabase().createOrder(order.toMap());

        await notification.Notification().sendNotification(
            user,
            PushNotification(title: "طلب جديد", body: "عرضك تلقى طلبا جديدا"));

        controller.isLoading.value = false;

        Get.offAllNamed('/');
      }
    }
  }
}
