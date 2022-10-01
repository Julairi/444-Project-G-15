import 'package:esaa/config/constants.dart';
import 'package:flutter/material.dart';

class CompanyNotificationCard extends StatelessWidget {
  final String uID;
  final String companyPath;
  final String postTitle;
  final String notification;
  const CompanyNotificationCard({
    super.key,
    required this.uID,
    required this.companyPath,
    required this.postTitle,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                          postTitle,
                          style: const TextStyle(
                              color: kPrimaryColor,
                              fontSize: defaultFontSize,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis))
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Text(
                      notification,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 6, 6, 6),
                          fontSize: 18,
                          fontFamily: 'ElMessiri',
                          overflow: TextOverflow.fade),
                    ),
                  ],
                ),
                TextButton(
                    onPressed: () {
                      /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return conotification_screen();
                          },
                        ),
                      );*/
                    },
                    child: const Text('تفاصيل الطلب')),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
