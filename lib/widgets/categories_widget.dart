import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vesta/views/Categories/show_category_courses.dart';
import 'package:enhanced_future_builder/enhanced_future_builder.dart';
import 'package:flutter/material.dart';
import '../models/category.dart';
import '../utils/color_utility.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: EnhancedFutureBuilder(
          future: FirebaseFirestore.instance.collection('categories').get(),
          rememberFutureResult: false,
          whenWaiting: const Center(child: CircularProgressIndicator()),
          whenError: (snapshot) {
            return Text(
              'Error: ${snapshot.toString()}',
              style: const TextStyle(color: Colors.red),
            );
          },
          whenNotDone: const Text('No categories available'),
          whenDone: (dynamic snapshot) {
            List<Category> categories = (snapshot as QuerySnapshot)
                .docs
                .map((doc) => Category.fromJson({
                      'id': doc.id,
                      ...(doc.data() as Map<String, dynamic>? ?? {}),
                    }))
                .toList();
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async{
                    var result = FirebaseFirestore.instance.collection('courses')
                        .where('category.id',isEqualTo: categories[index].id);
                    Navigator.pushReplacementNamed(context, ShowCategoryCoursesView.id);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: ColorUtility.lightGrey,
                    ),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(categories[index].name ?? ' No Category',
                        style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                    )),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                width: 10,
              ),
              itemCount: categories.length,
            );
          }),
    );
  }
}

