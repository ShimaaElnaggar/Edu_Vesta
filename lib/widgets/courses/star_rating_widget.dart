import 'package:edu_vesta/utils/color_utility.dart';
import 'package:flutter/material.dart';



class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final void Function() ratingChangeCallback;


  const StarRating({super.key,
    this.starCount = 5,
    this.rating = 0.0,
    required this.ratingChangeCallback

  });

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = const Icon(
        Icons.star_border,
        color: ColorUtility.primary,
        size: 11.4,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = const Icon(
        Icons.star_half,
        color: ColorUtility.primary,
        size: 11.4,
      );
    } else {
      icon = const Icon(
        Icons.star,
        color: ColorUtility.primary,
        size: 11.4,
      );
    }
    return InkResponse(
      onTap: () {
        ratingChangeCallback();
      },
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(starCount, (index) => buildStar(context, index)),
    );
  }
}