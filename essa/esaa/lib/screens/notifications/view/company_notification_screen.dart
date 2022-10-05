import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/database/database.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class CompanyNotificationScreen extends StatelessWidget {

  const CompanyNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      showLeading: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              width: 20,
              height: 30,
            ),

            CustomListView(
                query: PushNotificationDatabase.pushNotificationsCollection
                    .where("uID", isEqualTo: App.user.id)
                    .orderBy("timeSent", descending: true),
                emptyListWidget: const SizedBox(
                  child: Text(
                    'No notification yet',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                itemBuilder: (context, querySnapshot) {
                  PushNotification notification = PushNotification.fromDocumentSnapshot(querySnapshot);
                  return CompanyNotificationCard(notification: notification);
                }
            ),
          ],
        )
      ),
    );
  }
}
