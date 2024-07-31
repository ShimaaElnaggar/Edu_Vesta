
import 'package:edu_vesta/utils/color_utility.dart';
import 'package:flutter/material.dart';

class DotsIndicator extends StatelessWidget {
  final bool  isActive;
  const DotsIndicator({
    required this.isActive,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 5,
        width: 30,
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(20),
          color: isActive ? ColorUtility.secondary: ColorUtility.meduimBlack,
        ),
      ),
    );
  }
}