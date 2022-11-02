import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/apply/apply_screen.dart';
import 'package:esaa/screens/chat/chat.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:esaa/services/database/database.dart';
import 'package:esaa/services/notification.dart' as notification;
import '../../../app.dart';
import '../../profiles/companyProfileForJS2.dart';
import '../widgets/company_posts_for_job_seeker.dart';
import 'package:esaa/screens/companyProfileForJS.dart';

class PostDetails extends StatelessWidget {
  final Order? order;
  final Post post;
  final bool canApply;
  const PostDetails(
      {this.order, required this.post, this.canApply = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      title: const Text("تفاصيل المنشور",
          style: TextStyle(
              color: kPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis)),
      showLeading: true,
      showChat: order == null ? false : order!.orderStatus == "accepted",
      onChatPressed: () {
        Get.to(() => ConversationScreen(order: order!, post: post));
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
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
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(post.imgUrl),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      post.title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.fade),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            color: kSPrimaryColor, size: 15),
                        Text(post.city,
                            style: const TextStyle(
                                color: KGrey,
                                fontSize: defaultFontSize,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'الشركة:',
                          style: const TextStyle(
                              color: kSPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        ),
                        InkWell(
                            onTap: () => Get.to(() =>
                                ProfileScreenForJS2(companyID: post.companyID)),
                            child: Text(
                              post.companyName,
                              style: const TextStyle(
                                  color: KGrey,
                                  decoration: TextDecoration.underline,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis),
                            )),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      '   وصف العمل :\n ${post.description}',
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.payments,
                          color: kSPrimaryColor,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${post.payPerHour} لكل ساعة عمل',
                          style: const TextStyle(
                              color: KGrey,
                              fontSize: defaultFontSize,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.hourglass_bottom_outlined,
                          color: kSPrimaryColor,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${post.nHours}  ساعات  ',
                          style: const TextStyle(
                              color: KGrey,
                              fontSize: defaultFontSize,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_month_outlined,
                            color: kSPrimaryColor, size: 20),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${_getDate(post.startDate)} - ${_getDate(post.endDate)}',
                          style: const TextStyle(
                              color: KGrey,
                              fontSize: defaultFontSize,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.fade),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          color: kSPrimaryColor,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          post.time,
                          style: const TextStyle(
                              color: KGrey,
                              fontSize: defaultFontSize,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                const SizedBox(
                  height: 35,
                  width: 30,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          ' عدد الموظفين المطلوب :',
                          style: const TextStyle(
                              color: KGrey,
                              fontSize: defaultFontSize,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.fade),
                        ),
                        Text(
                          '${post.maxNoOfApplicants}',
                          style: const TextStyle(
                              color: KGrey,
                              fontSize: defaultFontSize,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.fade),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                if (canApply)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: ElevatedButton(
                        onPressed: () => Get.to(() => ApplyScreen(post: post)),
                        child: const Text('التقديم على الوظيفة')),
                  ),
                if (order != null &&
                    order!.orderStatus == 'accepted' &&
                    order!.userID == App.user.id)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: _buttonColor(),
                        ),
                        onPressed: () => _sendPayReminder(post),
                        child: const Text(
                          'إنهاء الفترة ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: defaultFontSize,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                if (Get.find<UserController>().user.value.userType ==
                    "jobSeeker")
                  TextButton(
                      onPressed: () => Get.to(() =>
                          CompanyPostsForJobSeeker(companyID: post.companyID)),
                      child: const Text('لمزيدٍ من عروض هذه الشركه اضغط هنا ')),
              ],
            ),
          ),
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

  Future<void> _sendPayReminder(Post post) async {
    final user = await UserDatabase(post.companyID).getUser(post.companyID);
    //final jobSeekerName= await OrderDatabase().
    if (user == null) {
      Fluttertoast.showToast(
          msg: "Could not get company details, try again later",
          backgroundColor: Colors.redAccent,
          textColor: kFillColor);

      return;
    }

    var now = DateTime.now();
    var nMon = now.month;
    var nDay = now.day;
    var nYear = now.year;
    var postDate = DateTime.parse(post.startDate);

    var postMon = postDate.month;
    var postDay = postDate.day;
    var postYear = postDate.year;
    if (nYear != postYear) {
      Fluttertoast.showToast(
          msg: "لايمكنك إنهاء الفترة اللآن حاول لاحقاً بعد تاريخ العمل.",
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black54,
          textColor: kFillColor,
          toastLength: Toast.LENGTH_LONG);
      return;
    }
    if (nMon != postMon) {
      Fluttertoast.showToast(
          msg: "لايمكنك إنهاء الفترة اللآن حاول لاحقاً بعد تاريخ العمل",
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black54,
          textColor: kFillColor,
          toastLength: Toast.LENGTH_LONG);
      return;
    }
    if (nDay < postDay) {
      Fluttertoast.showToast(
          msg: "لايمكنك إنهاء الفترة اللآن حاول لاحقاً بعد تاريخ العمل.",
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black54,
          textColor: kFillColor,
          toastLength: Toast.LENGTH_LONG);
      return;
    }

    if (post.hasBeenDone) {
      Fluttertoast.showToast(
          msg: "لقد قمت بإنهاء الفترة بالفعل",
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black54,
          textColor: kFillColor,
          toastLength: Toast.LENGTH_LONG);
      return;
    }
    post.hasBeenDone = true;

    await PostDatabase().updatePostDetails({
      "id": post.id,
      "hasBeenDone": post.hasBeenDone,
    });
    await notification.Notification().sendNotification(
        user,
        PushNotification(
            title: " تدكير بالدفع",
            body: "يمكنك الدفع للموظف ${order!.userName}"));
  }

  _buttonColor() {
    var now = DateTime.now();
    var nMon = now.month;
    var nDay = now.day;
    var nYear = now.year;
    var postDate = DateTime.parse(post.startDate);

    var postMon = postDate.month;
    var postDay = postDate.day;
    var postYear = postDate.year;
    if (nYear != postYear) {
      return Colors.grey.withOpacity(0.4);
    } else if (nMon != postMon) {
      return Colors.grey.withOpacity(0.4);
    } else if (nDay < postDay) {
      //return Colors.grey.withOpacity(0.4);
      return Colors.grey.withOpacity(0.4);
    } else if (post.hasBeenDone) {
      //return Colors.grey.withOpacity(0.4);
      return Colors.grey.withOpacity(0.4);
    }
  }
}
