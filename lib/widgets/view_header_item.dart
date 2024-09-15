
import 'package:flutter/material.dart';

import '../utils/color_utility.dart';
import 'cart_Icon.dart';

class ViewHeaderItem extends StatelessWidget {
  final String title;
  const ViewHeaderItem({required this.title,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 40),
        Text(
          title,
          style: TextStyle(
              color: ColorUtility.midBlack,
              fontWeight: FontWeight.w700,
              fontSize: 20),
        ),
        const CartIcon(),
      ],
    );
  }
}
