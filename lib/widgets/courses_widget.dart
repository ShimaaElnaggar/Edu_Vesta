import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vesta/utils/color_utility.dart';
import 'package:edu_vesta/widgets/star_rating_widget.dart';
import 'package:enhanced_future_builder/enhanced_future_builder.dart';
import 'package:flutter/material.dart';
import '../models/course.dart';
import '../views/Courses/course_details_view.dart';

class CoursesWidget extends StatefulWidget {
  final String rankValue;

  const CoursesWidget({required this.rankValue, super.key});

  @override
  State<CoursesWidget> createState() => _CoursesWidgetState();
}

class _CoursesWidgetState extends State<CoursesWidget> {
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
                    child: courses[index].image!.isNotEmpty
                        ? Image.network(
                      courses[index].image!,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    )
                        : const Text('No Image Available'),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(courses[index].rating.toString()),
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
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.perm_identity),
                      Text(courses[index].instructor!.name.toString(),
                          style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        courses[index].concurrency.toString(),
                        style: const TextStyle(color: ColorUtility.primary),
                      ),
                      Text(
                        courses[index].price.toString(),
                        style: const TextStyle(color: ColorUtility.primary),
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
//.where('rank', isEqualTo: widget.rankValue)
//.orderBy('created_date', descending: true)
        .get();
  }
}

