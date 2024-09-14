import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enhanced_future_builder/enhanced_future_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/course.dart';
import '../utils/color_utility.dart';
import '../utils/image_utility.dart';
import '../views/Courses/course_details_view.dart';

class CoursesHeadersWidget extends StatefulWidget {

  const CoursesHeadersWidget({super.key});

  @override
  State<CoursesHeadersWidget> createState() => _CoursesHeadersWidgetState();
}

class _CoursesHeadersWidgetState extends State<CoursesHeadersWidget> {
  late Future<QuerySnapshot<Map<String, dynamic>>> query;
  @override
  void initState() {
    query = FirebaseFirestore.instance
        .collection('courses')
        .get();

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

        return Container(
          height:500,
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: FadeInUp(
                  child: Container(
                    height: kIsWeb? 105.23:  90.23,
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
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        courses[index].title ?? '',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Noto Sans'
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.perm_identity,
                            size: 15.5,
                          ),
                          Text(courses[index].instructor!.name.toString(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Noto Sans',
                                  fontWeight: FontWeight.w400,
                                  color: ColorUtility.kBlack)),
                        ],
                      ),

                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, CourseDetailsView.id,
                      arguments: courses[index]);
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 10,
            ),
            itemCount: courses.length,
          ),
        );
      },
    );
  }
}
