
import 'package:flutter/material.dart';

import '../utils/color_utility.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back_ios_new,
        color: ColorUtility.primary,
      ),
    );
  }
}
