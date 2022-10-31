import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/company_home/company_home.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

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
    tabController = TabController(length: 2, vsync: this);
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
                                  style: TextStyle(fontSize: 12),
                                ),
                                const SizedBox(width: 11),

                                // المفروض تنحذف ؟
                                FirestoreQueryBuilder<Object?>(
                                  query: PostDatabase.postsCollection
                                      .where("companyID",
                                      isEqualTo: App.user.id)
                                      .where("offerStatus", isEqualTo: "fully_assigned"),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                    controller: tabController,
                    children: const [_TabOne(), _TabTwo()]),
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Container(
                height: 45,
                decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: TabBar(
                      indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      tabs: const [
                        Tab(text: 'تحتاج للدفع'),

                        Tab(text: ' مدفوعة'),

                        Tab(text: 'لا تحتاج للدفع'),
                      ]),
                ),
              ),
              const SizedBox(height: 10),

              Expanded(
                child: SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: TabBarView(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: kPrimaryLightColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: const AvailableUnpaidOrders(),
                          ),

                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: kPrimaryLightColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: const UnpaidOrders(),
                          ),

                          Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: kPrimaryLightColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const PaidOrders()

                            //child:// NoNeedToPayOffers(),
                          )
                        ])
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
}

//SubTab تحتاج الدفع

class AvailableUnpaidOrders extends StatelessWidget {
  const AvailableUnpaidOrders({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return _FilteredListView(filter: (querySnapshot){
      Post post = Post.fromDocumentSnapshot(querySnapshot);
      final startDate = DateFormat('yyyy-MM-dd').parse(post.startDate);
      final now = DateFormat('yyyy-MM-dd').parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
      if(startDate.millisecondsSinceEpoch <= now.millisecondsSinceEpoch && post.paymentStatus != "all_paid"){
        return true;
      }
      return false;
    });
  }
}

//SubTab مدفوعة
class UnpaidOrders extends StatelessWidget {
  const UnpaidOrders({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _FilteredListView(filter: (querySnapshot){
      Post post = Post.fromDocumentSnapshot(querySnapshot);
      final startDate = DateFormat('yyyy-MM-dd').parse(post.startDate);
      final now = DateFormat('yyyy-MM-dd').parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
      if(startDate.millisecondsSinceEpoch > now.millisecondsSinceEpoch && post.paymentStatus != "all_paid"){
        return true;
      }
      return false;
    });
  }
}

//SubTab لا تحتاج للدفع

class PaidOrders extends StatelessWidget {
  const PaidOrders ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  _FilteredListView(filter: (querySnapshot) {
      Post post = Post.fromDocumentSnapshot(querySnapshot);
      if(post.paymentStatus == "all_paid"){
        return true;
      }
      return false;
    });
  }
}

class _FilteredListView extends StatelessWidget {
  final bool Function(DocumentSnapshot snapshot) filter;
  const _FilteredListView({required this.filter, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder(
        query:  PostDatabase.postsCollection
            .where("companyID", isEqualTo: App.user.id)
            .where("offerStatus", isEqualTo: "fully_assigned")
            .orderBy("timePosted", descending: true),
        pageSize: 10,
        builder: (context, snapshot, _){

          if (snapshot.isFetching) {
            return const Center(
              child: SizedBox(
                  height: 50,
                  width: 50,
                  child: SpinKitRing(
                    color: kPrimaryColor,
                    size: 50.0,
                  )
              ),
            );
          }

          if (snapshot.hasError) {
            return errorBuilder(
              context,
              snapshot.error!,
              snapshot.stackTrace!,
            );
          }

          if(snapshot.docs.isEmpty){
            return emptyListBuilder(context);
          }

          bool result = false;
          for(DocumentSnapshot querySnapshot in snapshot.docs){
            result = filter(querySnapshot);

            if(result) break;
          }

          if(!result) return emptyListBuilder(context);

          return ListView.builder(
            itemCount: snapshot.docs.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final isLastItem = index + 1 == snapshot.docs.length;
              if (isLastItem && snapshot.hasMore) snapshot.fetchMore();

              final doc = snapshot.docs[index];
              return itemBuilder(context, doc, filter);
            },
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
          );
        }
    );
  }


  Widget errorBuilder(BuildContext context, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print(error.toString());
    }

    Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0
    );

    return Container();
  }

  Widget emptyListBuilder(BuildContext context){
    return const SizedBox(
      height: 200,
      child: Center(
        child: Text(
          'لبس هناك عروض مسنودة',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, DocumentSnapshot querySnapshot, bool Function(DocumentSnapshot<Object?> snapshot) filter){
    Post post = Post.fromDocumentSnapshot(querySnapshot);
    if(filter(querySnapshot)){
      return PostCardCompany(post: post, filters: const ["accepted"], skipDetails: post.paymentStatus != 'all_paid');
    }else {
      return const SizedBox();
    }
  }

}


