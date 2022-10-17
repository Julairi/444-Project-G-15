import 'package:esaa/config/constants.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/job_seeker_home/view/view.dart';
import 'package:esaa/services/database/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_dialog/rating_dialog.dart';
import '../company_home.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final Post? post;
  final bool showPaymentStatus;

  const OrderCard({required this.order, this.post, this.showPaymentStatus = true,  Key? key}) : super(key: key);

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
                                  post: orderPost!, canApply: false));
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
                              color: order.hasBeenPaid ? Colors.green : Colors.red,
                              fontSize: defaultFontSize,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis)),

                    const SizedBox(
                      height: 20,
                      width: 15,
                    ),

                    if (order.hasBeenPaid == true)
                      GestureDetector(
                        child: const Text("تقييم",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: defaultFontSize,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                overflow: TextOverflow.ellipsis)),
                        onTap: () async {
                          show(context);
                        },
                      ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void show(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return RatingDialog(
              title: const Text(
                'تقييم الخدمة',
                textAlign: TextAlign.center,
              ),
              submitButtonText: 'إرسال',
              enableComment: false,
              onSubmitted: (response) async {
                if (post == null) {
                  //job seeker rates company
                  final post = await PostDatabase().getPost(order.postID);

                  if(post == null) return;

                  UserDatabase(post.companyID).rateUser(response.rating);
                } else {

                  UserDatabase(order.userID).rateUser(response.rating);

                }
              });
        });
  }
}
