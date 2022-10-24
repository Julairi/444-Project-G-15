import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/company_home/company_home.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/PaidJobOffersCard.dart';

class CompanyTabBarPage extends StatefulWidget {
  const CompanyTabBarPage({Key? key}) : super(key: key);

  @override
  CompanyTabBarPageState createState() => CompanyTabBarPageState();
}

class CompanyTabBarPageState extends State<CompanyTabBarPage>
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
      title: const Text(" عروضي",
          style: TextStyle(
              color: kPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis)),
      showNotification: true,
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
                        indicatorWeight: 3,
                        indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        controller: tabController,
                        tabs: [
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'عروض قيد الانتظار',
                                  style: TextStyle(fontSize: 9),
                                ),
                                const SizedBox(width: defaultPadding),
                                SizedBox(
                                  child: FirestoreQueryBuilder<Object?>(
                                    query: PostDatabase.postsCollection
                                        .where("companyID",
                                            isEqualTo: App.user.id)
                                        .where("offerStatus",
                                            whereIn: ["pending", "assigned"]),
                                    builder: (context, snapshot, _) {
                                      if (snapshot.isFetching) {
                                        return const SpinKitRing(
                                          color: kPrimaryColor,
                                          size: 24.0,
                                        );
                                      }

                                      if (snapshot.hasError) {
                                        Fluttertoast.showToast(
                                            msg: '${snapshot.error}');
                                      }

                                      final count = snapshot.docs.length;

                                      return Text(
                                        "$count",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: kPrimaryColor,
                                            fontSize: 12),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'عروض تم اسنادها',
                                  style: TextStyle(fontSize: 10.4),
                                ),
                                const SizedBox(width: 11),
                                FirestoreQueryBuilder<Object?>(
                                  query: PostDatabase.postsCollection
                                      .where("companyID",
                                          isEqualTo: App.user.id)
                                      .where("offerStatus", whereIn: [
                                    "assigned",
                                    "fully_assigned"
                                  ]),
                                  builder: (context, snapshot, _) {
                                    if (snapshot.isFetching) {
                                      return const SpinKitRing(
                                        color: kPrimaryColor,
                                        size: 24.0,
                                      );
                                    }

                                    if (snapshot.hasError) {
                                      Fluttertoast.showToast(
                                          msg: '${snapshot.error}');
                                    }

                                    final count = snapshot.docs.length;

                                    return Text(
                                      "$count",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: kPrimaryColor,
                                          fontSize: 12),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'الطلبات المدفوعة',
                                  style: TextStyle(fontSize: 10.5),
                                ),
                                const SizedBox(width: 8),
                                FirestoreQueryBuilder<Object?>(
                                  query: OrderDatabase.ordersCollection
                                      .where("companyID",
                                          isEqualTo: App.user.id)
                                      .where("orderStatus",
                                          isEqualTo:
                                              "accepted") // do we need it?
                                      .where("hasBeenPaid", isEqualTo: true),
                                  builder: (context, snapshot, _) {
                                    if (snapshot.isFetching) {
                                      return const SpinKitRing(
                                        color: kPrimaryColor,
                                        size: 24.0,
                                      );
                                    }

                                    if (snapshot.hasError) {
                                      Fluttertoast.showToast(
                                          msg: '${snapshot.error}');
                                    }

                                    final count = snapshot.docs.length;

                                    return Text(
                                      "$count",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: kPrimaryColor,
                                          fontSize: 13),
                                    );
                                  },
                                )
                              ],
                            ),
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
      query: PostDatabase.postsCollection
          .where("companyID", isEqualTo: App.user.id)
          .where("offerStatus", whereIn: ["pending", "assigned"]).orderBy(
              "timePosted",
              descending: true),
      emptyListWidget: const SizedBox(
        child: Text(
          'ليس هناك عروض غير مسنودة',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: kPrimaryColor,
          ),
        ),
      ),
      itemBuilder: (context, querySnapshot) {
        Post post = Post.fromDocumentSnapshot(querySnapshot);
        return PostCardCompany(
            post: post, filters: const ["pending", "assigned"]);
      },
    );
  }
}

class _TabTwo extends StatelessWidget {
  const _TabTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListView(
        query: PostDatabase.postsCollection
            .where("companyID", isEqualTo: App.user.id)
            .where("offerStatus", whereIn: [
          "assigned",
          "fully_assigned"
        ]).orderBy("timePosted", descending: true),
        emptyListWidget: const SizedBox(
          child: Text(
            'لبس هناك عروض مسنودة',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: kPrimaryColor,
            ),
          ),
        ),
        itemBuilder: (context, querySnapshot) {
          Post post = Post.fromDocumentSnapshot(querySnapshot);
          return PostCardCompany(post: post, filters: const ["accepted"]);
        });
  }
}

class _TabOne2 extends StatelessWidget {
  const _TabOne2({Key? key}) : super(key: key);

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

class _TabThree extends StatelessWidget {
  const _TabThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListView(
      query: OrderDatabase.ordersCollection
          .where("companyID", isEqualTo: App.user.id)
          .where("orderStatus", isEqualTo: "accepted") // do we need it?
          .where("hasBeenPaid", isEqualTo: true)
          .orderBy("timeApplied", descending: true),
      emptyListWidget: const SizedBox(
        child: Text(
          'ليس هناك عروض مدفوعة',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: kPrimaryColor,
          ),
        ),
      ),
      itemBuilder: (context, querySnapshot) {
        Order order = Order.fromDocumentSnapshot(querySnapshot);
        return PaidOrderCard(order: order);
      },
    );
  }
}
