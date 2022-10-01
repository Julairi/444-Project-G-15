import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class OrderDetails extends StatelessWidget {
  final Order order;
  final Post post;

  OrderDetails({required this.order, required this.post, Key? key})
      : super(key: key) {
    Get.put(OrderDetailsController());
    Get.find<OrderDetailsController>().bindUserWithID(order.userID);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderDetailsController>();
    return CustomAppbar(
      showLeading: true,
      child: SingleChildScrollView(
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
                        size: 40,
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
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            const SizedBox(
                              height: 20,
                              width: 8,
                            ),
                            const Icon(
                              Icons.email,
                              color: Colors.black26,
                              size: 24,
                            ),
                            const SizedBox(
                              height: 20,
                              width: 12,
                            ),
                            GetX<OrderDetailsController>(builder: (controller) {
                              return Text(
                                controller.user.value.email,
                                style: const TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: defaultFontSize,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis),
                              );
                            })
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            const SizedBox(
                              height: 20,
                              width: 8,
                            ),
                            const Icon(
                              Icons.male,
                              color: Colors.black26,
                              size: 24,
                            ),
                            const SizedBox(
                              height: 20,
                              width: 12,
                            ),
                            GetX<OrderDetailsController>(builder: (controller) {
                              return Text(
                                controller.user.value.sex,
                                style: const TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: defaultFontSize,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis),
                              );
                            })
                          ],
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
                          Text("Skills",
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
                          Text("Summary",
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
                  const SizedBox(height: 30),
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
                                    "Reject",
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
                                    "Accept",
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
                              order.hasBeenPaid ? "Paid" : "Pay",
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
      )),
    );
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 30),
                    const Text(
                      "Are you sure you want to accept this request?",
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
                                  "Cancel",
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
                                  "Accept",
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 30),
                    const Text(
                      "Are you sure you want to reject this request?",
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
                                  "Reject",
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
                                  "Cancel",
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
          msg:
              "You have accepted the maximum number of applicants for this post.",
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
    });

    controller.isAccepting.value = false;

    Get.offAllNamed("home");
  }

  void _rejectOrder(Order order, OrderDetailsController controller) async {
    controller.isRejecting.value = true;

    order.orderStatus = 'rejected';
    await OrderDatabase()
        .updateOrderDetails({'id': order.id, 'orderStatus': order.orderStatus});

    controller.isRejecting.value = false;

    Get.offAllNamed("/");
  }

  Future<void> payOrder(Order order) async {
    //INSERT PAYING METHOD
    var postID = order.postID;
    Post? myPost = await PostDatabase().getPost(postID);

    var postPay = myPost!.payPerHour;
    var postnH = myPost!.nHours;

    var fee = int.parse(postPay);
    var nH = int.parse(postnH);
    var payDollars = nH * fee / 3.75;
    var payRiyals = nH * fee;

    if (order.hasBeenPaid) {
      Fluttertoast.showToast(
          msg: "You have paid $payRiyals riyals for this order already.",
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
    Fluttertoast.showToast(msg: "Payment Successful");

    //actual payment
  }
}

class OrderDetailsController extends UserController {
  RxBool isAccepting = false.obs;
  RxBool isRejecting = false.obs;
}
