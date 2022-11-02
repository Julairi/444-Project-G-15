import 'package:esaa/models/models.dart';
import 'package:esaa/screens/profiles/widgets/tob_bar.dart';
import 'package:flutter/material.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/services.dart';
import '../../../app.dart';
import '../../review_page.dart';
import '../company_profile.dart';
import '../utils/custom_clipper.dart';
import 'package:get/get.dart';

class StackContainer extends StatefulWidget {
  final String imgUrl;
  final String reviewID;
  StackContainer({Key? key, required this.imgUrl, required this.reviewID})
      : super(key: key);

  @override
  StackContainerState createState() => StackContainerState();
}

class StackContainerState extends State<StackContainer> {
  String name = App.user.name;
  @override
  Widget build(BuildContext context) {
    void initState() {
      String name = App.user.name;
      super.initState();
    }

    return Container(
      height: 300.0,
      child: Stack(
        children: <Widget>[
          Container(),
          ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
              height: 300.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://picsum.photos/200"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // ignore: prefer_const_constructors
                CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(this.widget.imgUrl)),
                const SizedBox(height: 4.0),
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
                /*
                GestureDetector(
                    onTap: () => CompanyProfile(),
                    child: Icon(
                      Icons.edit,
                      color: Color.fromARGB(255, 56, 146, 220),
                    )),
                Text(
                  "تعديل الملف الشخصي",
                  style: TextStyle(color: Color.fromARGB(255, 56, 146, 220)),
                ),*/
              ],
            ),
          ),
          const TopBar(),
        ],
      ),
    );
  }
}
