import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vesta/widgets/courses/courses_widget.dart';
import 'package:edu_vesta/widgets/expansion_list_tile_widget.dart';
import 'package:edu_vesta/widgets/header_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/course.dart';


class CategoriesView extends StatefulWidget {
  static const id = 'categories_view';

  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  String? category;
  Course? course;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            SizedBox(height: 20,),
            HeaderWidget(title: 'Categories'),
            SizedBox(height: 10,),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('categories')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: const CircularProgressIndicator());
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: snapshot.data!.docs.map((doc) {
                      return ExpansionListTile(
                        title: doc['name'],
                        child:StreamBuilder<QuerySnapshot>(
                          stream: category != null
                              ? FirebaseFirestore.instance.collection('courses')
                              .doc(course?.id!).snapshots() as Stream<QuerySnapshot<Object?>>?
                              : FirebaseFirestore.instance.collection('courses').snapshots(),
                          builder: (context, courseSnapshot) {
                            if (!courseSnapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            return CoursesWidget(
                              height: kIsWeb? 100.23:  63.23,
                              category: category,
                              courses: courseSnapshot.data!.docs.map((courseDoc) {
                                return Course.fromJson({
                                  'id': courseDoc.id,
                                  ...(courseDoc.data() as Map<String, dynamic>? ?? {}),
                                });
                              }).toList(),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
