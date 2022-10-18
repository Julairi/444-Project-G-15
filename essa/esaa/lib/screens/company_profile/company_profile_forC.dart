import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esaa/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:esaa/services/database/user_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaa/services/database/database.dart';
import 'package:esaa/models/post.dart';
import 'package:esaa/app.dart';
import 'package:esaa/services/authentication.dart';
import 'package:esaa/models/user.dart';

class ProfileScreenForC extends StatelessWidget {
  ProfileScreenForC({Key? key}) : super(key: key);

  FirebaseFirestore fireb = FirebaseFirestore.instance;

  Widget textfield({@required hintText}) {
    return Material(
      elevation: 4,
      shadowColor: Color.fromARGB(255, 158, 158, 158),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              letterSpacing: 2,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            fillColor: Color.fromARGB(77, 255, 255, 255),
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("حسابك الشخصي"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 124, 177, 170),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SingleChildScrollView(
                child: Container(
                  height: 450,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 90,
                      ),
                      textfield(
                        hintText: 'Username',
                      ),
                      textfield(
                        hintText: 'Email',
                      ),
                      textfield(
                        hintText: 'Password',
                      ),
                      textfield(
                        hintText: 'Confirm password',
                      ),
                      Container(
                        height: 55,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              primary: kPrimaryColor, elevation: 0),
                          child: Text(
                            "حدث معلوماتك",
                            style: TextStyle(
                              fontSize: 23,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 55,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            Get.find<UserController>().clearAll();
                            await Auth().signOut();
                            Get.offAndToNamed('/welcome_screen');
                          },
                          style: ElevatedButton.styleFrom(
                              primary: kPrimaryColor, elevation: 0),
                          child: Text(
                            "تسجيل الخروج",
                            style: TextStyle(
                              fontSize: 23,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "حسابك الخاص",
                  style: TextStyle(
                    fontSize: 35,
                    letterSpacing: 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/profile.png'),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 270, left: 184),
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<String> GetID() async {
    var current = "";
    if (await Auth().isSignedIn) {
      current = Auth().uID;
    }
    return current;
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color.fromARGB(255, 117, 154, 148);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
