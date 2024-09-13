import 'package:edu_vesta/widgets/header_widget.dart';
import 'package:flutter/material.dart';

import '../../models/category.dart';
import '../../models/course.dart';
import '../../widgets/courses_widget.dart';

class CoursesAccordingToCategoryView extends StatelessWidget {
  static const id = 'courses_according_to_category';
  final List<Course>? courses;
  final Category category;
  const CoursesAccordingToCategoryView(
      {required this.category, this.courses, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          HeaderWidget(title: category.name ?? ''),
          CoursesWidget(category: category.name),
        ],
      ),
    );
  }
}
