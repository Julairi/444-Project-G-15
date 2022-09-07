import 'package:flutter/material.dart';

import '../../../constants.dart';

class SignUpScreenTopImage extends StatelessWidget {
  const SignUpScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "قم بإنشاء حسابك".toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: kPrimaryColor,
          ),
        ),
        SizedBox(
          height: defaultPadding,
        ),
      ],
    );
  }
}
