
import 'package:edu_vesta/utils/color_utility.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  const CustomTextButton({required this.label, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Text(
            label,
            style:
            const TextStyle(color: ColorUtility.secondary, fontSize: 15),
          ),
        ));
  }
}