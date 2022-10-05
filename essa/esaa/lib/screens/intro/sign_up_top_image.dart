import 'package:esaa/config/constants.dart';
import 'package:flutter/material.dart';

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
          style: const TextStyle(
            fontSize: 20,
            color: kPrimaryColor,
          ),
        ),
        const SizedBox(
          height: defaultPadding,
        ),
      ],
    );
  }
}
