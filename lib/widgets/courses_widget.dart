import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vesta/utils/color_utility.dart';
import 'package:edu_vesta/widgets/star_rating_widget.dart';
import 'package:flutter/material.dart';
import '../models/course.dart';

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
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('courses')
            //.where('rank', isEqualTo: widget.rankValue)
            //.orderBy('created_date', descending: true)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            //print('Error: ${snapshot.error}');
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Text('No courses found');
          }
          List courses = List<Course>.from(snapshot.data?.docs
                  .map((doc) => Course.fromJson({
                        'id': doc.id,
                        ...doc.data(),
                      }))
                  .toList() ??
              []);
          return GridView.count(
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            shrinkWrap: true,
            crossAxisCount: 2,
            children: List.generate(courses.length, (index) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      //color: ColorUtility.lightGrey,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: courses[index].image.isNotEmpty
                        ? Image.network(
                            courses[index].image,
                            height: 100,
                            width: 80,
                            fit: BoxFit.cover,
                          )
                        : const Text('No Image Available'),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(courses[index].rating),
                      StarRating(
                        rating: courses[index].rating,
                        ratingChangeCallback: () {
                          setState(() {
                            rating = courses[index].rating;
                          });
                        },
                      ),
                    ],
                  ),
                  Text(
                    courses[index].title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.perm_identity),
                      Text(courses[index].instructor.name,
                          style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        courses[index].concurrency,
                        style: const TextStyle(color: ColorUtility.primary),
                      ),
                      Text(
                        courses[index].price.toString(),
                        style: const TextStyle(color: ColorUtility.primary),
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
