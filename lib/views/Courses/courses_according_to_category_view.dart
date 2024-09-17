import 'package:edu_vesta/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import '../../models/course.dart';
import '../../widgets/courses/courses_widget.dart';

class CoursesAccordingToCategoryView extends StatelessWidget {
  static const id = 'courses_according_to_category';
  final List<Course>? courses;
  final String category;
  const CoursesAccordingToCategoryView(
      {required this.category, this.courses, super.key});

  @override
  Widget build(BuildContext context) {
    List<Course> filteredCourses = courses?.where((course) => course.category == category).toList() ?? [];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            SizedBox(height: 20.0),
            HeaderWidget(title: category ),
            SizedBox(height: 20.0),
            CoursesWidget(category: category,
              courses: filteredCourses,
            ),
          ],
        ),
      ),
    );
  }
}
