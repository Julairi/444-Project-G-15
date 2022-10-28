import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../models/order.dart';
import '../company_home/widgets/full_job_list.dart';
import '../company_home/widgets/order_card.dart';

class ProfileScreen extends StatefulWidget {
  profileScreenState createState() => profileScreenState();
}

class profileScreenState extends State<ProfileScreen> {
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

  void initState() {
    setInitialValues(nameController);
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
        logout: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              if (App.user.userType == "company")
                Container(
                    margin: EdgeInsets.all(100.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    width: double.infinity,
                    child: App.user.imgUrl == ''
                        ? Icon(
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
                        decoration: new InputDecoration(
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
                          decoration: new InputDecoration(
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
                      size: 18,
                    ),
                    ignoreGestures: true,
                    onRatingUpdate: (double value) {},
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '(${App.user.rates.isNotEmpty ? App.user.rates.length : 'لايوجد تقييمات'})',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: App.user.rates.isNotEmpty ? 24 : 16,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ));
  }

  double _sumRating(List<dynamic> rates) {
    double totalValue = 0;
    for (double rating in rates) {
      totalValue = totalValue + rating;
    }

    if (totalValue == 0 || rates.isEmpty) return 0;

    return totalValue / rates.length;
  }
}
