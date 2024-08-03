import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OnBoardArrows extends StatelessWidget {
  final void Function()? onPressed;
  final IconData? icon;
  final Color? color;
  const OnBoardArrows({
    required this.onPressed,
    required this.icon,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kIsWeb ? 42 : 60,
      width: kIsWeb ? 42 : 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.white,
          size: kIsWeb ? 22.5 : 30,
        ),
      ),
    );
  }
}
