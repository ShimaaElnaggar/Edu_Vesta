import 'package:edu_vesta/widgets/courses/courses_widget.dart';
import 'package:edu_vesta/widgets/header_widget.dart';
import 'package:flutter/material.dart';

class TopCoursesView extends StatelessWidget {
  static const id = 'top_courses';
  const TopCoursesView({super.key});

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
            HeaderWidget(title: 'Top Courses'),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CoursesWidget(
                    rankValue: 'top_rated',
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
