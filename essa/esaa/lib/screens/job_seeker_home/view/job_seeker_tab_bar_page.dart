import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/company_home/company_home.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect.dart';
import 'package:rating_dialog/rating_dialog.dart';

class JobSeekerTabBarPage extends StatefulWidget {
  const JobSeekerTabBarPage({Key? key}) : super(key: key);

  @override
  JobSeekerTabBarPageState createState() => JobSeekerTabBarPageState();
}

class JobSeekerTabBarPageState extends State<JobSeekerTabBarPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      child: SingleChildScrollView(
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
                            text: 'قيد الانتظار',
                          ),
                          Tab(
                            text: 'مقبولة',
                          ),
                          Tab(
                            text: 'مرفوضة',
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                    controller: tabController,
                    children: const [_TabOne(), _TabTwo(), _TabThree()]),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabOne extends StatelessWidget {
  const _TabOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListView(
      query: OrderDatabase.ordersCollection
          .where("userID", isEqualTo: App.user.id)
          .where("orderStatus", isEqualTo: "pending")
          .orderBy("timeApplied", descending: true),
      emptyListWidget: const SizedBox(
        child: Text(
          'لا يوجد تقديم معلق',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: kPrimaryColor,
          ),
        ),
      ),
      itemBuilder: (context, querySnapshot) {
        Order order = Order.fromDocumentSnapshot(querySnapshot);
        return OrderCard(order: order);
      },
    );
  }
}

class _TabTwo extends StatelessWidget {
  const _TabTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListView(
        query: OrderDatabase.ordersCollection
            .where("userID", isEqualTo: App.user.id)
            .where("orderStatus", isEqualTo: "accepted")
            .orderBy("timeApplied", descending: true),
        emptyListWidget: const SizedBox(
          child: Text(
            'لا يوجد تقديم مقبول',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: kPrimaryColor,
            ),
          ),
        ),
        itemBuilder: (context, querySnapshot) {
          Order order = Order.fromDocumentSnapshot(querySnapshot);
          return OrderCard(order: order);
        });
    // ignore: dead_code
  }
}

class _TabThree extends StatelessWidget {
  const _TabThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListView(
        query: OrderDatabase.ordersCollection
            .where("userID", isEqualTo: App.user.id)
            .where("orderStatus", whereIn: ["rejected", "deleted"]).orderBy(
                "timeApplied",
                descending: true),
        emptyListWidget: const SizedBox(
          child: Text(
            'لا يوجد تقديم مرفوض',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: kPrimaryColor,
            ),
          ),
        ),
        itemBuilder: (context, querySnapshot) {
          Order order = Order.fromDocumentSnapshot(querySnapshot);
          return OrderCard(order: order);
        });
  }
}
