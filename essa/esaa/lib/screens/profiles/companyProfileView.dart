// ignore_for_file: camel_case_types

import 'package:esaa/screens/profiles/widgets/card_item.dart';
import 'package:esaa/screens/profiles/widgets/stack_container.dart';
import 'package:flutter/material.dart';
import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/services.dart';

import 'company_profile.dart';

class companyProfileView extends StatefulWidget {
  @override
  companyProfileViewState createState() => companyProfileViewState();
}

class companyProfileViewState extends State<companyProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          StackContainer(),
          const SizedBox(height: 10.0),
          Card(
            child: Row(
              children: <Widget>[
                const SizedBox(width: 24.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      "اسم الشركة",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      App.user.name,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Card(
            child: Row(
              children: <Widget>[
                const SizedBox(width: 24.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      "وصف الشركة",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      App.user.description,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Card(
            child: Row(
              children: <Widget>[
                const SizedBox(width: 24.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      "معلومات التواصل",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      App.user.contact,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Card(
            child: Row(
              children: <Widget>[
                const SizedBox(width: 24.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      "المدينة",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      App.user.address,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Card(
            child: Row(
              children: <Widget>[
                const SizedBox(width: 24.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      "ايميل الشركة",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      App.user.email,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CompanyProfile()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit),
                Text(
                  "تعديل الملف الشخصي",
                  style: TextStyle(color: Color.fromARGB(255, 56, 146, 220)),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
