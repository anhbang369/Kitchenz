import 'dart:convert';

import 'package:firstapp/pages/menu.dart';
import 'package:firstapp/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Thanh toán'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            color: Colors.deepOrange,
          ),
        ),
      ),
      body: FutureBuilder(
          future: ApiService.getCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isVip == true) {
                return const Center(
                    child: Text('Bạn đã là thành viên Premium'));
              } else {
                return Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                              right: 15, left: 15, top: 20),
                          child: Image.network(
                              'https://img.icons8.com/nolan/96/cash-receipt.png'),
                        ),
                      ),
                      Text(
                        'Premium',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..shader = const LinearGradient(
                              colors: [Colors.blue, Colors.orange],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(const Rect.fromLTWH(0, 0, 200, 40)),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                              right: 30, left: 30, top: 30),
                          child: const Text(
                            'Mang đến cho bạn những trãi nghiệm tốt nhất, cũng như được cung cấp một số đặc quyền chỉ dành cho thành viên Premium',
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ),
                      ),
                      const Text(
                        '60.000 VND',
                        style:
                            TextStyle(fontSize: 50, color: Colors.deepOrange),
                      ),
                      const Text(
                        'Thanh toán 30 ngày một lần',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 45, vertical: 50),
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () async {
                            await makePayment();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateColor.resolveWith((states) {
                              return Colors.deepOrange;
                            }),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Thanh toán',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent('60000', 'VND');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
                  // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Adnan'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        ApiService.updateVip().then((user) {
          if (user.isVip == true) {
            showDialog(
              context: context,
              builder: (_) => const AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        Text("Thanh toán thành công"),
                      ],
                    ),
                  ],
                ),
              ),
            );
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Menu(title: '')));
          }
        }).catchError((error) {
          showDialog(
            context: context,
            builder: (_) => const AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                      Text("Cập nhật user thất bại"),
                    ],
                  ),
                ],
              ),
            ),
          );
        });

        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51N1idNG02NFclnWKeUJsxyW6AxxvqxpPqtnIYwtp4MatOraH5ouvLMXSEQDSsUEBSwGeFrkPBIiTgouXFO735f2h003JannDdP',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 1;
    return calculatedAmout.toString();
  }
}
