import 'dart:convert';
import 'dart:developer';

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

  const OrderCard(
      {required this.order, this.post, this.showPaymentStatus = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          if (post == null) {
            final orderPost = await PostDatabase().getPost(order.postID);

            Get.to(() => PostDetails(post: orderPost!, canApply: false));
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
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                      "https://i.pinimg.com/474x/6a/d3/66/6ad3663d79ccc962377d7a6cbe4d9bfe.jpg",
                      height: 50,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
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
                            const Color.fromARGB(255, 105, 110, 112)
                                .withOpacity(0),
                            const Color.fromARGB(255, 64, 69, 71)
                                .withOpacity(0.2)
                          ],
                              stops: const [
                            0.6,
                            1
                          ])),
                      child: Row(
                        children: [
                          const SizedBox(
                            height: 20,
                            width: 20,
                          ),
                          const Icon(
                            Icons.work_outline,
                            color: Color.fromARGB(255, 83, 80, 80),
                            size: 35,
                          ),
                          const SizedBox(
                            height: 20,
                            width: 20,
                          ),
                          Text(
                            order.userName,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 6, 6, 6),
                                fontSize: 18,
                                fontFamily: 'ElMessiri',
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.fade),
                          ),
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
                        const Icon(
                          Icons.insights_sharp,
                          color: Color.fromARGB(255, 237, 229, 109),
                        ),
                        const SizedBox(
                          height: 20,
                          width: 10,
                        ),
                        const Icon(
                          Icons.info,
                          color: Color.fromARGB(255, 3, 77, 138),
                        ),
                        const SizedBox(
                          height: 20,
                          width: 10,
                        ),
                        GestureDetector(
                          child: const Text("تفاصيل الطلب",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: defaultFontSize,
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
                            child: ElevatedButton(
                              onPressed: () => payOrder(order),
                              style: ElevatedButton.styleFrom(
                                  primary: kPrimaryColor,
                                  elevation: 0,
                                  padding: EdgeInsets.zero),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      "Pay",
                                      style: TextStyle(
                                          color: kFillColor, fontSize: 16),
                                    ),
                                  ),
                                ],
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
                'تقييم الخدمة',
                textAlign: TextAlign.center,
              ),
              commentHint: "Leave a comment",
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
                          "You have already reviewed this ${App.user.userType == 'jobSeeker' ? "company" : "user"}",
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
                }
              });
        });
  }

  Future<void> payOrder(Order order) async {
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

    //Actual payment method
    await _initPayment(amount: payDollars * 100, email: 'email@test.com');
  }
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
