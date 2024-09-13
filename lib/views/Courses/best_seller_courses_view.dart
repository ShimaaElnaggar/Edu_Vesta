import 'package:edu_vesta/widgets/courses_widget.dart';
import 'package:edu_vesta/widgets/header_widget.dart';
import 'package:flutter/material.dart';

class BestSellerCoursesView extends StatelessWidget {
  static const id = 'best_seller';
  const BestSellerCoursesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            HeaderWidget(title: 'Best Seller'),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CoursesWidget(
                    rankValue: 'best_seller',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
