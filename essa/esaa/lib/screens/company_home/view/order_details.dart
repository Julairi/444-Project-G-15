import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/company_home/company_home.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/services.dart';
import 'package:esaa/services/notification.dart' as notification;

class OrderDetails extends StatelessWidget {
  final Order order;
  final Post post;

  OrderDetails({required this.order, required this.post, Key? key})
      : super(key: key) {
    Get.put(OrderDetailsController());
    Get.find<OrderDetailsController>().bindUserWithID(order.userID);
    Get.find<OrderDetailsController>().bindReviewsWithID(order.userID);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderDetailsController>();
    // ignore: unused_local_variable
    var riyals = _calcRiyal(order);
    return CustomAppbar(
        title: const Text("تفاصيل الطلب ",
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis)),
        showLeading: true,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 22, 126, 210),
                          size: 35,
                        ),
                        const SizedBox(
                          height: 20,
                          width: 12,
                        ),
                        GetX<OrderDetailsController>(builder: (controller) {
                          return Text(
                            controller.user.value.name,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.fade),
                          );
                        }),
                        const Expanded(child: SizedBox()),
                        TextButton(
                          onPressed: () =>
                              Get.to(() => const CompanyJobSeekerProfile()),
                          child: const Text(
                            'عرض الملف الشخصي',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.normal,
                                overflow: TextOverflow.fade),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            SizedBox(width: 5),
                            Icon(Icons.workspace_premium,
                                color: Color.fromARGB(255, 237, 229, 109),
                                size: 28),
                            SizedBox(width: 5),
                            Text(":المهارات",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: defaultFontSize,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis))
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const SizedBox(width: 20),
                            Text(order.skills,
                                style: const TextStyle(
                                    color: Colors.black26,
                                    fontSize: defaultFontSize,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis))
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            SizedBox(width: 5),
                            Icon(Icons.book,
                                color: Color.fromARGB(255, 237, 229, 109),
                                size: 28),
                            SizedBox(width: 5),
                            Text(":النبذة التعريفية",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: defaultFontSize,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis))
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const SizedBox(width: 20),
                            Text(order.summary,
                                style: const TextStyle(
                                    color: Colors.black26,
                                    fontSize: defaultFontSize,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis))
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    if (order.orderStatus == "pending")
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () =>
                                  showRejectDialog(context, controller),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red, elevation: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GetX<OrderDetailsController>(
                                      builder: (controller) {
                                    return Visibility(
                                        visible: controller.isRejecting.value,
                                        child: LayoutBuilder(
                                            builder: (context, constraints) {
                                          return const SpinKitRing(
                                            color: kFillColor,
                                            size: 24.0,
                                          );
                                        }));
                                  }),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      "ارفض",
                                      style: TextStyle(
                                          color: kFillColor, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () =>
                                  showAcceptDialog(context, controller),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green, elevation: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GetX<OrderDetailsController>(
                                      builder: (controller) {
                                    return Visibility(
                                        visible: controller.isAccepting.value,
                                        child: LayoutBuilder(
                                            builder: (context, constraints) {
                                          return const SpinKitRing(
                                            color: kFillColor,
                                            size: 24.0,
                                          );
                                        }));
                                  }),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      "اقبل",
                                      style: TextStyle(
                                          color: kFillColor, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (order.orderStatus == "accepted")
                      ElevatedButton(
                        onPressed: () => payOrder(order),
                        style: ElevatedButton.styleFrom(
                            primary: order.hasBeenPaid
                                ? kPrimaryColor.withOpacity(0.5)
                                : kPrimaryColor,
                            elevation: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                order.hasBeenPaid ? "تم الدفع" : "ادفع",
                                style: const TextStyle(
                                    color: kFillColor, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 20),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void showAcceptDialog(
      BuildContext context, OrderDetailsController controller) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                width: 300,
                height: 200,
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(height: 30),
                          const Text(
                            "هل أنت متأكد برغبتك بقبول هذا الطلب؟",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  onPressed: () => Get.back(),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red, elevation: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "الغاء",
                                        style: TextStyle(
                                            color: kFillColor, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30),
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                    _acceptOrder(order, post, controller);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green, elevation: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "اقبل",
                                        style: TextStyle(
                                            color: kFillColor, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            contentPadding: const EdgeInsets.all(15),
          );
        });
  }

  void showRejectDialog(
      BuildContext context, OrderDetailsController controller) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                width: 300,
                height: 200,
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        "هل أنت متأكد أنك تريد رفض هذا العرض",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                                _rejectOrder(order, controller);
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red, elevation: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "رفض",
                                    style: TextStyle(
                                        color: kFillColor, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () => Get.back(),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green, elevation: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "إلغاء",
                                    style: TextStyle(
                                        color: kFillColor, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            contentPadding: const EdgeInsets.all(15),
          );
        });
  }

  void _acceptOrder(
      Order order, Post post, OrderDetailsController controller) async {
    if (int.parse(post.maxNoOfApplicants) <=
        int.parse(post.acceptedApplicants)) {
      Fluttertoast.showToast(
          msg: "لقد قبلت بالفعل العدد الاقصى من الموظفين",
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.redAccent,
          textColor: kFillColor,
          toastLength: Toast.LENGTH_LONG);
      return;
    }

    controller.isAccepting.value = true;

    order.orderStatus = 'accepted';
    await OrderDatabase()
        .updateOrderDetails({'id': order.id, 'orderStatus': order.orderStatus});

    await ConversationDatabase().createConversation(Conversation(
            title:
                "${controller.user.value.name}//${App.user.name}//${post.title}",
            orderID: order.id,
            members: [
              controller.user.value.id,
              App.user.id,
            ],
            messages: [],
            lastUpdated: DateTime.now())
        .toMap());

    await notification.Notification().sendNotification(
        Get.find<OrderDetailsController>().user.value,
        PushNotification(
            title: "طلب مقبول من قبل شركة ${post.companyName}",
            body: "يسرناإعلامك بقبول طلبك لوظيفة ${post.title}"));

    post.offerStatus = "assigned";
    post.acceptedApplicants = '${(int.parse(post.acceptedApplicants) + 1)}';

    if (int.parse(post.maxNoOfApplicants) <=
        int.parse(post.acceptedApplicants)) {
      post.offerStatus = "fully_assigned";
      await OrderDatabase().rejectAll(post.id);
    }

    await PostDatabase().updatePostDetails({
      'id': post.id,
      'offerStatus': post.offerStatus,
      'acceptedApplicants': post.acceptedApplicants,
      "paymentStatus": 'not_all_paid',
    });

    controller.isAccepting.value = false;

    Get.offAllNamed("home");
  }

  void _rejectOrder(Order order, OrderDetailsController controller) async {
    controller.isRejecting.value = true;

    order.orderStatus = 'rejected';
    await OrderDatabase()
        .updateOrderDetails({'id': order.id, 'orderStatus': order.orderStatus});

    await notification.Notification().sendNotification(
        Get.find<OrderDetailsController>().user.value,
        PushNotification(
            title: "  طلب مرفوض من قبل شركة ${post.companyName}",
            body: "يؤسفناإعلامك برفضك لوظيفة ${post.title}"));

    controller.isRejecting.value = false;

    Get.offAllNamed("/");
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

    final orders = await OrderDatabase().getOrders(post.id);

    int count = 0;

    for (Order order in orders) {
      if (order.hasBeenPaid) count++;
    }

    await PostDatabase().updatePostDetails({
      "id": post.id,
      "paymentStatus": count == orders.length ? 'all_paid' : 'not_all_paid',
    });

    //Actual payment method
    await _initPayment(amount: payDollars * 100, email: 'email@test.com');
  }
}

class OrderDetailsController extends UserController {
  RxBool isAccepting = false.obs;
  RxBool isRejecting = false.obs;
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
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: jsonResponse['paymentIntent'],
      merchantDisplayName: 'Esaa Flutter App',
      customerId: jsonResponse['customer'],
      customerEphemeralKeySecret: jsonResponse['ephemeralKey'],

      //testEnv: true,
      //merchantCountryCode: 'US',
    ));
    await Stripe.instance.presentPaymentSheet();
    Fluttertoast.showToast(msg: "Payment Successful");
  } catch (error) {
    if (error is StripeException) {
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
