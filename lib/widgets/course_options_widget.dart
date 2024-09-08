import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/course/course_bloc.dart';
import '../models/course.dart';
import '../models/lecture.dart';
import '../utils/app_enums.dart';
import '../utils/color_utility.dart';

class CourseOptionsWidgets extends StatefulWidget {
  final CourseOptions courseOption;
  final Course course;
  final void Function(Lecture) onLectureChosen;
  const CourseOptionsWidgets(
      {required this.courseOption,
        required this.course,
        required this.onLectureChosen,
        super.key});

  @override
  State<CourseOptionsWidgets> createState() => _CourseOptionsWidgetsState();
}

class _CourseOptionsWidgetsState extends State<CourseOptionsWidgets> {
  late Future<QuerySnapshot<Map<String, dynamic>>> futureCall;

  @override
  void initState() {
    init();
    super.initState();
  }

  List<Lecture>? lectures;
  bool isLoading = false;
  void init() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(milliseconds: 1200), () async {});
    if (!mounted) return;
    lectures = await context.read<CourseBloc>().getLectures();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        isLoading = false;
      });
    });
  }

  Lecture? selectedLecture;

  @override
  Widget build(BuildContext context) {
    switch (widget.courseOption) {
      case CourseOptions.lecture:
        if (isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (lectures == null || (lectures!.isEmpty)) {
          return const Center(
            child: Text('No lectures found'),
          );
        } else {
          return GridView.count(
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            shrinkWrap: true,
            crossAxisCount: 2,
            children: List.generate(lectures!.length, (index) {
              return InkWell(
                onTap: () {
                  widget.onLectureChosen(lectures![index]);
                  selectedLecture = lectures![index];
                  setState(() {});
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: selectedLecture?.id == lectures![index].id
                        ? ColorUtility.secondary
                        : const Color(0xffE0E0E0),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Text(
                      lectures![index].title ?? 'No Name',
                      style: TextStyle(
                          color: selectedLecture?.id == lectures![index].id
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                ),
              );
            }),
          );
        }

      case CourseOptions.download:
        return const SizedBox.shrink();

      case CourseOptions.certificate:
        return const SizedBox.shrink();

      case CourseOptions.more:
        return const SizedBox.shrink();
      default:
        return Text('Invalid option ${widget.courseOption.name}');
    }
  }
}