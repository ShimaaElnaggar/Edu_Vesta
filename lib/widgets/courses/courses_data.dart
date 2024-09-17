import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../models/course.dart';
import '../../utils/color_utility.dart';
import '../../utils/image_utility.dart';
import '../../views/Courses/course_details_view.dart';
class CoursesData extends StatefulWidget {
  final double height;
  const CoursesData({
    this.height = kIsWeb? 105.23:  79.23,
    super.key});

  @override
  State<CoursesData> createState() => _CoursesDataState();
}

class _CoursesDataState extends State<CoursesData> {
  late Future<QuerySnapshot<Map<String, dynamic>>> futureCall;
  double rating = 0.0;
  @override
  void initState() {
    futureCall =  FirebaseFirestore.instance
        .collection('courses')
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
              child: Center(child: CircularProgressIndicator()),
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

          return Container(
            height:600,
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
        });
  }
}