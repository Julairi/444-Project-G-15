import 'package:esaa/Screens/stripePayment/cardFormScreen.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class payment extends StatefulWidget {
  const payment({
    Key? key,
  }) : super(key: key);
  stripePayment createState() => stripePayment();
}

class stripePayment extends State<payment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return CardFormScreen();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
              primary: kPrimaryLightColor, elevation: 0),
          child: Text(
            " اتمام عملية الدفع".toUpperCase(),
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
