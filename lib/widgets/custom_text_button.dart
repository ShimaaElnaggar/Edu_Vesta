
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final TextStyle? textStyle;
  const CustomTextButton(
      {required this.label, required this.onPressed, super.key, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Text(
            label,
            style: textStyle,
        )));
  }
}
