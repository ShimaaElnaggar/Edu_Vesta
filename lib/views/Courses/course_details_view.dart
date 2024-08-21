import 'package:flutter/material.dart';

class CourseDetailsView extends StatelessWidget {
  const CourseDetailsView({super.key});

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
            ),
          ),
        ],
      ),
    );
  }
}
