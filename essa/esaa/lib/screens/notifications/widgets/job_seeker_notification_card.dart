import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobSeekerNotificationCard extends StatelessWidget {
  final PushNotification notification;
  const JobSeekerNotificationCard({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
        Get.find<UserController>().changePage(1);
      },
      child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 7,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Stack(
            children: [
              Positioned(
                child: Container(
                  height: 50,
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color.fromARGB(255, 105, 110, 112).withOpacity(0),
                            const Color.fromARGB(255, 64, 69, 71).withOpacity(0.2)
                          ],
                          stops: const [0.6, 1]
                      )
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        height: 20,
                        width: 20,
                      ),

                      const Icon(
                        Icons.notifications,
                        color: kPrimaryColor,
                        size: 35,
                      ),

                      const SizedBox(
                        height: 20,
                        width: 20,
                      ),

                      Text(
                          notification.title,
                          style: const TextStyle(
                              color: kPrimaryColor,
                              fontSize: defaultFontSize,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis)
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                  notification.body,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 6, 6, 6),
                      fontSize: 18,
                      fontFamily: 'ElMessiri',
                      overflow: TextOverflow.fade),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
