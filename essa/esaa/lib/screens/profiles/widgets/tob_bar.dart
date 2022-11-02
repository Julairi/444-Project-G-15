import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../config/constants.dart';
import '../../../controllers/user_controller.dart';
import '../../../services/authentication.dart';

class TopBar extends StatelessWidget {
  final bool logout;
  const TopBar({Key? key, required this.logout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          logout
              ? IconButton(
                  onPressed: () async {
                    Get.find<UserController>().clearAll();
                    Get.find<UserController>().changePage(2);
                    await Auth().signOut();
                    Get.toNamed('/login_screen');
                  },
                  icon: const Icon(
                    Icons.logout_sharp,
                    color: Colors.black,
                    size: 30,
                  ))
              : IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
        ],
      ),
    );
  }
}
