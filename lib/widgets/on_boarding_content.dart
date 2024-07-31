import 'package:edu_vesta/utils/color_utility.dart';
import 'package:flutter/material.dart';

class OnBoardingContent extends StatelessWidget {
  final String title, image, description;
  const OnBoardingContent({
    required this.title,
    required this.image,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            image,
            height: 200,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: ColorUtility.grey,
          ),
        ),

      ],
    );
  }
}
