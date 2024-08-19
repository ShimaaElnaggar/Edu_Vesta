import 'package:edu_vesta/utils/color_utility.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;
  final double? width;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? horizontal;
  const CustomElevatedButton(
      {required this.onPressed,
      required this.child,
      this.width,
      this.backgroundColor = Colors.blue,
      this.foregroundColor = Colors.white,
      this.horizontal = 16.0,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: horizontal ?? 20),
      child: SizedBox(
        width: width,
        height: 52,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor ?? ColorUtility.secondary,
              foregroundColor: foregroundColor ?? Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: child),
      ),
    );
  }
}
