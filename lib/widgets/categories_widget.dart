import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../models/category.dart';
import '../utils/color_utility.dart';
import '../views/Courses/courses_according_to_category_view.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  var futureCall = FirebaseFirestore.instance.collection('categories').get();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        child: FutureBuilder(
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

              var categories = List<Category>.from(snapshot.data?.docs
                      .map((e) => Category.fromJson({'id': e.id, ...e.data()}))
                      .toList() ??
                  []);

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      Navigator.pushNamed(
                          context, CoursesAccordingToCategoryView.id,
                          arguments: {
                            'category': categories[index].name,
                          });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: ColorUtility.lightGrey,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            categories[index].name ?? ' No Category',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(width: 10),
                itemCount: categories.length,
              );
            }));
  }
}
