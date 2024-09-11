
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PayMobWebView extends StatelessWidget {
  const PayMobWebView({super.key});
  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(
        url: WebUri("https://www.facebook.com"),
      ),
    );
  }
}