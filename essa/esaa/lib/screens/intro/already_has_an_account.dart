import 'package:esaa/config/constants.dart';
import 'package:flutter/material.dart';

class AlreadyHasAnAccount extends StatelessWidget {

  final bool login;
  final Function? press;
  const AlreadyHasAnAccount({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "لايوجد لديك حساب ؟  " : "هل تملك حساب بالفعل؟",
          style: const TextStyle(
            color: kPrimaryColor,
            fontSize: 16,
          ),
        ),
        GestureDetector(
          onTap: press as void Function()?,
          child: Text(
            login ? "إنشاء حساب" : "تسجيل الدخول",
            style: const TextStyle(
              fontSize: 16,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
