
import 'package:edu_vesta/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:paymob_payment/paymob_payment.dart';
import '../../utils/color_utility.dart';

class PaymentMethodsView extends StatefulWidget {
  static const id = 'payment_method';
  const PaymentMethodsView({super.key});

  @override
  State<PaymentMethodsView> createState() => _PaymentMethodsViewState();
}

class _PaymentMethodsViewState extends State<PaymentMethodsView> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderWidget(title: 'Payment Method'),
            const SizedBox(
              height: 15,
            ),
            const Center(
              child: Text(
                'Select your Payment Method',
                style: TextStyle(
                    color: Color(0xFF1F1F1F),
                    fontWeight: FontWeight.w500,
                    fontSize: 11),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            payMobMethod(context),
            ListTile(
              title: const Text('PayPal'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Apple Pay'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Container payMobMethod(BuildContext context) {
    return Container(
            decoration: BoxDecoration(
              color: isExpanded ? Colors.white : ColorUtility.midGrey,
              borderRadius: BorderRadius.circular(8),
              border: isExpanded
                  ? Border.all(
                      color: ColorUtility.secondary,
                    )
                  : const Border.symmetric(
                      vertical: BorderSide.none, horizontal: BorderSide.none),
            ),
            child: ListTile(
              leading: const Text(
                'PayMob',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
              ),
              trailing: Icon(
                Icons.adjust_outlined,
                color: isExpanded ? ColorUtility.secondary : Colors.white,
              ),
              onTap: () async {
                setState(() {
                  isExpanded = !isExpanded;
                });
                await accessingToPayMobGate(context);
              },
            ),
          );
  }

  Future<void> accessingToPayMobGate(BuildContext context) async {
    String? apiKey = dotenv.env['apiKey'];
    String? integrationID = dotenv.env['integrationID'];
    String? iFrameID = dotenv.env['iFrameID'];

    if (apiKey != null && integrationID != null && iFrameID != null) {
      PaymobPayment.instance.initialize(
        apiKey: apiKey,
        integrationID: int.parse(integrationID),
        iFrameID: int.parse(iFrameID),
      );

      final PaymobResponse? response = await PaymobPayment.instance.pay(
        context: context,
        currency: "EGP",
        amountInCents: "20000", // 200 EGP
      );

      if (response != null) {
        print('Response: ${response.transactionID}');
        print('Response: ${response.success}');
      }
    } else {
      print('Error: One or more environment variables are null.');
    }
  }
}
