import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
        showNotification: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),

              Card(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12)
                  )
                ),
                elevation: 6,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: kPrimaryColor,
                        size: 28,
                      ),

                      const SizedBox(
                        height: 20,
                        width: 15,
                      ),

                      Text(
                          App.user.name,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis
                          )
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Card(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12)
                  )
                ),
                elevation: 6,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.email,
                        color: kPrimaryColor,
                        size: 28,
                      ),

                      const SizedBox(
                        height: 20,
                        width: 15,
                      ),

                      Text(
                          App.user.email,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis
                          )
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              if(App.user.userType == "jobSeeker")
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12)
                    )
                  ),
                  elevation: 6,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.male,
                          color: kPrimaryColor,
                          size: 28,
                        ),

                        const SizedBox(
                          height: 20,
                          width: 15,
                        ),

                        Text(
                            App.user.sex,
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis
                            )
                        ),
                      ],
                    ),
                  ),
                ),

              if(App.user.userType == "company")
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12)
                    )
                  ),
                  elevation: 6,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.contact_phone,
                          color: kPrimaryColor,
                          size: 28,
                        ),

                        const SizedBox(
                          height: 20,
                          width: 15,
                        ),

                        Text(
                            App.user.contact,
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis
                            )
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 30),

              RatingBar.builder(
                initialRating: _sumRating(App.user.rates),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                ignoreGestures: true,
                onRatingUpdate: (double value) {},
              ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () async {
                    Get.find<UserController>().clearAll();
                    await Auth().signOut();
                    Get.offAndToNamed('/welcome_screen');
                  },
                  style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor, elevation: 0),
                  child: const Text(
                    "تسجيل الخروج",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  double _sumRating(List<dynamic> rates) {
    double totalValue = 0;
    for(double rating in rates){
      totalValue = totalValue + rating;
    }

    return totalValue / rates.length;
  }
}
