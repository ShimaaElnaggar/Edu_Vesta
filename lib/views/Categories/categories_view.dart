import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vesta/widgets/courses_widget.dart';
import 'package:edu_vesta/widgets/expansion_list_tile_widget.dart';
import 'package:edu_vesta/widgets/header_widget.dart';
import 'package:flutter/material.dart';

import '../../models/course.dart';

class CategoriesView extends StatefulWidget {
  static const id = 'categories_view';

  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            HeaderWidget(title: 'Categories'),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('categories')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: snapshot.data!.docs.map((doc) {
                      return ExpansionListTileWidget(
                        title: doc['name'],
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('courses')
                              .where('category', isEqualTo: doc['name'])
                              .snapshots(),
                          builder: (context, courseSnapshot) {
                            if (!courseSnapshot.hasData) {
                              return const CircularProgressIndicator();
                            }

                            return CoursesWidget(
                              courses:
                                  courseSnapshot.data!.docs.map((courseDoc) {
                                return Course.fromJson({
                                  'id': courseDoc.id,
                                  ...(courseDoc.data()
                                          as Map<String, dynamic>? ??
                                      {}),
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
