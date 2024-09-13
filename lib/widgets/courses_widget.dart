import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vesta/utils/color_utility.dart';
import 'package:edu_vesta/utils/image_utility.dart';
import 'package:edu_vesta/widgets/star_rating_widget.dart';
import 'package:enhanced_future_builder/enhanced_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/course.dart';
import '../views/Courses/course_details_view.dart';
import 'package:animate_do/animate_do.dart';

class CoursesWidget extends StatefulWidget {
  final String? rankValue;
  final bool limitCourses;
  final String? category;
  final List<Course>? courses;

  const CoursesWidget(
      {this.rankValue,
      this.limitCourses = false,
      this.category,
      this.courses,
      super.key});

  @override
  State<CoursesWidget> createState() => _CoursesWidgetState();
}

class _CoursesWidgetState extends State<CoursesWidget> {
  double rating = 0.0;
  late Future<QuerySnapshot<Map<String, dynamic>>> query;

  @override
  void initState() {
    if (widget.category != null) {
      query = FirebaseFirestore.instance
          .collection('courses')
          .where('rank', isEqualTo: widget.rankValue)
          .where('category',
              isEqualTo: FirebaseFirestore.instance
                  .doc('categories/${widget.category}'))
          .orderBy('created_date', descending: true)
          .get();
    } else {
      query = FirebaseFirestore.instance
          .collection('courses')
          .where('rank', isEqualTo: widget.rankValue)
          .orderBy('created_date', descending: true)
          .get();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EnhancedFutureBuilder(
      future: query,
      rememberFutureResult: true,
      whenWaiting: const Center(child: CircularProgressIndicator()),
      whenError: (snapshot) {
        return Text(
          'Error: ${snapshot.toString()}',
          style: const TextStyle(color: Colors.red),
        );
      },
      whenNotDone: const Text('No courses available'),
      whenDone: (dynamic snapshot) {
        List<Course> courses = (snapshot as QuerySnapshot)
            .docs
            .map((doc) => Course.fromJson({
                  'id': doc.id,
                  ...(doc.data() as Map<String, dynamic>? ?? {}),
                }))
            .toList();

        if (widget.limitCourses) {
          courses = courses.take(2).toList();
        }
        return GridView.count(
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          shrinkWrap: true,
          crossAxisCount: ScreenUtil().screenWidth > 760 ? 3 : 2,
          children: List.generate(courses.length, (index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, CourseDetailsView.id,
                    arguments: courses[index]);
              },
              child: Container(
                height: ScreenUtil().screenHeight,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInUp(
                        child: Container(
                          height: (ScreenUtil().screenHeight == 667)
                              ? 75
                              : (ScreenUtil().screenHeight == 896)
                                  ? 94
                                  : (ScreenUtil().screenHeight == 844)
                                      ? 82
                                      : (ScreenUtil().screenHeight == 932)
                                          ? 102
                                          : (ScreenUtil().screenHeight == 915)
                                              ? 93.5
                                              : (ScreenUtil().screenHeight ==
                                                      740)
                                                  ? 67.5
                                                  : (ScreenUtil()
                                                              .screenHeight ==
                                                          914)
                                                      ? 93
                                                      : (ScreenUtil()
                                                                  .screenHeight ==
                                                              1009)
                                                          ? 87
                                                          : (ScreenUtil()
                                                                      .screenHeight ==
                                                                  822)
                                                              ? 90
                                                              : 105.23,
                          width: 157.48,
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
                      const SizedBox(height: 3),
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
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
