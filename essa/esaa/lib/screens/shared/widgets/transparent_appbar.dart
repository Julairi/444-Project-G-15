import 'package:esaa/config/constants.dart';
import 'package:flutter/material.dart';

class TransparentAppbar extends StatelessWidget {
  final Widget child;
  const TransparentAppbar({
    Key? key,
    required this.child,
    this.topImage = "assets/images/main_top.png",
    this.bottomImage = "assets/images/login_bottom.png",
  }) : super(key: key);

  final String topImage, bottomImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 239, 242, 242),
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        leading: const BackButton(
          color: kPrimaryColor,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      // backgroundColor: kPrimaryColor,
      //resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            /* Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                topImage,
                width: 120,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(bottomImage, width: 120),
            ), */
            Scaffold(
                appBar: AppBar(
                  leading: const SizedBox(),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                backgroundColor: Colors.transparent,
                body: child),
          ],
        ),
      ),
    );
  }
}
