import 'package:esaa/constants.dart';
import 'package:flutter/material.dart';

class appbar extends StatelessWidget {
  final Widget child;
  const appbar({
    Key? key,
    required this.child,
    this.topImage = "assets/images/main_top.png",
    this.bottomImage = "assets/images/login_bottom.png",
  }) : super(key: key);

  final String topImage, bottomImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 242, 242),
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/logoo.png',
                fit: BoxFit.cover,
              ),
            ),
            backgroundColor: kPrimaryColor,
            expandedHeight: 200,
            floating: true,
            snap: true,
            pinned: true,
          ),
        ],
        // ignore: prefer_const_constructors
        // backgroundColor: kPrimaryColor,
        //resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
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
              SafeArea(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
