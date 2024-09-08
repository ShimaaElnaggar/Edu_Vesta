
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enhanced_future_builder/enhanced_future_builder.dart';
import 'package:flutter/material.dart';

import '../../models/course.dart';
import '../../utils/color_utility.dart';
import '../../widgets/star_rating_widget.dart';
import '../Courses/course_details_view.dart';

class ShowCategoryCoursesView extends StatefulWidget {
  static const String id = 'show_category_courses';
  final String rankValue;
  const ShowCategoryCoursesView({super.key, required this.rankValue,});

  @override
  State<ShowCategoryCoursesView> createState() => _ShowCategoryCoursesViewState();
}

class _ShowCategoryCoursesViewState extends State<ShowCategoryCoursesView> {
  double rating = 0.0;
  @override
  Widget build(BuildContext context) {

   return EnhancedFutureBuilder(
      future: _futureToResolve(),
      rememberFutureResult: false,
      whenWaiting: const Center(child: CircularProgressIndicator()),
      whenError:  (snapshot) {
        return Text(
          'Error: ${snapshot.toString()}',
          style: const TextStyle(color: Colors.red),
        );
      },
      whenNotDone: const Text('No courses available'),
      whenDone: (dynamic snapshot) {
        List<Course> courses = (snapshot as QuerySnapshot).docs
            .map((doc) => Course.fromJson({
          'id': doc.id,
          ...(doc.data() as Map<String, dynamic>? ?? {}),
        }))
            .toList();
        return GridView.count(
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          shrinkWrap: true,
          crossAxisCount: 2,
          children: List.generate(courses.length, (index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, CourseDetailsView.id,
                    arguments: courses[index]);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Image.network(
                          courses[index].image!,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.grey, // Placeholder color
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: const Center(
                                child: Text('Image Load Error',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            );
                          })),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          courses[index].rating.toString(),
                          style: const TextStyle(fontWeight:FontWeight.w600,fontSize:11.4,color: ColorUtility.kBlack),),
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
                        fontSize: 15, fontWeight: FontWeight.w600,color: ColorUtility.kBlack),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.perm_identity,size: 17.5,),
                      Text(courses[index].instructor!.name.toString(),
                          style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: ColorUtility.kBlack)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        courses[index].concurrency.toString(),
                        style: const TextStyle(
                          color: ColorUtility.primary,
                          fontSize: 17.54,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        courses[index].price.toString(),
                        style: const TextStyle(
                            color: ColorUtility.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
  Future<QuerySnapshot>  _futureToResolve() {
    return FirebaseFirestore.instance
        .collection('courses')
        .where('rank', isEqualTo: widget.rankValue)
//.orderBy('created_date', descending: true)
        .get();
  }
}
