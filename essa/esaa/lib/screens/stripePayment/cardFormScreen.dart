import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

import '../../config/constants.dart';

class CardFormScreen extends StatelessWidget {
  const CardFormScreen({
    Key? key,
  }) : super(key: key);

  //initPayment function
  Future<void> initPayment(
      {required String email,
      required double amount,
      required BuildContext context}) async {
    try {
      // 1. Create a payment intent on the server
      final response = await http.post(
          Uri.parse(
              'https://us-central1-esaa-c4278.cloudfunctions.net/stripePaymentIntentRequest'),
          body: {
            'email': email,
            'amount': amount.toString(),
          });
      // Stripe.merchantIdentifier
      final jsonResponse = jsonDecode(response.body);
      log(jsonResponse.toString());
      // 2. Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: jsonResponse['paymentIntent'],
        merchantDisplayName: 'Esaa Flutter App',
        customerId: jsonResponse['customer'],
        customerEphemeralKeySecret: jsonResponse['ephemeralKey'],

        //testEnv: true,
        //merchantCountryCode: 'US',
      ));
      await Stripe.instance.presentPaymentSheet();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم الدفع بنجاح'),
        ),
      );
    } catch (errorr) {
      if (errorr is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطآ في ${errorr.error.localizedMessage}'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ في $errorr'),
          ),
        );
      }
    }
  }
  //end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        onPressed: () async {
          await initPayment(
              amount: 200.0, context: context, email: 'email@test.com');
        },
        style: ElevatedButton.styleFrom(primary: kPrimaryColor),
        child: const Text('ادفع'),
      )),
    );
  }
}
