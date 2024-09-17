import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import '../../models/course.dart';
import '../../utils/color_utility.dart';
import '../../utils/image_utility.dart';
import '../../views/Courses/course_details_view.dart';
import 'star_rating_widget.dart';

class CoursesWidget extends StatefulWidget {
  final bool limitCourses;
  final String? rankValue;
  final String? category;
  final List<Course>? courses;
  final double height;
  const CoursesWidget({
    this.rankValue,
    this.limitCourses = false,
    this.category,
    this.courses,
    this.height = kIsWeb? 105.23:  79.23,
    super.key});

  @override
  State<CoursesWidget> createState() => _CoursesWidgetState();
}

class _CoursesWidgetState extends State<CoursesWidget> {
  late Future<QuerySnapshot<Map<String, dynamic>>> futureCall;
  double rating = 0.0;
  @override
  void initState() {
    futureCall = FirebaseFirestore.instance
        .collection('courses')
        .where('rank', isEqualTo: widget.rankValue)
        .orderBy('created_date', descending: true)
        .get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureCall,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Error occurred'),
            );
          }

          if (!snapshot.hasData || (snapshot.data?.docs.isEmpty ?? false)) {
            return const Center(
              child: Text('No categories found'),
            );
          }

          var courses = List<Course>.from(snapshot.data?.docs
              .map((e) => Course.fromJson({'id': e.id, ...e.data()}))
              .toList() ??
              []);

          if (widget.limitCourses) {
            courses = courses.take(2).toList();
          }
          return GridView.count(
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            shrinkWrap: true,
            crossAxisCount: 2,
            children: List.generate(courses.length, (index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, CourseDetailsView.id,
                          arguments: courses[index]);
                    },
                    child: FadeInUp(
                      child: Container(
                        height: widget.height,
                        width: 157.48 ,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: courses[index].image != null
                                ? NetworkImage(
                              courses[index].image!,
                            )
                                : AssetImage(ImageUtility.defaultCourse),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          courses[index].rating.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 10.4,
                              color: ColorUtility.kBlack),
                        ),
                      ),
                      StarRating(
                        rating: courses[index].rating!.toDouble(),
                        ratingChangeCallback: () {
                          setState(() {
                            rating = courses[index].rating!.toDouble();
                          });
                        },
                      ),
                    ],
                  ),
                  Text(
                    courses[index].title.toString(),
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: ColorUtility.kBlack),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(
                        Icons.perm_identity,
                        size: 15.5,
                      ),
                      Text(courses[index].instructor!.name.toString(),
                          style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: ColorUtility.kBlack)),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        courses[index].concurrency.toString(),
                        style: const TextStyle(
                          color: ColorUtility.primary,
                          fontSize: 13.54,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        courses[index].price.toString(),
                        style: const TextStyle(
                            color: ColorUtility.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ],
              );
            }),
          );
        });
  }
}