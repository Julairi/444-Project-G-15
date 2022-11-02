import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/company_home/company_home.dart';
import 'package:esaa/screens/edit_post/edit_post.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/database/database.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CompanyPostDetails extends StatefulWidget {
  final Post post;
  final List<String> filters;

  CompanyPostDetails({required this.post, required this.filters, Key? key})
      : super(key: key) {
    Get.put(CompanyPostDetailsController());
  }

  @override
  State<CompanyPostDetails> createState() => _CompanyPostDetailsState();
}

class _CompanyPostDetailsState extends State<CompanyPostDetails> {
  @override
  void initState() {
    _getEditable(widget.post);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CompanyPostDetailsController>();

    controller.isLoading.value = false;

    return CustomAppbar(
      title: const Text("تفاصيل المنشور",
          style: TextStyle(
              color: kPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis)),
      showLeading: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        /*  GetX<CompanyPostDetailsController>(
                            builder: (controller) {
                          return IconButton(
                            onPressed: () => _edit(widget.post),
                            icon: Icon(
                              Icons.edit,
                              color: controller.editable.value
                                  ? Colors.blueAccent
                                  //: Colors.grey,
                                  : Colors.blueAccent.withOpacity(0.1),
                              size: 30,
                            ),
                          );
                        }),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () => showConfirmDeletingDialog(context),
                          icon: Icon(
                            Icons.delete,
                            color: int.parse(widget.post.acceptedApplicants) > 0
                                // ? Colors.grey
                                ? Colors.redAccent.withOpacity(0.1)
                                : Colors.redAccent,
                            size: 30,
                          ),
                        ),*/
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.work_outline_outlined,
                          color: kSPrimaryColor,
                          size: 40,
                        ),
                        const SizedBox(
                          height: 20,
                          width: 12,
                        ),
                        Text(
                          widget.post.title,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.fade),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          '  وصف العمل :\n ${widget.post.description}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: defaultFontSize,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.people_alt,
                              color: kSPrimaryColor,
                              size: 30,
                            ),
                            const SizedBox(
                              height: 20,
                              width: 10,
                            ),
                            Text(
                              '${widget.post.maxNoOfApplicants} موظفين مطلوبين',
                              style: const TextStyle(
                                  color: KGrey,
                                  fontSize: defaultFontSize,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.fade),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                          width: 15,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined,
                                color: kSPrimaryColor, size: 30),
                            const SizedBox(
                              height: 20,
                              width: 10,
                            ),
                            Text(widget.post.city,
                                style: const TextStyle(
                                    color: KGrey,
                                    fontSize: defaultFontSize,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis)),
                            const SizedBox(
                              height: 20,
                              width: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                      width: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_month_outlined,
                                color: kSPrimaryColor, size: 30),
                            const SizedBox(
                              height: 20,
                              width: 10,
                            ),
                            Text(
                              '${_getDate(widget.post.startDate)} - ${_getDate(widget.post.endDate)}',
                              style: const TextStyle(
                                  color: KGrey,
                                  fontSize: defaultFontSize,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.fade),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                          width: 5,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.timer_outlined,
                              color: kSPrimaryColor,
                              size: 30,
                            ),
                            const SizedBox(
                              height: 20,
                              width: 10,
                            ),
                            Text(widget.post.time,
                                style: const TextStyle(
                                    color: KGrey,
                                    fontSize: defaultFontSize,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis)),
                            const SizedBox(
                              height: 35,
                              width: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                      width: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.payments,
                              color: kSPrimaryColor,
                              size: 30,
                            ),
                            const SizedBox(
                              height: 20,
                              width: 10,
                            ),
                            Text(
                              '${widget.post.payPerHour} لكل ساعة عمل',
                              style: const TextStyle(
                                  color: KGrey,
                                  fontSize: defaultFontSize,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                          width: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.hourglass_bottom_outlined,
                              color: kSPrimaryColor,
                              size: 30,
                            ),
                            const SizedBox(
                              height: 20,
                              width: 10,
                            ),
                            Text(
                              '${widget.post.nHours}  ساعات  ',
                              style: const TextStyle(
                                  color: KGrey,
                                  fontSize: defaultFontSize,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: (widget.post.offerStatus == "pending" ||
                                          widget.post.offerStatus ==
                                              "assigned") &&
                                      int.parse(
                                              widget.post.acceptedApplicants) >
                                          0
                                  ? kPrimaryColor
                                  : Colors.grey.withOpacity(0.4)),
                          onPressed: () {
                            if ((widget.post.offerStatus == "pending" ||
                                    widget.post.offerStatus == "assigned") &&
                                int.parse(widget.post.acceptedApplicants) > 0) {
                              Get.to(() => PostOrders(
                                  post: widget.post,
                                  filters: const ['pending']));
                            } else {
                              Fluttertoast.showToast(
                                  msg: "لايوجد طلبات قيد الانتظار بعد",
                                  backgroundColor: Colors.redAccent,
                                  toastLength: Toast.LENGTH_LONG,
                                  textColor: kFillColor);
                            }
                          },
                          child: const Text(
                            "عرض الطلبات قيد الانتظار",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: defaultFontSize,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: widget.post.offerStatus == "assigned"
                                  ? kFillColor
                                  : Colors.grey.withOpacity(0.4)),
                          onPressed: () {
                            if (widget.post.offerStatus == "assigned") {
                              Get.to(() => PostOrders(
                                  post: widget.post,
                                  filters: const ['accepted']));
                            } else {
                              Fluttertoast.showToast(
                                  msg: "لايوجد طلبات مقبولة بعد",
                                  backgroundColor: Colors.redAccent,
                                  toastLength: Toast.LENGTH_LONG,
                                  textColor: kFillColor);
                            }
                          },
                          child: const Text(
                            'عرض الطلبات المقبولة',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: defaultFontSize,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, //Center Row contents horizontally,

                      children: [
                        GetX<CompanyPostDetailsController>(
                            builder: (controller) {
                          return TextButton(
                            onPressed: () => _edit(widget.post),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.edit),
                                Text(
                                  "تعديل",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: controller.editable.value
                                        ? Colors.blueAccent
                                        //: Colors.grey,
                                        : Colors.grey.withOpacity(0.4),
                                  ),
                                ),
                              ],
                            ),
                          );
                          /*return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: controller.editable.value
                                    ? Colors.blueAccent
                                    //: Colors.grey,
                                    : Colors.grey
                                        .withOpacity(0.4), // Background color
                              ),
                              onPressed: () => _edit(widget.post),
                              child: const Text(
                                'تعديل',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: defaultFontSize,
                                    fontWeight: FontWeight.bold),
                              ));*/
                        }),
                        //  Padding(
                        //padding: const EdgeInsets.only(top: 16.0),
                        //child:

