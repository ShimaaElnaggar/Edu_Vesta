
import 'package:flutter/material.dart';

import '../utils/color_utility.dart';
import 'arrow_back.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  const HeaderWidget({required this.title,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ArrowBack(),
        Center(
          child: Text(
            title,
            style: TextStyle(
              color: ColorUtility.midBlack,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(width: 40),
      ],
    );
  }
}
