import 'package:edu_vesta/models/course.dart';
import 'package:flutter/material.dart';

class CourseDetailsView extends StatefulWidget {
  static const id = 'Course Details';
  final Course course;
  const CourseDetailsView({required this.course,super.key});

  @override
  State<CourseDetailsView> createState() => _CourseDetailsViewState();
}

class _CourseDetailsViewState extends State<CourseDetailsView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Column(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height/3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue,
            ),
          ),
          Expanded(
            child:Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.yellow,
              ),
              child: Text(widget.course.title.toString()),
            ),
          ),
        ],
      ),
    );
  }
}
