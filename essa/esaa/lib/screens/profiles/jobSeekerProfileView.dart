// ignore_for_file: camel_case_types

import 'package:esaa/screens/profiles/job_seeker_profile2.dart';
import 'package:esaa/screens/profiles/widgets/card_item.dart';
import 'package:esaa/screens/profiles/widgets/stack_container.dart';
import 'package:flutter/material.dart';
import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import '../../models/order.dart';
import '../../models/post.dart';
import '../company_home/widgets/Activejobs.dart';
import '../company_home/widgets/full_job_list.dart';
import '../company_home/widgets/order_card.dart';
import '../review_page.dart';

class jobSeekerProfileView extends StatefulWidget {
  @override
  jobSeekerProfileViewState createState() => jobSeekerProfileViewState();
}

class jobSeekerProfileViewState extends State<jobSeekerProfileView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          StackContainer(
            imgUrl: App.user.imgUrl,
            reviewID: App.user.id,
            logout: true,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () => Get.to(() => ReviewPage(userID: App.user.id)),
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
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 25,
                ),
                Text(App.user.money.toString() + ' ريال سعودي'),
              ],
            ),
          ),
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
                      "الاسم",
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
                      "الهوية الوطنية",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      App.user.nationalID,
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
                      "تاريخ الميلاد",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      App.user.Bdate,
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
          /* Card(
            child: Row(
              children: <Widget>[
                const SizedBox(width: 24.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      "الجنس",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      App.user.sex,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),*/
          Card(
            child: Row(
              children: <Widget>[
                const SizedBox(width: 24.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      "الإيميل",
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
                MaterialPageRoute(builder: (context) => JobSeekerProfile2()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.edit),
                Text(
                  "تعديل الملف الشخصي",
                  style: TextStyle(color: Color.fromARGB(255, 56, 146, 220)),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 150,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        color: kPrimaryLightColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: TabBar(
                            unselectedLabelColor: kPrimaryColor,
                            labelColor: const Color.fromARGB(255, 75, 73, 73),
                            indicatorColor: Colors.white,
                            indicatorWeight: 2,
                            indicator: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            controller: tabController,
                            tabs: const [
                              Tab(
                                text: 'العروض السابقة',
                              ),
                              Tab(
                                text: 'العروض النشطة',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                        controller: tabController,
                        children: const [ptab(), actab()]),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class ptab extends StatelessWidget {
  const ptab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomListView(
            absoluteSize: 3,
            physics: const NeverScrollableScrollPhysics(),
            query: OrderDatabase.ordersCollection
                .where("userID", isEqualTo: App.user.id)
                .where("orderStatus", isEqualTo: "accepted")
                .where('hasBeenPaid', isEqualTo: true)
                .orderBy("timeApplied", descending: true),
            emptyListWidget: Container(
              margin: const EdgeInsets.only(top: 120, bottom: 100),
              child: const Center(
                child: Text(
                  "لم تنهي أي وظيفة بعد ",
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

              return OrderCard(
                order: order,
                showPaymentStatus: false,
              );
            }),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: TextButton(
            onPressed: () => Get.to(() => const FullJobList()),
            child: const Text(
              'لعرض الكل',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.fade),
            ),
          ),
        ),
      ],
    );
  }
}

class actab extends StatelessWidget {
  const actab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomListView(
            absoluteSize: 3,
            physics: const NeverScrollableScrollPhysics(),
            query: OrderDatabase.ordersCollection
                .where("userID", isEqualTo: App.user.id)
                .where("orderStatus", isEqualTo: "accepted")
                .where('hasBeenPaid', isEqualTo: false)
                .orderBy("timeApplied", descending: true),
            emptyListWidget: Container(
              margin: const EdgeInsets.only(top: 120, bottom: 100),
              child: const Center(
                child: Text(
                  "لا يوجد عروض نشطة",
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
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: TextButton(
            onPressed: () => Get.to(() => const ActiveJobs()),
            child: const Text(
              'لعرض الكل',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.fade),
            ),
          ),
        ),
      ],
    );
  }
}
