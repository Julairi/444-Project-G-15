import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/company_home/company_home.dart';
import 'package:esaa/screens/review_page.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  bool EN = false;
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  saveNewValues() {
    App.user.name = nameController.text;
  }

  void setInitialValues(TextEditingController nameController) {
    nameController.text = App.user.name;
    emailController.text = App.user.email;
  }

  @override
  void initState() {
    setInitialValues(nameController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
        title: const Text("حسابك الشخصي",
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis)),
        showLogout: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              if (App.user.userType == "company")
                Container(
                    margin: const EdgeInsets.all(100.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    width: double.infinity,
                    child: App.user.imgUrl == ''
                        ? const Icon(
                            Icons.person,
                            size: 80,
                            color: Colors.white,
                          )
                        : Image.network(App.user.imgUrl)),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                elevation: 6,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: kPrimaryColor,
                        size: 28,
                      ),
                      Expanded(
                          child: TextFormField(
                        controller: nameController,
                        //enabled: EN,
                        //initialValue: App.user.name,
                        onSaved: (newValue) =>
                            nameController.text = newValue!.trim().toString(),
                        validator: (val) => val!.trim().isEmpty
                            ? 'يجب ان يكون الاسم اكثر من ثلاث أحرف'
                            : null,
                        onChanged: (val) => setState(() {
                          EN = true;
                        }),
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          //overflow: TextOverflow.ellipsis
                        ),
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                elevation: 6,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.email,
                        color: kPrimaryColor,
                        size: 25,
                      ),
                      Expanded(
                        child: TextFormField(
                          initialValue: App.user.email,
                          enabled: false,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis),
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (App.user.userType == "company")
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  elevation: 6,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
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
                        Text(App.user.contact,
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              if (App.user.userType == "company")
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  elevation: 6,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.note,
                          color: kPrimaryColor,
                          size: 28,
                        ),
                        const SizedBox(
                          height: 20,
                          width: 15,
                        ),
                        Text(App.user.description,
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              if (App.user.userType == "company")
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  elevation: 6,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.pin_drop,
                          color: kPrimaryColor,
                          size: 28,
                        ),
                        const SizedBox(
                          height: 20,
                          width: 15,
                        ),
                        Text(App.user.address,
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 30),
//===================== update btn===============================
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: EN ? saveNewValues() : null,
                  style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor, elevation: 0),
                  child: const Text(
                    "حفظ التغييرات",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              if (App.user.userType == "jobSeeker")
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "الوظائف السابقة",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              if (App.user.userType == "jobSeeker")
                CustomListView(
                    absoluteSize: 3,
                    physics: const NeverScrollableScrollPhysics(),
                    query: OrderDatabase.ordersCollection
                        .where("userID", isEqualTo: App.user.id)
                        .where("orderStatus", isEqualTo: "accepted")
                        .orderBy("timeApplied", descending: true),
                    emptyListWidget: Container(
                      margin: const EdgeInsets.only(top: 120, bottom: 100),
                      child: const Center(
                        child: Text(
                          "لا يوجد وظائف سابقة",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    itemBuilder: (context, querySnapshot) {
                      Order order = Order.fromDocumentSnapshot(querySnapshot);
                      return OrderCard(order: order, showPaymentStatus: false);
                    }),
              if (App.user.userType == "jobSeeker")
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextButton(
                    onPressed: () => Get.to(() => const FullJobList()),
                    child: const Text(
                      'عرض المزيد',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.fade),
                    ),
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GetX<UserController>(
                      builder: (controller) {
                        return RatingBar.builder(
                          initialRating: _sumRating(App.reviews),
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          ),
                          ignoreGestures: true,
                          onRatingUpdate: (double value) {},
                        );
                      }
                  ),

                  const SizedBox(width: 10),

                  GetX<UserController>(
                      builder: (controller) {
                        return Text(
                          '(${App.reviews.isNotEmpty ? App.reviews.length : 'No ratings yet'})',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: App.reviews.isNotEmpty ? 24 : 16,
                              fontWeight: FontWeight.w500
                          ),
                        );
                      }
                  )
                ],
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () => Get.to(() => ReviewPage(userID: App.user.id)),
                    child: const Text(
                      "See reviews",
                      style: TextStyle(
                          fontSize: 18,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),              const SizedBox(height: 10),
            ],
          ),
        ));
  }

  double _sumRating(List<Review> reviews) {
    double totalValue = 0;
    for(Review review in reviews){
      totalValue = totalValue + review.rating;
    }

    if(totalValue == 0 || reviews.isEmpty) return 0;

    return totalValue / reviews.length;
  }
}