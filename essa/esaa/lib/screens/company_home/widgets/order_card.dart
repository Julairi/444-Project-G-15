import 'dart:convert';
import 'dart:developer';

import 'package:esaa/controllers/controllers.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:http/http.dart' as http;

import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/job_seeker_home/view/view.dart';
import 'package:esaa/services/database/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rating_dialog/rating_dialog.dart';
import '../company_home.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final Post? post;
  final bool showPaymentStatus;
  late Future<Post?> someti;

  OrderCard(
      {required this.order, this.post, this.showPaymentStatus = true, Key? key})
      : super(key: key) {
    Get.put(OrderCardController());
    Get.find<OrderCardController>().bindUserWithID(order.userID);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderCardController>();
    final _formKey = GlobalKey<FormState>();
    return InkWell(
        onTap: () async {
          if (post == null) {
            final orderPost = await PostDatabase().getPost(order.postID);

            Get.to(() =>
                PostDetails(order: order, post: orderPost!, canApply: false));
          } else {
            Get.to(() => OrderDetails(order: order, post: post!));
          }
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
                      decoration: BoxDecoration(color: Colors.transparent),
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            height: 20,
                            width: 20,
                          ),
                          const Icon(
                            Icons.work_outline,
                            color: Colors.black,
                            size: 35,
                          ),
                          const SizedBox(
                            height: 20,
                            width: 10,
                          ),
                          if (App.user.userType == 'company')
                            Text(
                              order.userName,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 6, 6, 6),
                                  fontSize: 18,
                                  fontFamily: 'ElMessiri',
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.fade),
                            ),
                          if (App.user.userType == 'jobSeeker')
                            StreamBuilder<Post>(
                                stream: PostDatabase()
                                    .getPostAsStream(order.postID),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Post?> snapshot) {
                                  // return a widget here (you have to return a widget to the builder)
                                  return Text(
                                    snapshot.data?.title ?? "",
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 6, 6, 6),
                                        fontSize: 18,
                                        fontFamily: 'ElMessiri',
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.fade),
                                  );
                                }),
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
                        GestureDetector(
                          child: const Text("تفاصيل الطلب",
                              style: TextStyle(
                                  color: kSPrimaryColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  overflow: TextOverflow.ellipsis)),
                          onTap: () async {
                            if (post == null) {
                              final orderPost =
                                  await PostDatabase().getPost(order.postID);

                              Get.to(() => PostDetails(
                                  order: order,
                                  post: orderPost!,
                                  canApply: false));
                            } else {
                              Get.to(() =>
                                  OrderDetails(order: order, post: post!));
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                          width: 10,
                        ),
                        const SizedBox(
                          height: 20,
                          width: 10,
                        ),
                        const SizedBox(
                          height: 20,
                          width: 40,
                        ),
                        if (order.orderStatus == "pending" &&
                            App.user.userType == 'jobSeeker')
                          GestureDetector(
                            child: const Text("ألغ تقديمك",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 153, 69, 55),
                                    fontSize: defaultFontSize,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    overflow: TextOverflow.ellipsis)),
                            onTap: () async {
                              await OrderDatabase()
                                  .withdraw(order.postID, order.userID);
                            },
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                      width: 15,
                    ),
                    if (order.orderStatus == "deleted")
                      //const Text("تم حذف هذا المنشور من قبل الشركة",
                      const Text(" محذوف",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: defaultFontSize,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis)),
                    if (order.orderStatus == "accepted" && showPaymentStatus)
                      Text(order.hasBeenPaid ? "تم الدفع" : "لم يتم الدفع",
                          style: TextStyle(
                              color:
                                  order.hasBeenPaid ? Colors.green : Colors.red,
                              fontSize: defaultFontSize,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis)),
                    const SizedBox(
                      height: 20,
                      width: 15,
                    ),
                    if (order.orderStatus == "accepted" && post != null)
                      Builder(builder: (context) {
                        final startDate =
                            DateFormat('yyyy-MM-dd').parse(post!.startDate);
                        final now = DateFormat('yyyy-MM-dd').parse(
                            DateFormat('yyyy-MM-dd').format(DateTime.now()));
                        if (startDate.millisecondsSinceEpoch <=
                                now.millisecondsSinceEpoch &&
                            !order.hasBeenPaid) {
                          return SizedBox(
                            width: 70,
                            height: 40,
                            child: Form(
                              key: _formKey,
                              child: ElevatedButton(
                                onPressed: () => payOrder(order, controller),
                                style: ElevatedButton.styleFrom(
                                    primary: kPrimaryColor,
                                    elevation: 0,
                                    padding: EdgeInsets.zero),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        "ادفع",
                                        style: TextStyle(
                                            color: kFillColor, fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                    if (order.hasBeenPaid == true && showPaymentStatus)
                      GestureDetector(
                        child: const Text("تقييم",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: defaultFontSize,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                overflow: TextOverflow.ellipsis)),
                        onTap: () async {
                          _showReviewDialog(context);
                        },
                      ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void _showReviewDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return RatingDialog(
              title: const Text(
                'تقييم التجربة',
                textAlign: TextAlign.center,
              ),
              commentHint: "اترك تعليقك",
              enableComment: App.user.userType == 'jobSeeker',
              submitButtonText: 'إرسال',
              onSubmitted: (response) async {
                Post? post = this.post;
                post ??= await PostDatabase().getPost(order.postID);

                final uID = App.user.userType == 'jobSeeker'
                    ? post?.companyID
                    : order.userID;

                final hasUserBeenRated =
                    await ReviewDatabase(uID ?? "").hasUserBeenReviewed(
                  orderID: order.id,
                  reviewerID: App.user.id,
                );

                if (hasUserBeenRated) {
                  Fluttertoast.showToast(
                      msg:
                          "لقد قيمت مسبقًا ${App.user.userType == 'jobSeeker' ? "الشركة" : "الباحث عن العمل"}",
                      backgroundColor: Colors.redAccent);
                  return;
                } else {
                  await ReviewDatabase("").createReview(Review(
                    rating: response.rating,
                    uID: uID ?? "",
                    comment: response.comment,
                    orderID: order.id,
                    timePosted: DateTime.now(),
                    reviewerID: App.user.id,
                  ).toMap());
                  Fluttertoast.showToast(msg: "تم إرسال التقييم بنجاح");
                }
              });
        });
  }

  Future<void> payOrder(Order order, OrderCardController controller) async {
    //INSERT PAYING METHOD
    var postID = order.postID;
    Post? myPost = await PostDatabase().getPost(postID);

    var now = DateTime.now();
    var nMon = now.month;
    var nDay = now.day;
    var nYear = now.year;
    var postDate = DateTime.parse(myPost!.startDate);

    var postMon = postDate.month;
    var postDay = postDate.day;
    var postYear = postDate.year;
    if (nYear != postYear) {
      Fluttertoast.showToast(
          msg: "لايمكنك الدفع اللآن حاول لاحقاً بعد تاريخ العمل.",
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black54,
          textColor: kFillColor,
          toastLength: Toast.LENGTH_LONG);
      return;
    }
    if (nMon != postMon) {
      Fluttertoast.showToast(
          msg: "لايمكنك الدفع اللآن حاول لاحقاً بعد تاريخ العمل",
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black54,
          textColor: kFillColor,
          toastLength: Toast.LENGTH_LONG);
      return;
    }
    if (nDay < postDay) {
      Fluttertoast.showToast(
          msg: "لايمكنك الدفع اللآن حاول لاحقاً بعد تاريخ العمل.",
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black54,
          textColor: kFillColor,
          toastLength: Toast.LENGTH_LONG);
      return;
    }

    var postPay = myPost.payPerHour;
    var postNHours = myPost.nHours;

    var fee = postPay;
    var nH = int.parse(postNHours);
    var payDollars = nH * fee * 0.266667;
    var payRiyals = nH * fee;

    if (order.hasBeenPaid) {
      Fluttertoast.showToast(
          msg: "ريالاُ بالفعل $payRiyals لقد دفعت",
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black54,
          textColor: kFillColor,
          toastLength: Toast.LENGTH_LONG);
      return;
    }

    order.hasBeenPaid = true;

    await OrderDatabase().updateOrderDetails({
      "id": order.id,
      "hasBeenPaid": order.hasBeenPaid,
    });

    final orders = await OrderDatabase().getOrders(post!.id);

    int count = 0;

    for (Order order in orders) {
      if (order.hasBeenPaid) count++;
    }

    await PostDatabase().updatePostDetails({
      "id": post!.id,
      "paymentStatus": count == orders.length ? 'all_paid' : 'not_all_paid',
    });

    //PAYMENT COUNT
    final user = await UserDatabase(order.userID).getUser(order.userID);
    var pastm = user?.money;
    var newmoney = pastm! + payRiyals;
    await UserDatabase(order.userID)
        .updateUserDetails({"id": order.userID, "money": newmoney});
    //controller.money = newmoney;

    //Actual payment method
    await _initPayment(amount: payDollars * 100, email: 'email@test.com');
  }
}

class OrderCardController extends UserController {
  double money = 0;
}

Future<void> _initPayment(
    {required String email, required double amount}) async {
  try {
    // 1. Create a payment intent on the server
    final response = await http.post(
        Uri.parse(
            'https://us-central1-esaa-c4278.cloudfunctions.net/stripePaymentIntentRequest'),
        body: {
          'email': email,
          'amount': amount.toString(),
        });
    // Stripe.merchantIdentifier
    final jsonResponse = jsonDecode(response.body);
    log(jsonResponse.toString());
    // 2. Initialize the payment sheet
    await stripe.Stripe.instance.initPaymentSheet(
        paymentSheetParameters: stripe.SetupPaymentSheetParameters(
      paymentIntentClientSecret: jsonResponse['paymentIntent'],
      merchantDisplayName: 'Esaa Flutter App',
      customerId: jsonResponse['customer'],
      customerEphemeralKeySecret: jsonResponse['ephemeralKey'],

      //testEnv: true,
      //merchantCountryCode: 'US',
    ));
    await stripe.Stripe.instance.presentPaymentSheet();
    Fluttertoast.showToast(msg: "Payment Successful");
  } catch (error) {
    if (error is stripe.StripeException) {
      Fluttertoast.showToast(
          msg: "An error occurred ${error.error.localizedMessage}");
    } else {
      Fluttertoast.showToast(msg: "An error occurred $error");
    }
  }
}

Future<bool> _postTime(Order order) async {
  Post? myPost = await PostDatabase().getPost(order.postID);
  var now = DateTime.now();
  var nMon = now.month;
  var nDay = now.day;
  var nYear = now.year;
  var postDate = DateTime.parse(myPost!.startDate);

  var postMon = postDate.month;
  var postDay = postDate.day;
  var postYear = postDate.year;
  if (nYear == postYear) {
    if (nMon == postMon) {
      if (postDay > (nDay + 5) && (postDay) < (nDay + 10)) return true;
    }
  } else {
    return false;
  }

  return false;
}

Future<double> _calcRiyal(Order order) async {
  var postID = order.postID;
  Post? myPost = await PostDatabase().getPost(postID);

  var postPay = myPost!.payPerHour;
  var postNHours = myPost.nHours;
  var fee = postPay;
  var nH = int.parse(postNHours);
  var payRiyals = nH * fee + 0.0;
  return payRiyals;
}