                        TextButton(
                          onPressed: () => showConfirmDeletingDialog(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              Text(
                                "حذف",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: int.parse(
                                              widget.post.acceptedApplicants) >
                                          0
                                      // ? Colors.grey
                                      ? Colors.grey.withOpacity(0.4)
                                      : Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    /*  ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary:
                                int.parse(widget.post.acceptedApplicants) > 0
                                    // ? Colors.grey
                                    ? Colors.grey.withOpacity(0.4)
                                    : Colors.redAccent, // Background color
                          ),
                          onPressed: () => showConfirmDeletingDialog(context),
                          child: const Text(
                            'حذف',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: defaultFontSize,
                                fontWeight: FontWeight.bold),
                          )),*/
                    //),
                  ],
                ),
              ),
            ),
            GetX<CompanyPostDetailsController>(builder: (controller) {
              return Visibility(
                  visible: controller.isLoading.value,
                  child: const SizedBox(
                    height: 80,
                    width: 80,
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      elevation: 8,
                      child: Center(
                        child: SpinKitRing(color: kPrimaryColor, size: 32.0),
                      ),
                    ),
                  ));
            }),
          ],
        ),
      ),
    );
  }

  String _getDate(String date) {
    String output = "";
    final fields = date.split('-');
    output = "${fields[2]}/${fields[1]}/${fields[0].substring(2)}";
    return output;
  }

  void showConfirmDeletingDialog(BuildContext context) {
    if (int.parse(widget.post.acceptedApplicants) > 0) {
      Fluttertoast.showToast(
          msg: "لاتستطيع حذف منشور لديه طلبات مسندة",
          backgroundColor: Colors.redAccent,
          toastLength: Toast.LENGTH_LONG,
          textColor: kFillColor);

      return;
    }
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
                    const SizedBox(height: 10),
                    const Text(
                      "هل أنت متأكد برغبتك بحذف هذا المنشور؟",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () => Get.back(),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.grey, elevation: 0),
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
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.back();
                              _delete(widget.post);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red, elevation: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "حذف",
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

  void _edit(Post post) async {
    final controller = Get.find<CompanyPostDetailsController>();

    if (controller.editable.value) {
      Get.to(() => EditPostScreen(post: post));
    } else {
      Fluttertoast.showToast(
          msg: "لاتستطيع تعديل منشور لديه طلبات بالفعل",
          backgroundColor: Colors.redAccent,
          toastLength: Toast.LENGTH_LONG,
          textColor: kFillColor);
    }
  }

  void _delete(Post post) async {
    if (int.parse(post.acceptedApplicants) > 0) {
      Fluttertoast.showToast(
          msg: "لاتستطيع حذف منشور لديه طلبات مسندة",
          backgroundColor: Colors.redAccent,
          toastLength: Toast.LENGTH_LONG,
          textColor: kFillColor);

      return;
    }

    final controller = Get.find<CompanyPostDetailsController>();

    controller.isLoading.value = true;

    post.offerStatus = "deleted";

    await PostDatabase().updatePostDetails({
      'id': post.id,
      'offerStatus': post.offerStatus,
    });

    await OrderDatabase().deleteAll(post.id, post.title, post.companyName);

    controller.isLoading.value = false;

    Fluttertoast.showToast(
        msg: "تم حذف المنشور",
        backgroundColor: Colors.black54,
        toastLength: Toast.LENGTH_LONG,
        textColor: kFillColor);

    Get.back();
  }

  void _getEditable(Post post) async {
    final controller = Get.find<CompanyPostDetailsController>();

    final result = await OrderDatabase().getOrders(post.id);

    controller.isLoading.value = false;

    controller.editable.value = result.isEmpty;
  }

  _buttonColor() {
    if (int.parse(widget.post.acceptedApplicants) < 0) {
      return Colors.grey.withOpacity(0.4);
    } else {
      return kPrimaryColor;
    }
  }
}

class CompanyPostDetailsController extends UserController {
  RxBool editable = false.obs;
}
