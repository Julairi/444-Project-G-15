import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/job_seeker_home/view/post_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:get/get.dart';
import '../../../app.dart';
import '../../../models/models.dart';
import '../../../models/post.dart';
import '../../../services/database/post_database.dart';

class PostCardJobSeeker extends StatelessWidget {
  final Post post;
  final bool canApply;

  PostCardJobSeeker({required this.post, this.canApply = true, Key? key})
      : super(key: key) {
    Get.put(PostCardController());
    Get.find<PostCardController>().bindUserWithID(post.id);
  }
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PostCardController>();
    return InkWell(
        onTap: () => Get.to(() => PostDetails(post: post, canApply: canApply)),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 7,
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                    width: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        height: 10,
                        width: 20,
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(post.imgUrl),
                      ),
                      const SizedBox(
                        height: 20,
                        width: 20,
                      ),
                      Text(
                        post.title,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 6, 6, 6),
                            fontSize: 18,
                            fontFamily: 'ElMessiri',
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.fade),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 90,
                      ),
                      const Icon(
                        Icons.location_on,
                        color: KGrey,
                        size: 20,
                      ),
                      Text(post.city,
                          style: const TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.fade))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    if (controller.saved.value == false) {
                      _save(post, controller);
                    } else if (controller.saved == true) {
                      _unsave(post, controller);
                    }
                  },
                  icon: Icon(Icons.bookmark_border_outlined)),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ));
  }

  void _save(Post post, PostCardController controller) async {
    await PostDatabase().updatePostDetails({
      "id": post.id,
      "saved": FieldValue.arrayUnion([App.user.id])
    });
    controller.saved.value = true;
  }
}

void _unsave(Post post, PostCardController controller) async {
  await PostDatabase().updatePostDetails({
    "id": post.id,
    "saved": FieldValue.arrayRemove([App.user.id])
  });
  controller.saved.value = false;
}

class PostCardController extends UserController {
  RxBool saved = false.obs;
}
